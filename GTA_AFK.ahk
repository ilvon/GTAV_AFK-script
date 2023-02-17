Pause::Pause -1
pause_cnt := -1
ref_pause_cnt := &pause_cnt

k1_d := "{w down}"
k1_u := "{w up}"
k2_d := "{s down}"
k2_u := "{s up}"
sleep_inv := 120
hrs := '0'
mins := '0'
secs := '0'
rad_ina_status := 0

ref_k1_d := &k1_d
ref_k1_u := &k1_u
ref_k2_d := &k2_d
ref_k2_u := &k2_u
ref_sleep_inv := &sleep_inv
ref_hrs := &hrs
ref_mins := &mins
ref_secs := &secs
ref_rad_ina_status := &rad_ina_status
app_name_list := get_list()

chk_modify := (*) => btn_mod.Enabled := hk1.Value hk2.Value interval.Value radio_inactive.Value app_choose.Value? True : False

afkgui := Gui(, "GTAV AFK")
afkgui.SetFont(, "Microsoft JhengHei UI")

;afkgui.Add("Text", "x16 y20" ,"Your game must be the active window.")
afkgui.Add("Text", "x59 y20", "Elapsed:").SetFont("cRed bold")
afkgui.Add("Text", "x33 y50","Key 1:")
afkgui.Add("Text", "x33 y80", "Key 2:")
hk1 := afkgui.Add("Hotkey", "x83 y46","w")
hk2 := afkgui.Add("Hotkey","x83 y76", "s")
afkgui.Add("Text","x28 y103","Interval `n (sec)")
afkgui.Add("Edit","x83 y108 w136")
interval := afkgui.Add("UpDown", "Range1-600", 120)
afkgui.add("text", "x28 y138", " Target `nWindow")
app_choose := afkgui.add("DropDownList", "x83 y142 Disabled choose1" , app_name_list)

afkgui.add("Text", "x33 y180", "Mode:")
radio_active := afkgui.Add("Radio", "x83 y180 checked", "Active")
radio_inactive := afkgui.Add("Radio", "x158 y180", "Inactive")
btn_mod := afkgui.Add("Button", "Default Disabled x85 y220 w80" ,"Modify")
btn_pause := afkgui.Add("Button", "Default w80 x22 yp+40", "Start")
btn_exit := afkgui.Add("Button", "Default w80 xp+125 yp", "Exit")

sb := afkgui.Add("StatusBar",,"")

show_hrs := afkgui.Add("Text", "x118 y20", "0" hrs " : ")
show_mins := afkgui.Add("Text", "x148 y20", "0" mins " : ")
show_secs := afkgui.Add("Text", "x178 y20", "0" secs " ")

show_hrs.SetFont("cRed bold")
show_mins.SetFont("cRed bold")
show_secs.SetFont("cRed bold")
btn_pause.SetFont("bold")
btn_exit.SetFont("bold")
btn_mod.SetFont("bold")

btn_pause.OnEvent("Click",gui_pause)
btn_mod.OnEvent("Click", setting_modify)
btn_exit.OnEvent("Click",gui_exit)
hk1.OnEvent('Change', chk_modify)
hk2.OnEvent('Change', chk_modify)
interval.OnEvent('Change', chk_modify)
radio_active.OnEvent('Click', change_radio)
radio_inactive.OnEvent('Click', change_radio)

SetTimer timer_main, 1000
afkgui.Show("w250 h330")
Pause

change_radio(*){
    global app_name_list
    chk_modify()
    if (radio_inactive.value = 1){
        app_choose.Enabled := True
    }else{
        app_choose.Enabled := False
    }
    app_name_list := get_list()
    ;update_ddl(app_name_list[app_choose.value], app_name_list)
    update_ddl(app_name_list[1], app_name_list)
}

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
    id_nowA := WinGetID("A")
    WinSetAlwaysOnTop 0, "ahk_id " id_nowA
    ExitApp
}
setting_modify(*){
    global app_name_list
    afkgui.Submit()
    if (app_choose.value = 0){
        MsgBox "Please choose a target window.", "Error", 16
        app_name_list := get_list()
        update_ddl(0, app_name_list)
        afkgui.Show("w250 h330")
        return
    }else{
        chosen_app := app_name_list[app_choose.value]
    }
    tell_radio_status := radio_inactive.value = 0 ? "ACTIVE mode" : "INACTIVE mode"
    tell_interval := interval.value > 60 ? "`n `nPress interval : " interval.value//60 " mins " Mod(interval.value, 60) " secs" : "`n `nPress interval : " interval.value " secs"
    if (tell_radio_status = "ACTIVE mode"){
        MsgBox "You have chosen " hk1.Value " & " hk2.Value '.' tell_interval "`n `nThe script now in " tell_radio_status, 'Modify script', 64
    }else{
        MsgBox "You have chosen " hk1.Value " & " hk2.Value '.' tell_interval "`n `nThe script now in " tell_radio_status "`n `nTarget window: " app_name_list[app_choose.value], 'Modify script', 64
    }
    %ref_k1_d% := "{" hk1.Value " down}"
    %ref_k1_u% := "{" hk1.Value " up}"
    %ref_k2_d% := "{" hk2.Value " down}"
    %ref_k2_u% := "{" hk2.Value " up}"
    %ref_sleep_inv% := interval.Value
    %ref_rad_ina_status% := radio_inactive.value
    app_name_list := get_list()
    update_ddl(chosen_app, app_name_list)
    afkgui.Show("w250 h330")
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
        show_hrs.text := "0" hrs " : "
    }else{
        show_hrs.text := hrs " : "
    }
    if (%ref_mins% < 10){
        show_mins.text := "0" mins " : "
    }else{
        show_mins.text := mins " : "
    }
    if (%ref_secs% < 10){
        show_secs.text := "0" secs " : "
    }else{
        show_secs.text := secs " : "
    }
    return
}

