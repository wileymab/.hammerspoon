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
local wifiSwitch = require("wifi-switch")

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
-- screenManager.init()

-- ============================================================================
--  Scratch space
---[[
local tableDump = require('pl.pretty').dump
-- print(tableDump(hs.network.interfaceName('en10')))
-- print(tableDump(hs.network.interfaces()))




---]]