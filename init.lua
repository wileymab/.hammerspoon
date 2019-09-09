print(string.format("\n\n---\nRELOAD\n---\n"))

-- Provide the script access to the relevant modules
home = os.getenv("HOME")
package.path =  home .. "/.hammerspoon/modules/?.lua;" ..
                home .. "/.hammerspoon/modules/?/init.lua;"  ..
                home .. "/.hammerspoon/modules/vendor/?.lua;" ..
                home .. "/.hammerspoon/modules/vendor/?/init.lua;"  ..
                home .. "/.hammerspoon/.luarocks/share/lua/5.3/?.lua;" ..
                home .. "/.hammerspoon/.luarocks/share/lua/5.3/?/init.lua;" ..
                package.path

local try = require("try")
local autoConfigReload = require("auto-config-reload")
local screenManager = require("screen-manager")

-- ============================================================================
--  Initializers
---[[
try{
    func=function()
        -- TODO Figure out eager module loading in Hammerspoon
        hs.mouse.trackingSpeed();
        hs.screen.screenPositions();
        hs.pathwatcher.new("", function() end);
        hs.urlevent.getDefaultHandler('http');
    end
}
--]]
-- ----------

autoConfigReload.start()
screenManager.init()


-- ============================================================================
--  Scratch space
---[[
local tableDump = require('pl.pretty').dump
-- print(tableDump(hs.network.interfaceName('en10')))
local json = require('json')


hs.timer.doEvery(3,function() 
    try {
        func=function() 
            windows = hs.window.allWindows()
            tableDump(windows)
            print(" ")
            primaryWindow = hs.window.focusedWindow()
            print("focusedWindow = " .. primaryWindow:title())
            print("focusedWindowScreen = " .. primaryWindow:screen():name())
            print("focusedApplication = " .. primaryWindow:application():name())
        end
    }
end)


statusCode, body, headers = hs.http.get('https://api.clockify.me/api/v1/user', {
    ['X-Api-Key']='XXLYCLJTBHWy1vc7'
})

print(tableDump(json.decode(body)))
--]]