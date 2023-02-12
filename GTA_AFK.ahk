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
secs := '0'
ref_k1_d := &k1_d
ref_k1_u := &k1_u
ref_k2_d := &k2_d
ref_k2_u := &k2_u
ref_sleep_inv := &sleep_inv
ref_hrs := &hrs
ref_mins := &mins
ref_secs := &secs

chk_modify := (*) => btn_mod.Enabled := hk1.Value hk2.Value interval.Value ? True : False

afkgui := Gui(, "GTAV AFK")
;afkgui.BackColor := "23272E"
afkgui.SetFont(, "Microsoft JhengHei UI")

afkgui.Add("Text", "x16 y20" ,"Your game must be the active window.")
afkgui.Add("Text", "x59 y50", "Elapsed:").SetFont("cRed bold")
afkgui.Add("Text", "x33 y80","Key 1:")
afkgui.Add("Text", "x33 y110", "Key 2:")
hk1 := afkgui.Add("Hotkey", "x83 y76","w")
hk2 := afkgui.Add("Hotkey","x83 yp+30", "s")
afkgui.Add("Text","x28 y135","Interval `n  (sec)")
afkgui.Add("Edit","x83 y136 w136")
interval := afkgui.Add("UpDown", "Range1-300", 30)
btn_mod := afkgui.Add("Button", "Default Disabled x85 y176 w80" ,"Modify")
btn_pause := afkgui.Add("Button", "Default w80 x22 yp+40", "Start")
btn_exit := afkgui.Add("Button", "Default w80 xp+125 yp", "Exit")
sb := afkgui.Add("StatusBar",,"")

show_hrs := afkgui.Add("Text", "x118 y50", "0" hrs "  :  ")
show_mins := afkgui.Add("Text", "x148 y50", "0" mins "  :  ")
show_secs := afkgui.Add("Text", "x178 y50", "0" secs)

show_hrs.SetFont("cRed bold")
show_mins.SetFont("cRed bold")
show_secs.SetFont("cRed bold")
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
afkgui.Show("w250 h280")
Pause

chk_pause(pac){
    if (pac = -1){
        btn_pause.Text := "Resume"
        sb.SetText("Script paused.")
    }
    else if (pac = 1){
        btn_pause.Text := "Pause"
        sb.SetText("Script running.")
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
    afkgui.Submit()
    MsgBox "You have chosen " hk1.Value " and " hk2.Value '.' "`n Press interval : " interval.Value " seconds", 'Modify script', 64
    %ref_k1_d% := "{" hk1.Value " down}" 
    %ref_k1_u% := "{" hk1.Value " up}"
    %ref_k2_d% := "{" hk2.Value " down}" 
    %ref_k2_u% := "{" hk2.Value " up}"
    %ref_sleep_inv% := interval.Value
    afkgui.Show("w250 h280")
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
    if (%ref_hrs% < 10){
        show_hrs.text := "0" hrs "  :  "
    }else{
        show_hrs.text := hrs " : "
    }
    if (%ref_mins% < 10){
        show_mins.text := "0" mins "  :  "
    }else{
        show_mins.text := mins " : "
    }
    if (%ref_secs% < 10){
        show_secs.text := "0" secs "  :  "
    }else{
        show_secs.text := secs " : "
    }
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
#`::afkgui.Show("w250 h280")
