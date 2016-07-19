# selene

Rewrite in pure QML of the logic for the "Luna" moon phases applet for KDE Plasma

## License

The SVG images of the moon are under the Artistic License 2.0 2009:
* Jose Alcalá - Project Manager & Concept
* Dominique Bribanick - Style Concept
* Jeremy M. Todaro - Artwork & Layout

The QML code is copyright 2016 Keith Zubot-Gephart and available under copyleft-next 0.3.1.

## Okay sure but what actually is this and why?

Plasma (the KDE desktop environment, although KDE means the community and now I'm all confused again) used to have a moon phases applet. However, it never made the jump from 4 to 5. I attempted to see if I could port it, but I failed miserably, in part because I can't seem to get _any_ QML&C++ applet to run or install properly. So I figured I'd be better off just rewriting the whole damn thing in pure QML, which can be test-run easily with just "plasmoidviewer -a ." from within the "plasmoid" folder.
