;PlayMusic/@Resources/ConfigStyles.inc

[Variables]
;White
color1=FFFFFF89
;Cyan
color2=00BCD4F1
;Light Orange
color3=FF9800F1
;Purple
color4=673AB7B5
;Teal
color5=008A9EFE
;Light Green
color6=689F38FE
;Pink
color7=F94E73E2
;Yellow
color8=FFDE00E6
;Green
color9=43A047FE
;Red
color10=E53935E8
;Indigo
color11=3F51B5E8
;Orange
color12=FA5722EA
;Blue
; color13=1389F4

[SubHeading]
FontSize=16
FontFace=Segoe UI
FontColor=0,0,0,170
X=83
Y=200
ClipString=2
AntiAlias=1

[BodyText]
FontFace=Segoe UI
FontSize=12
FontColor=30,30,30,240
StringStyle=Normal
StringEffect=Shadow
FontEffectColor = 0,0,0,0
X=3R
ClipString=2
AntiAlias=1

[Checkbox]
FontSize=11
FontColor=40,40,40,255
SolidColor=0,0,0,0
Padding=5,5,5,5
X=101
DynamicVariables=1
AntiAlias=1

[ColorOption]
H=35
W=35
X=1R
Y=r

[IconStyle]
ImageTint=#accent#
PreserveAspectRatio=1
H=48
LeftMouseUpAction=[!WriteKeyValue Variables icon #@#images\icon_fill.png "#ROOTCONFIGPATH#\PlayMusic (Square).ini"][!WriteKeyValue Variables  icon #@#images\icon_fill.png "#ROOTCONFIGPATH#\PlayMusic (Landscape).ini"][!WriteKeyValue Variables icon #@#images\icon_fill.png "#ROOTCONFIGPATH#\Settings\Config.ini"][!SetOption icon2 "(1-#icon2#)"][!SetVariable icon2 "(1-#icon2#)"][!SetVariable icon1 "(1-#icon1#)"][!SetVariable icon1 "(1-#icon1#)"][!CommandMeasure MeasureLuaScript "Write()"][!UpdateMeasure MeasureButton][!Refresh PlayMusic][!Refresh PlayMusic\Settings]

[BorderStyle]
SolidColor=190,190,190, 140
X=66
H=1
W=306

[IconButton]
H=59
W=59
DynamicVariables=1
AntiAlias=1