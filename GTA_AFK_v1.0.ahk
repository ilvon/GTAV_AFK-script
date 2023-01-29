MyGui := Gui(, "GTAV AFK")
Pause::Pause -1
/*
MyGui.Add("Text",,"Key 1: ")
MyGui.Add("Text",,"Key 2: ")
MyGui.Add("Hotkey", "vChosenHotkey ym", "w")
MyGui.Add("Hotkey", "vChosenHotkey2", "s")
*/
pause_cnt := -1
ch_pause := &pause_cnt

MyGui.SetFont(, "Microsoft JhengHei UI")
MyGui.Add("Text", "x+40 y+20" ,"The script is running...")
MyGui.Add("Button", "Default w80 x20 yp+40", "Pause").OnEvent("Click",gui_pause)
MyGui.Add("Button", "Default w80 xp+120 yp-0", "Exit").OnEvent("Click",gui_exit)
sb := MyGui.Add("StatusBar",,"Script running.")
;sb.SetText("Script running.")
;MyGui.Add("Button", "Default", "Modify").OnEvent("Click", key_change)
MyGui.Show("w240 h130")

chk_pause(pac){
    if (pac = -1){
        sb.SetText("Script running.")
    }
    else if (pac = 1){
        sb.SetText("Script paused.")
    }
}
tog(*){
    %ch_pause% *= -1

}
gui_pause(*){
    Pause -1
    tog()
    chk_pause(pause_cnt)
}
gui_exit(*){
    ExitApp
}

;keychange(*){
;}

loop
{
    Send "{w down}" 
    Sleep 1000 
    Send "{w up}"
    Sleep 15000
    Send "{s down}" 
    Sleep 1000 
    Send "{s up}"
    Sleep 15000 
}
 
#Esc::ExitApp