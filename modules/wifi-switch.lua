-- Provide the script access to the relevant modules
package.path = os.getenv("HOME") .. "/.hammerspoon/modules/?.lua; " .. package.path

local try = require("try")

try{
    func=function()
        -- Eager load  the required extensions
        hs.network.interfaces()
    end
}

-- ============================================================================
--  Wifi State Switcher
local WifiSwitch = {
    last_power_state = nil
}

function WifiSwitch.start()
    try{
        func=function()
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
                if not (WifiSwitch.last_power_state == power_state) then
                    hs.wifi.setPower(power_state)
                    WifiSwitch.last_power_state = power_state
                    if power_state then
                        print("Turning wifi on.")
                    else
                        print("Turning wifi off.")
                    end
                end
            end)
        end,
        accept=function()
            print("Wifi Switcher started.")
        end,
        reject=function()
            print("Wifi Switcher failed to start properly.")
        end
    }
end

return WifiSwitch
-- ----------

