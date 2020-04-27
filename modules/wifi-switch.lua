
wifi_switch_workspace = {
    last_power_state=nil
}

hs.timer.doEvery(10, function() 
    wired_ip = "192.168.0.123"
    wired_ip_found = false
    for i, v in  ipairs(hs.network.addresses()) do
        if v == wired_ip then
            wired_ip_found = true
            break
        end
    end
    power_state = not wired_ip_found
    if not (wifi_switch_workspace.last_power_state == power_state) then
        hs.wifi.setPower(power_state)
        wifi_switch_workspace.last_power_state = power_state
        if power_state then
            print("Turning wifi on.")
        else
            print("Turning wifi off.")
        end
    end
end)