get_list(*){
    list := WinGetList()
    for index, appid in list{
        list[index] := WinGetProcessName("ahk_id " list[index])
        if (list[index] = "GTA5.exe"){
            tmp := list[1]
            list[1] := list[index]
            list[index] := tmp
        }
    }
    i := 1
    while i <= list.length{
        if (list[i] = "explorer.exe" OR list[i] = "hh.exe" OR list[i] = "svchost.exe" OR list[i] = "GTA_AFK_v3 re.exe"){
            list.RemoveAt(i)
            i -= 1
        }
        i += 1
    }
    return list
}

update_ddl(past_choice, app_name_list){
    if (past_choice = 0){
        app_choose.delete()
        app_choose.Add(app_name_list)
        afkgui.Show("w250 h330")
        return
    }else{
        app_choose.delete()
        app_choose.Add(app_name_list)
        app_found := False
        for index, app in app_name_list{
            if (app_name_list[index] = past_choice){
                app_choose.choose(index)
                app_found := True
            }
        }
        if (!app_found){
            ;app_choose.choose(1)
            MsgBox past_choice " does not exist!", "Error", 16
        }
    }
}

app_nonexist_loop(exe_name){
    global app_name_list
    gui_pause()
    MsgBox exe_name " does not exist!", "Error", 16
    app_name_list := get_list()
    update_ddl(0, app_name_list)
    Pause
}

loop_ina_gta(key_down, key_up, s_inv, h_inv){
    global app_name_list
    top_win_id := WinGetId("A")
    target_exe := app_name_list[app_choose.value]
    if (!app_choose.value){
        gui_pause()
        MsgBox "Please choose a target window.", "Error", 16
        app_name_list := get_list()
        update_ddl(0, app_name_list)
        Pause
    }else{
        WinSetAlwaysOnTop 1, "ahk_id " top_win_id
        if (WinExist("ahk_exe " target_exe)){
            WinActivate "ahk_exe " target_exe
        }else{
            app_nonexist_loop(target_exe)
        }
        Send key_down
        Sleep h_inv
        Send key_up
        if (WinExist("ahk_exe " target_exe)){
            WinMinimize "ahk_exe " target_exe
        }else{
            app_nonexist_loop(target_exe)
        }
        WinSetAlwaysOnTop 0, "ahk_id " top_win_id
        Sleep s_inv*1000
    }
}
loop_ina(key_down, key_up, s_inv, h_inv){
    global app_name_list
    target_exe := app_name_list[app_choose.value]
    if (!app_choose.value){
        gui_pause()
        MsgBox "Please choose a target window.", "Error", 16
        app_name_list := get_list()
        update_ddl(0, app_name_list)
        Pause
    }else{
        if (WinExist("ahk_exe " target_exe)){
            ControlSend key_down,, "ahk_exe" target_exe
        }else{
            app_nonexist_loop(target_exe)
        }
        Sleep h_inv
        if (WinExist("ahk_exe " target_exe)){
            ControlSend key_up,, "ahk_exe" target_exe
        }else{
            app_nonexist_loop(target_exe)
        }
        Sleep s_inv*1000
    }

}

loop
{
    if (rad_ina_status = 1){
        if(app_choose.value){
            if (app_name_list[app_choose.value] = "GTA5.exe"){
                loop_ina_gta(k1_d, k1_u, sleep_inv, 650)
                loop_ina_gta(k2_d, k2_u, sleep_inv, 650)
            }else{
                loop_ina(k1_d, k1_u, sleep_inv, 1000)
                loop_ina(k2_d, k2_u, sleep_inv, 1000)
            }
        }else{
            gui_pause()
            MsgBox "Please choose a target window.", "Error", 16
            app_name_list := get_list()
            update_ddl(0, app_name_list)
            Pause
        }
    }else{
        Send k1_d
        Sleep 1000
        Send k1_u
        Sleep sleep_inv*1000
        Send k2_d
        Sleep 1000
        Send k2_u
        Sleep sleep_inv*1000
    }
}

#Esc::gui_exit()
#`::afkgui.Show("w250 h330")

;@Ahk2Exe-SetDescription GTA_AFK_v1.3.0
;@Ahk2Exe-SetVersion 1.3.0
