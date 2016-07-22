/* 
 * Selene - 'Luna' plasmoid applet for displaying moon phases, 
 * with the logic rewritten from scratch.
 * 
 * Copyright 2016 Keith Zubot-Gephart <keithzg@gmail.com>
 * 
 * This program is free software; you can redistribute it and/or modify it
 * under the terms of copyleft-next (version 0.3.1 or later) as published
 * at http://copyleft-next.org.
*/
import QtQuick 2.0
import org.kde.plasma.components 2.0 as PlasmaComponents
import QtQuick.Layouts 1.1
import org.kde.plasma.core 2.0 as PlasmaCore
import org.kde.kquickcontrolsaddons 2.0 as QtExtra
import org.kde.plasma.plasmoid 2.0
import org.kde.plasma.extras 2.0 as PlasmaExtras
import org.kde.plasma.calendar 2.0 as PlasmaCalendar



Item {
	
	Plasmoid.backgroundHints: PlasmaCore.Types.NoBackground
	id: root
	width: 400
	height: 400
	
	property var locale: Qt.locale()
	readonly property date currentDate: dataSource.data.Local ? dataSource.data.Local.DateTime : new Date()
	property string dateString
	
		
	Image {
		id: moonBase
		source: "moon.svg"
		width: 400;
		height: 400;
		anchors.centerIn: parent
		z: 0;
		fillMode: Image.PreserveAspectFit
		sourceSize.width: 400
		sourceSize.height: 400
		smooth: true
	}
	
	Image {
		id: moonOverlay
		source: "14.svg"
		width: 348;
		height: 348;
		anchors.centerIn: parent
		z: 1;
		fillMode: Image.PreserveAspectFit
		sourceSize.width: 400
		sourceSize.height: 400
		smooth: true
	}
	
	// from http://www.ben-daglish.net/moon.shtml
	function simpleMoon(year,month,day) {
		var lp = 2551443; 
		var now = new Date(year,month-1,day,20,35,0);						
		var new_moon = new Date(1970, 0, 7, 20, 35, 0);
		var phase = ((now.getTime() - new_moon.getTime())/1000) % lp;
		return Math.floor(phase /(24*3600)) + 1;
	}
	
	PlasmaCore.DataSource {
		id: dataSource
		engine: "time"
		connectedSources: ["Local"]
		interval: 60000
		intervalAlignment: PlasmaCore.Types.AlignToHour
	}
	
	Component.onCompleted: {
		dateString = currentDate.toLocaleDateString();
		print(Date.fromLocaleDateString(dateString));
		var year = currentDate.toLocaleDateString(locale, "yyyy");
		var month = currentDate.toLocaleDateString(locale, "MM");
		var day = currentDate.toLocaleDateString(locale, "dd");
		var number = simpleMoon(year,month,day);
		if (number == 30) { number = 0; }
		var source = number + ".svg";
		moonOverlay.source = source;
		phaseTip.subText = i18n("Lunar phase day ") + number + i18n(" of 29");
		if (number == 0) { phaseTip.mainText = i18n("New Moon"); }
		else if (number < 8) { phaseTip.mainText = i18n("Waxing Crescent"); }
		else if (number == 8) { phaseTip.mainText = i18n("First Quarter"); }
		else if (number < 14) { phaseTip.mainText = i18n("Waxing Gibbous"); }
		else if (number == 14) { phaseTip.mainText = i18n("Full Moon"); }
		else if (number < 22) { phaseTip.mainText = i18n("Waning Gibbous"); }
		else if (number == 22) { phaseTip.mainText = i18n("Last Quarter"); }
		else if (number < 30) { phaseTip.mainText = i18n("Waning Crescent"); }
		
		
	}
	
	PlasmaCore.ToolTipArea {
		id: phaseTip
		anchors.fill: parent
		mainText : i18n("Moon Phase")
		subText : i18n("If you're reading this, something has gone wrong!")
		icon : plasmoid.configuration.icon
		
		MouseArea {
		id: mouseArea
		anchors.fill: parent
		hoverEnabled: true
		onClicked: showdesktop.showDesktop();
		}
	}
	
}
