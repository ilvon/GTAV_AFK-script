Pause::Pause -1
pause_cnt := -1
ref_pause_cnt := &pause_cnt

k1_d := "{w down}"
k1_u := "{w up}"
k2_d := "{s down}"
k2_u := "{s up}"
sleep_inv := 30
hrs := '0'
mins := '0'
secs := '00'
ref_k1_d := &k1_d
ref_k1_u := &k1_u
ref_k2_d := &k2_d
ref_k2_u := &k2_u
ref_sleep_inv := &sleep_inv
ref_hrs := &hrs
ref_mins := &mins
ref_secs := &secs

chk_modify := (*) => btn_mod.Enabled := hk1.Value hk2.Value interval.Value ? True : False

MyGui := Gui(, "GTAV AFK")
;MyGui.BackColor := "23272E"
MyGui.SetFont(, "Microsoft JhengHei UI")

MyGui.Add("Text", "x16 y20" ,"Your game must be the active window.")
MyGui.Add("Text", "x16 y50", "Elapsed: ").SetFont("cRed")
MyGui.Add("Text", "x16 y80","Key 1:")
MyGui.Add("Text", "x16 y110", "Key 2:")
hk1 := MyGui.Add("Hotkey", "xp+50 y76","w")
hk2 := MyGui.Add("Hotkey","xp yp+30", "s")
MyGui.Add("Text","x11 y135","Interval `n  (sec)")
MyGui.Add("Edit","x66 y136 w136")
interval := MyGui.Add("UpDown", "Range1-300", 30)
btn_mod := MyGui.Add("Button", "Default Disabled x85 y176 w80" ,"Modify")
btn_pause := MyGui.Add("Button", "Default w80 x22 yp+40", "Pause")
btn_exit := MyGui.Add("Button", "Default w80 xp+125 yp", "Exit")
show_time := MyGui.Add("Text", "x75 y50", hrs " hrs " mins " mins " secs " secs")
sb := MyGui.Add("StatusBar",,"Script running.")

show_time.SetFont("cRed")
btn_pause.SetFont("bold")
btn_exit.SetFont("bold")
btn_mod.SetFont("bold")

btn_pause.OnEvent("Click",gui_pause)
btn_mod.OnEvent("Click", keychange)
btn_exit.OnEvent("Click",gui_exit)
hk1.OnEvent('Change', chk_modify)
hk2.OnEvent('Change', chk_modify)
interval.OnEvent('Change', chk_modify)

SetTimer timer_main, 1000
MyGui.Show("w250 h280")

chk_pause(pac){
    if (pac = -1){
        btn_pause.Text := "Pause"
        show_time.Text := hrs " hrs " mins " mins " secs " secs"
        sb.SetText("Script running.")
    }
    else if (pac = 1){
        btn_pause.Text := "Resume"
        sb.SetText("Script paused.")
    }
    return
}
gui_pause(*){
    Pause -1
    %ref_pause_cnt% *= -1
    %ref_hrs% := 0
    %ref_mins% := 0
    %ref_secs% := -1
    chk_pause(pause_cnt)
    return
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
    MyGui.Show("w240 h280")
    return
}
timer_main(*){
    %ref_secs% += 1
    if(%ref_secs% > 59){
        %ref_mins% += 1
        %ref_secs% := 0
    }
    if(%ref_mins% > 59){
        %ref_hrs% += 1
        %ref_mins% := 0
    }
    show_time.Text := hrs " hrs " mins " mins " secs " secs "
    return
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
#`::MyGui.Show("w240 h280")
