MyGui := Gui(, "GTAV AFK")
Pause::Pause -1
pause_cnt := -1
ref_pause_cnt := &pause_cnt

MyGui.SetFont(, "Microsoft JhengHei UI")
MyGui.Add("Text", "y+20" ,"Your game must be the active window.")
MyGui.Add("Button", "Default w80 x20 yp+40", "Pause").OnEvent("Click",gui_pause)
MyGui.Add("Button", "Default w80 xp+120 yp-0", "Exit").OnEvent("Click",gui_exit)
sb := MyGui.Add("StatusBar",,"Script running.")
MyGui.Show("w240 h130")

chk_pause(pac){
    if (pac = -1){
        sb.SetText("Script running.")
    }
    else if (pac = 1){
        sb.SetText("Script paused.")
    }
}
gui_pause(*){
    Pause -1
    %ref_pause_cnt% *= -1
    chk_pause(pause_cnt)
}
gui_exit(*){
    ExitApp
}

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
