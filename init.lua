print(string.format("\n\n---\nRELOAD\n---\n"))

-- Provide the script access to the relevant modules
package.path = os.getenv("HOME") .. "/.hammerspoon/modules/?.lua; " .. package.path

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
print(hs.network.interfaceName())
--]]