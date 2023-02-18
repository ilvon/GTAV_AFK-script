# GTAV_AFK-script

A simple script written by AutoHotKey_v2.0 (AHK) for AFK in GTA V Online or any other online games to avoid being kicked by server. Players not need to go to some spcial place in Los Santos for AFK with the use of this script.

This script will repeatedly send keystrokes with at a certain interval.
<p align="center">
  <img width="252" height="362" src="https://user-images.githubusercontent.com/76443690/219728687-055ed6ba-5ba7-4c09-99ec-a5f93c8a57e5.png">

</p>

## Modes
1. Active Mode
   - sends keystrokes to the active (the top window that you are focusing)
   - the target window **MUST BE the TOP window**
2. Inactive Mode
   - sends keystrokes to any window you have chosen
   - the target window **CAN be minimized**
   - if the GTAV is the target widnow, this mode **WILL** shortly interrupt for your current task on the active window (losing focus, GTA pops up and     minimized repeatedly when keystrokes sent) 
   - longer press interval recommended

## Key Bindigs
|               Key              |       Task       |
| :----------------------------: | :--------------: |
|  <kbd>Win</kbd>+<kbd>`</kbd>   |     Show GUI     |
| <kbd>Win</kbd>+<kbd>ESC</kbd>  | Kill the Script  |


## How To Use
1. Run the executable / Download [AHK_v2](https://www.autohotkey.com/)
2. Select the mode of the script and start AFK

## Remarks
- The close button of the executable of this script *DOES NOT* kill the script but just close the GUI
- Key1 & Key2 cannot be set as special keys like <kbd>Ctrl</kbd>, <kbd>Shift</kbd> etc.
- You can press the radio button to refresh the `Target Window` list
- For GTAV, probably there is some mechanism has been deployed to avoid external automated keystrokes by scipt, the inactive mode is not using `ControlSend`      function, but using `Send` instead, which cause the forementioned interruption
- the executable from `Release` is compiled by Ahk2Exe



