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
	readonly property date currentDateTime: dataSource.data.Local ? dataSource.data.Local.DateTime : new Date()
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
		dateString = date.toLocaleDateString();
		print(Date.fromLocaleDateString(dateString));
		var year = date.toLocaleDateString(locale, "yyyy");
		var month = date.toLocaleDateString(locale, "MM");
		var day = date.toLocaleDateString(locale, "dd");
		var number = simpleMoon(year,month,day);
		var source = number + ".svg";
		moonOverlay.source = source;
		
	}

	// I don't know why this doesn't work...
	Plasmoid.toolTipMainText: "Test"
	Plasmoid.toolTipSubText: "Subtest"
	
}
