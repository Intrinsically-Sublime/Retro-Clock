-----------------------
<img src=".art/banners/RetroClock_Banner.png" title="Retro Clock Title Banner" width="100%"/>

**Turn your Ubuntu Touch device into a retro clock with a large collection of cold war era display technologies.**

## Release
----------
**The images and an installable click file will be released once there is 
an official way of getting a click reviewed that does not require 
installing a program to then join a social group to ask for review.**

## License
----------

### Application Code
The code in this repository is under the [Simplified BSD license](https://opensource.org/licenses/BSD-2-Clause)

<img src=".art/simplifiedBSD.png" title="Simplified BSD-2-Clause License" width="100px"/>

### Images
All of the custom artwork will be in a separate repository under a Creative Commons [Attribution Non-Commercial Share-Alike license](https://creativecommons.org/licenses/by-nc-sa/4.0/)

<img src=".art/ccbyncsa.svg" title="Creative Commons Attribution Non-Commercial Share-Alike License" width="100px"/>

## Credits
----------
The code is based on [Night Clock by Michal Predotka](https://open-store.io/app/nightclock.mivoligo).

All reference photos used to make the displays are used under fair use 
and are highly transformed from the originals. I have spent countless 
hours dissecting the images into individual parts, scaling, tweaking the 
colors and deforming them to produce perfectly aligned configurable images.
Many of the displays are based on a single image as they are rare or 
even one of one. None of the reference pictures are used in their original form.

Reference photos were found on these wonderful collectors sites and forums:

* [SwissNixie](https://www.swissnixie.com)
* [DecadeCounter](http://www.decadecounter.com/vta/)
* [IndustrialAlchemy](https://www.industrialalchemy.org)
* [TubeClockDB](https://www.tubeclockdb.com)
* [TubeTester](http://www.tube-tester.com)
* [Spark-Tube](https://www.spark-tube.com)
* [Jogis-Roehrenbude](http://www.jogis-roehrenbude.de)
* [Nixies.us](https://www.nixies.us)
* [TubeTime](http://tubetime.us)

If you think I have used your reference photos during the creation of my 
work, and I have not included your site, please open an issue and let me 
know, so I can add it. Some reference photos were found on social media 
posts without reference to their origin.

## Notes
--------
* Possible future changes
    * Make analog clock and date/alarms display side by side in landscape.
    * Backgrounds and overlays to complete the look of real world clocks.
    * Slot machine and shuffle transitions like used on real nixie clocks.
    * Display date in numerical format using smaller versions of the display chosen.
    * Hue/Saturation wheel or panel instead of Hue and Saturation sliders for custom colors.
    * Use as lock screen.
    * Use on/as wallpaper.
    * Timer and stopwatch mode.
    * Option to force landscape mode while the phone is in portrait. (Does not look to be possible with a setting, only in the .desktop file)

* It was tested on two devices during development
    * Oneplus 6T ( 64bit )
    * Oneplus One ( 32bit )

* The program could be optimized and cleaned up, but I have very little 
experience with declarative or object-oriented programming, and before this 
program I had never used Qml, QT or Java. I have left all redundant 
code and even added to it. 

* The presets are saved in a C type array and the colors are all saved in 
individual variables with get and set functions, since I did not know how 
to do it in QML and the colors could not be used after being re-saved 
in the C type array.

* The program is much larger than Night-Clock due to the 432 custom png 
images included. I have tried to keep it as small as possible by reducing 
the png resolution without sacrificing quality on a phone.

* All of the displays below are based on real world display technology 
from the cold war era, except the colon tubes which are fictional and 
generally do not exist in the real world.

* Most of the L.E.D. displays are from the very early days of L.E.Ds and 
are not the most useful, but none the less interesting.

* The decade counter clocks are for the tube clock lovers among you, not 
because they are good clocks.

## Options
----------
There are 8 fully customizable presets that can have all their parameters 
changed individually, except the time/date formats and fullscreen which 
are global.

* Select Display type
* Adjust Hue of "Tube Clocks"
* Set Background Color (HSV or RGB)
* Set Foreground Color of Text, Analog Clocks and L.E.D. displays (HSV or RGB)
* Custom Preset names
* HSV or RGB color selection
* Show Seconds
    * Blink colons (with show seconds)
* Show Date
* Show Alarms
* ScreenSaver Mode (Moves digital clock every minute)
* Hide Oscilloscope background to show just the face and hands
* Time Format
    * 12hr with leading zero
    * 12hr without leading zero
    * 24hr with leading zero
    * 24hr without leading zero
* Date Format
    * 9 standard formats
* Fullscreen or Windowed

## Displays
------------
* Tube Clocks
    * 10 types of Nixie tubes and Neon panel displays. (Adjustable Hue)
    * 1 type of Electroluminescent segmented cyrillic font display panel. (Adjustable Hue)
    * 3 types of Vacuum Fluorescent segmented displays. (Adjustable Hue)
    * 1 type of Cathode Ray Tube display. (+1 variation) (Adjustable Hue)
    * 1 type of Thyratron segmented display. (Adjustable Hue)
    * 2 types of Decade counters. (+1 variation) (Adjustable Hue)
    
* L.E.D. & Flip Clocks
    * 5 types of segmented and dot matrix L.E.D. displays. (Color matches Text color)
    * 2 colors of Flip clock.

* Analog Clocks
    * 2 types of Vacuum Fluorescent Analog clocks. (Color matches Text color)
    * 5 types of Oscilloscope clock faces. (Color matches Text color)
    * 5 types of clocks. (same faces as oscilloscope) (Color matches Text color)

------------------------

**All pictures show the colors of the actual real life displays.**

 The colors are customizable in the settings menu.

### B7971 15 Segment Nixie Tubes
<img src=".art/banners/b7971.png" title="B7971 clock with leading zero and seconds displayed clock with leading zero and seconds displayed" width="550px"/>

### GN1 Nixie Tubes
<img alt="gn1" src=".art/banners/gn1.png" title="GN1 clock with leading zero and seconds displayed" width="550px"/>

### ZM1010 Nixie Tubes
<img alt="zm1010" src=".art/banners/zm1010.png" title="ZM1010 clock with leading zero and seconds displayed" width="550px"/>

### CD66A Nixie Tubes
<img alt="cd66a" src=".art/banners/cd66a.png" title="CD66A clock with leading zero and seconds displayed" width="550px"/>

### IN23 11 Segment Nixie Tubes
<img alt="in23" src=".art/banners/in23.png" title="IN23 clock with leading zero and seconds displayed" width="550px"/>

### MG17G 7 Segment Neon Tubes
<img alt="mg17g" src=".art/banners/mg17g.png" title="MG17G clock with leading zero and seconds displayed" width="550px"/>

### NEO8000 7 Segment Neon Displays
<img alt="neo8000" src=".art/banners/neo8000.png" title="NEO8000 clock with leading zero and seconds displayed" width="550px"/>

### NEO5000 7 Segment Neon Displays
<img alt="neo5000" src=".art/banners/neo5000.png" title="NEO5000 clock with leading zero and seconds displayed" width="550px"/>

### ZM1350 15 Segment Neon Displays
<img alt="zm1350" src=".art/banners/zm1350.png" title="ZM1350 clock with leading zero and seconds displayed" width="550px"/>

### IEL0VI 8 Segment Electroluminescent Displays
<img alt="iel0vi" src=".art/banners/iel0vi.png" title="IEL0VI clock with leading zero and seconds displayed" width="550px"/>

### Y1938 Prototype 7 Segment Vacuum Fluorescent Tubes
<img alt="y1938p" src=".art/banners/y1938p.png" title="Y1938 clock with leading zero and seconds displayed" width="550px"/>

### DG10B 9 Segment Vacuum Fluorescent Tubes
<img alt="dg10b" src=".art/banners/itrondg10b.png" title="DG10B clock with leading zero and seconds displayed" width="550px"/>

### IV6 7 Segment Vacuum Fluorescent Tubes
<img alt="iv6" src=".art/banners/iv6.png" title="IV6 clock with leading zero and seconds displayed" width="550px"/>

### XM1000 Nimo Cathode Ray Tubes
<img alt="xm1000" src=".art/banners/nimoxm1000a.png" title="XM1000 clock with leading zero and seconds displayed" width="550px"/>

### XM1000 Nimo Cathode Ray Tubes
<img alt="xm1000" src=".art/banners/nimoxm1000b.png" title="XM1000 clock with leading zero and seconds displayed" width="550px"/>

### ITS1A 7 Segment Thyratron Tubes
<img alt="its1a" src=".art/banners/its1a.png" title="ITS1A clock with leading zero and seconds displayed" width="550px"/>

### HP5802-7002 Prototype 5X7 L.E.D. Matrix Displays
<img alt="hp7002" src=".art/banners/hp7002.png" title="HP5802-7002 clock with leading zero and seconds displayed" width="550px"/>

### HP5802-7000 1970 L.E.D. Matrix Displays (5X7 matrix with holes, only 27 pixels)
<img alt="hp7000_70" src=".art/banners/hp7000_70.png" title="HP5802-7000 clock with leading zero and seconds displayed" width="550px"/>

### HP5802-7000 1987 L.E.D. Matrix Displays (5X7 matrix with holes, only 27 pixels)
<img alt="hp7000_87" src=".art/banners/hp7000_87.png" title="HP5802-7000 clock with leading zero and seconds displayed" width="550px"/>

### TIA8447 7(14) Segment L.E.D. Displays
<img alt="tia8447" src=".art/banners/tia8447.png" title="TIA8447 clock with leading zero and seconds displayed" width="550px"/>

### HDSP0960 20 Pixel 7 Segment Style L.E.D. Displays
<img alt="hdsp0960" src=".art/banners/hdsp960x.png" title="HDSP0960 clock with leading zero and seconds displayed" width="550px"/>

### E1T Beam Deflector Decade Counter Tubes
<img alt="e1t" src=".art/banners/e1t.png" title="E1T clock with leading zero and seconds displayed" width="550px"/>

### ZM1050 Pixie Style Decade Counter Tubes
<img alt="pixie" src=".art/banners/pixieb.png" title="Pixie tube clock with leading zero and seconds displayed" width="550px"/>

### Black Flip Clock Faces
<img alt="black flipclock" src=".art/banners/flipblk.png" title="Black Flip Clock with leading zero and seconds displayed" width="550px"/>

### White Flip Clock Faces
<img alt="white flipclock" src=".art/banners/flipwht.png" title="White Flip Clock with leading zero and seconds displayed" width="550px"/>

### FIP60B30T Vacuum Fluorescent Analog Clock
<img alt="fip60" src=".art/banners/fip60.png" title="FIP60B30T clock with seconds displayed" width="550px"/>

### VFD48 Vacuum Fluorescent Analog Clock
<img alt="vfd48" src=".art/banners/vfd48.png" title="VFD48 clock with seconds displayed" width="550px"/>

### Custom Oscilloscope and Floating Analog Clock Faces

#### Type A
<img alt="analog faces A" src=".art/banners/analoga.png" title="Analog Face A clock with seconds displayed" width="550px"/>

#### Type B
<img alt="analog faces B" src=".art/banners/analogb.png" title="Analog Face B clock with seconds displayed" width="550px"/>

#### Type C
<img alt="analog faces C" src=".art/banners/analogc.png" title="Analog Face C clock with seconds displayed" width="550px"/>

#### Type D
<img alt="analog faces D" src=".art/banners/analogd.png" title="Analog Face D clock with seconds displayed" width="550px"/>

#### Type E
<img alt="analog faces E" src=".art/banners/analoge.png" title="Analog Face E clock with seconds displayed" width="550px"/>

### Screenshots
---------------

#### Vertical Orientation
<img alt="Vertical Nixie Clock without seconds" src=".art/screenshots/nixie4k_0406xx(1).png" title="Vertical orientation nixie tube clock without seconds displayed" height="550px"/><img alt="Vertical VFD48 Analog with seconds" src=".art/screenshots/vfd48_161449.png" title="Vertical orientation VFD48 analog clock with seconds displayed" height="550px"/><img alt="Vertical ZM1350 Neon panel with seconds" src=".art/screenshots/zm1350_161123.png" title="Vertical orientation ZM1350 Neon panel clock without seconds displayed" height="550px"/>

#### Horizontal Orientation without seconds
<img alt="Horizontal Nixie Clock without seconds" src=".art/screenshots/nixie4k_0406xx.png" title="Horizontal orientation nixie tube clock without seconds displayed" width="550px"/>

#### Horizontal Orientation without leading zero
<img alt="Horizontal Nixie Clock without leading zero" src=".art/screenshots/gn1_x72726.png" title="Horizontal orientation nixie tube clock without leading zero displayed" width="550px"/>

<img alt="Horizontal Flip Clock without leading zero" src=".art/screenshots/flipblk_x72821.png" title="Horizontal orientation flip clock without leading zero displayed" width="550px"/>

#### Horizontal Orientation with leading zero and seconds
<img alt="Horizontal Electroluminescent Clock with leading zero and seconds" src=".art/screenshots/iel0vi_153330.png" title="Horizontal orientation Electroluminescent clock with leading zero and seconds displayed" width="550px"/>

#### Nixie Tube Hue examples
<img alt="Horizontal Nixie tube Clock with leading zero and seconds, Orginal Hue" src=".art/screenshots/zm1010_155433.png" title="Horizontal orientation Nixie tube clock with leading zero and seconds displayed, Orginal Hue" width="550px"/>

<img alt="Horizontal Nixie tube Clock with leading zero and seconds, Purple Hue" src=".art/screenshots/zm1010_155330.png" title="Horizontal orientation Nixie tube clock with leading zero and seconds displayed, Purple Hue" width="550px"/>

<img alt="Horizontal Nixie tube Clock with leading zero and seconds, Green Hue" src=".art/screenshots/zm1010_155357.png" title="Horizontal orientation Nixie tube clock with leading zero and seconds displayed, Green Hue" width="550px"/>

#### Settings
<img alt="Horizontal Settings page" src=".art/screenshots/settings_001.png" title="Horizontal orientation Settings page" width="550px"/>

<img alt="Horizontal Settings page" src=".art/screenshots/settings_002.png" title="Horizontal orientation Settings page" width="550px"/>

<img alt="Horizontal Settings page" src=".art/screenshots/settings_003.png" title="Horizontal orientation Settings page" width="550px"/>

<img alt="Horizontal Settings page" src=".art/screenshots/settings_004.png" title="Horizontal orientation Settings page" width="550px"/>

<img alt="Horizontal Settings page" src=".art/screenshots/settings_005.png" title="Horizontal orientation Settings page" width="550px"/>

<img alt="Horizontal Settings page" src=".art/screenshots/settings_006.png" title="Horizontal orientation Settings page" width="550px"/>

<img alt="Horizontal Settings page" src=".art/screenshots/settings_007.png" title="Horizontal orientation Settings page" width="550px"/>

### Building from source
------------------------
Install [Clickable](https://clickable-ut.dev/en/latest/)

Download or clone the Retro-Clock repo

See the #Release section for information on the release of the images.  
<s>Download the [img](https://github.com/Intrinsically-Sublime/rc-images) 
folder and place it in the root of Retro-Clock along side the qml and po folders.</s>

Open a terminal at the root of Retro-Clock and run ``` clickable ``` or ``` clickable desktop ``` or ``` clickable build ```

----------

Copyright (c) 2-22, [Intrinsically-Sublime](https://github.com/Intrinsically-Sublime)
All rights reserved.
