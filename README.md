-----------------------
<img src=".art/banners/RetroClock_Banner.png" title="Retro Clock Title Banner" width="75%"/>

#### Turn your Ubuntu Touch device into a retro clock with a large collection of cold war era display technologies.

## License
----------
The code in this repository is under the [Simplified BSD license](https://opensource.org/licenses/BSD-2-Clause)

All of the custom artwork is in a seperate repository under an [Attribution Non-Commercial Share-Alike license](https://creativecommons.org/licenses/by-nc-sa/4.0/)

## Credits
----------
The code is based on Night Clock by [Michal Predotka](https://open-store.io/app/nightclock.mivoligo).

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
* [Spark-Tube](https://www.spark-tube.com)
* [Jogis-Roehrenbude](http://www.jogis-roehrenbude.de)
* [Nixies.us](https://www.nixies.us)
* [TubeTime](http://tubetime.us)

If you think I have used your reference photos during the creation of my 
work and I have not included your site please open an issue and let me 
know so I can add it. Some reference photos where found on social media 
posts without referel to their origin.

## Notes
--------
Possible future changes

* Slot machine and shuffle transitions like used on real nixie clocks.
* Display date in numerical format using smaller versions of the display choosen.
* Hue/Saturation wheel or panel instead of Hue and Saturation sliders for custom colors.
* Make analog clock and date/alarms display side by side in landscape.
* Backgrounds and overlays to complete the look of real world clocks.
* Use as lock screen.
* Use on/as wallpaper.
* Timer and stopwatch mode.
* Option to force landscape mode while the phone is in portrait. (Does not look to be possible with a setting only in the .desktop file)


The program could be optimized and cleaned up but I have very little 
experience with declarative or object oriented programming and before this 
program I had never used Qml, QT or Java so I have left all redundant 
code and even added to it. 

The presets are saved in a C type array and the colors are all saved in 
individual variables with get and set functions since I did not know how 
to do it in QML and the colors could not be used after being re-saved 
in the C type array.

The program is much larger than the orginal due to all the png graphics 
included. I have tried to keep it as small as possible by reducing the 
png resolution without sacrificing quality on a phone.

All of the displays below are all based on real world display technology 
from the cold war era except the colons tubes which are fictional and 
generally do not exist in the real world.

Most of the L.E.D. displays are from the very early days of L.E.Ds and 
are not the most useful but none the less interesting.

The decade counter clocks are for the tube clock lovers amung you not 
because they are good clocks.

## Options
----------
There are 6 fully customizable presets that can have all their parameters 
changed individually except the time/date formats and fullscreen which 
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
    * 1 type of Electroluminescent segmented cyrillic font (Alien font) display panel. (Adjustable Hue)
    * 3 types of Vacuum Flourescent segmented displays. (Adjustable Hue)
    * 1 type of Cathode Ray Tube display. (+1 variation) (Adjustable Hue)
    * 1 type of Thyratron segmented display. (Adjustable Hue)
    * 2 types of Decade counters. (+1 variation) (Adjustable Hue)
    
* L.E.D. & Flip Clocks
    * 5 types of segmented and dot matrix L.E.D. displays. (Color matches Text color)
    * 2 colors of Flip clock.

* Analog Clocks
    * 2 types of Vacuum Flourescent Analog clocks. (Color matches Text color)
    * 5 types of Oscilloscope clock faces. (Color matches Text color)
    * 5 types of clocks. (same faces as oscilloscope) (Color matches Text color)

------------------------

#### All pictures show the colors of the actual real life displays.
 The colors are customizable in the settings menu.

### B7971 15 Segment Nixie Tubes
<img src=".art/banners/b7971.png" title="B7971 clock with leading zero and seconds displayed clock with leading zero and seconds displayed" width="50%"/>

### GN1 Nixie Tubes
<img alt="gn1" src=".art/banners/gn1.png" title="GN1 clock with leading zero and seconds displayed" width="50%"/>

### ZM1010 Nixie Tubes
<img alt="zm1010" src=".art/banners/zm1010.png" title="ZM1010 clock with leading zero and seconds displayed" width="50%"/>

### CD66A Nixie Tubes
<img alt="cd66a" src=".art/banners/cd66a.png" title="CD66A clock with leading zero and seconds displayed" width="50%"/>

### IN23 11 Segment Nixie Tubes
<img alt="in23" src=".art/banners/in23.png" title="IN23 clock with leading zero and seconds displayed" width="50%"/>

### MG17G 7 Segment Neon Tubes
<img alt="mg17g" src=".art/banners/mg17g.png" title="MG17G clock with leading zero and seconds displayed" width="50%"/>

### NEO8000 7 Segment Neon Displays
<img alt="neo8000" src=".art/banners/neo8000.png" title="NEO8000 clock with leading zero and seconds displayed" width="50%"/>

### NEO5000 7 Segment Neon Displays
<img alt="neo5000" src=".art/banners/neo5000.png" title="NEO5000 clock with leading zero and seconds displayed" width="50%"/>

### ZM1350 15 Segment Neon Displays
<img alt="zm1350" src=".art/banners/zm1350.png" title="ZM1350 clock with leading zero and seconds displayed" width="50%"/>

### IEL0VI 8 Segment Electroluminescent Displays
<img alt="iel0vi" src=".art/banners/iel0vi.png" title="IEL0VI clock with leading zero and seconds displayed" width="50%"/>

### Y1938 Prototype 7 Segment Vacuum Flourescent Tubes
<img alt="y1938p" src=".art/banners/y1938p.png" title="Y1938 clock with leading zero and seconds displayed" width="50%"/>

### DG10B 9 Segment Vacuum Flourescent Tubes
<img alt="dg10b" src=".art/banners/itrondg10b.png" title="DG10B clock with leading zero and seconds displayed" width="50%"/>

### IV6 7 Segment Vacuum Flourescent Tubes
<img alt="iv6" src=".art/banners/iv6.png" title="IV6 clock with leading zero and seconds displayed" width="50%"/>

### XM1000 Nimo Cathode Ray Tubes
<img alt="xm1000" src=".art/banners/nimoxm1000a.png" title="XM1000 clock with leading zero and seconds displayed" width="50%"/>

### XM1000 Nimo Cathode Ray Tubes
<img alt="xm1000" src=".art/banners/nimoxm1000b.png" title="XM1000 clock with leading zero and seconds displayed" width="50%"/>

### ITS1A 7 Segment Thyratron Tubes
<img alt="its1a" src=".art/banners/its1a.png" title="ITS1A clock with leading zero and seconds displayed" width="50%"/>

### HP5802-7002 Prototype 5X7 L.E.D. Matrix Displays
<img alt="hp7002" src=".art/banners/hp7002.png" title="HP5802-7002 clock with leading zero and seconds displayed" width="50%"/>

### HP5802-7000 1970 L.E.D. Matrix Displays (5X7 matrix with holes, only 27 pixels)
<img alt="hp7000_70" src=".art/banners/hp7000_70.png" title="HP5802-7000 clock with leading zero and seconds displayed" width="50%"/>

### HP5802-7000 1987 L.E.D. Matrix Displays (5X7 matrix with holes, only 27 pixels)
<img alt="hp7000_87" src=".art/banners/hp7000_87.png" title="HP5802-7000 clock with leading zero and seconds displayed" width="50%"/>

### TIA8447 7(14) Segment L.E.D. Displays
<img alt="tia8447" src=".art/banners/tia8447.png" title="TIA8447 clock with leading zero and seconds displayed" width="50%"/>

### HDSP0960 20 Pixel 7 Segment Style L.E.D. Displays
<img alt="hdsp0960" src=".art/banners/hdsp960x.png" title="HDSP0960 clock with leading zero and seconds displayed" width="50%"/>

### E1T Beam Deflector Decade Counter Tubes
<img alt="e1t" src=".art/banners/e1t.png" title="E1T clock with leading zero and seconds displayed" width="50%"/>

### Pixie Style Decade Counter Tubes (Unknown Model)
<img alt="pixie" src=".art/banners/pixieb.png" title="Pixie tube clock with leading zero and seconds displayed" width="50%"/>

### Black Flip Clock Faces
<img alt="black flipclock" src=".art/banners/flipblk.png" title="Black Flip Clock with leading zero and seconds displayed" width="50%"/>

### White Flip Clock Faces
<img alt="white flipclock" src=".art/banners/flipwht.png" title="White Flip Clock with leading zero and seconds displayed" width="50%"/>

### FIP60B30T Vacuum Flourescent Analog Clock
<img alt="fip60" src=".art/banners/fip60.png" title="FIP60B30T clock with seconds displayed" width="50%"/>

### VFD48 Vacuum Flourescent Analog Clocks
<img alt="vfd48" src=".art/banners/vfd48.png" title="VFD48 clock with seconds displayed" width="50%"/>

### Custom Oscilloscope and Floating Analog Clock Faces

#### Type A
<img alt="analog faces A" src=".art/banners/analoga.png" title="Analog Face A clock with seconds displayed" width="50%"/>

#### Type B
<img alt="analog faces B" src=".art/banners/analogb.png" title="Analog Face B clock with seconds displayed" width="50%"/>

#### Type C
<img alt="analog faces C" src=".art/banners/analogc.png" title="Analog Face C clock with seconds displayed" width="50%"/>

#### Type D
<img alt="analog faces D" src=".art/banners/analogd.png" title="Analog Face D clock with seconds displayed" width="50%"/>

#### Type E
<img alt="analog faces E" src=".art/banners/analoge.png" title="Analog Face E clock with seconds displayed" width="50%"/>

### Build from source
Install [Clickable](https://clickable-ut.dev/en/latest/)

Download [images](https://github.com/Intrinsically-Sublime/rc-images) and place the "img" folder in the root of Retro-Clock

Open terminal at Retro-Clock root and run Clickable

----------

Copyright (c) 2-22, [Intrinsically-Sublime](https://github.com/Intrinsically-Sublime)
All rights reserved.
