Pause::Pause -1
pause_cnt := -1
ref_pause_cnt := &pause_cnt

k1_d := "{w down}"
k1_u := "{w up}"
k2_d := "{s down}"
k2_u := "{s up}"
sleep_inv := 30
ref_k1_d := &k1_d
ref_k1_u := &k1_u
ref_k2_d := &k2_d
ref_k2_u := &k2_u
ref_sleep_inv := &sleep_inv
chk_modify := (*) => btn_mod.Enabled := hk1.Value hk2.Value interval.Value ? True : False

MyGui := Gui(, "GTAV AFK")
MyGui.SetFont(, "Microsoft JhengHei UI")

MyGui.Add("Text", "y+20" ,"Your game must be the active window.")
MyGui.Add("Text", ,"Key 1:")
MyGui.Add("Text", , "Key 2:")
hk1 := MyGui.Add("Hotkey", "xp+50 yp-32","w")
hk2 := MyGui.Add("Hotkey","xp", "s")
MyGui.Add("Text","xp-50 yp+30","Interval `n  (sec)")
MyGui.Add("Edit","x60 yp+5 w137")
interval := MyGui.Add("UpDown", "Range1-300", 30)
btn_mod := MyGui.Add("Button", "Default Disabled x80 yp+40 w80" ,"Modify")
MyGui.Add("Button", "Default w80 x20 yp+40", "Pause").OnEvent("Click",gui_pause)
MyGui.Add("Button", "Default w80 xp+120 yp-0", "Exit").OnEvent("Click",gui_exit)
sb := MyGui.Add("StatusBar",,"Script running.")

btn_mod.OnEvent("Click", keychange)
hk1.OnEvent('Change', chk_modify)
hk2.OnEvent('Change', chk_modify)
interval.OnEvent('Change', chk_modify)
MyGui.Show("w240 h260")

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
keychange(*){
    MyGui.Submit()
    MsgBox "You have chosen " hk1.Value " and " hk2.Value '.' "`n Press interval : " interval.Value " seconds", 'Modify script', 64
    %ref_k1_d% := "{" hk1.Value " down}" 
    %ref_k1_u% := "{" hk1.Value " up}"
    %ref_k2_d% := "{" hk2.Value " down}" 
    %ref_k2_u% := "{" hk2.Value " up}"
    %ref_sleep_inv% := interval.Value
    MyGui.Show("w240 h260")
}

loop
{
    Send k1_d
    Sleep 1000 
    Send k1_u
    Sleep sleep_inv*1000      
    Send k2_d
    Sleep 1000 
    Send k2_u
    Sleep sleep_inv*1000      
}
 
#Esc::ExitApp
#`::MyGui.Show("w240 h260")
