-- Provide the script access to the relevant modules
package.path = os.getenv("HOME") .. "/.hammerspoon/modules/?.lua; " .. package.path

local try = require("try")

-- ============================================================================
--  
local M = {}

local screens = {}
local scanForScreens = function()
    try{
        func=function() 
            print("Checking screens... ")
            allScreens = hs.screen.allScreens()
            for i, screen in ipairs(allScreens) do
                x, y = screen:position()
                mode = screen:currentMode()
                screens[i] = {
                    hs_screen=screen,
                    name=screen:name(),
                    desc=mode.desc,
                    pos={
                        x=x,
                        y=y
                    },
                    size={
                        w=mode.w,
                        h=mode.h
                    }
                }
            end
        end, 
        accept=function() print("... screen check complete.") end,
        reject=function() print("... screen check failed.") end
    }
end

local sortScreens = function()
    -- TODO
end

local setupUrlEvents = function()
    try{
        func=function()
            -- Usage: open -g hammerspoon://cursor?toScreen=<screen_id>
            hs.urlevent.bind("cursor", function(eventName, params)
                try {
                    func=function() 
                        paramName="toScreen"
                        if params[paramName] then
                            id = tonumber(params[paramName])
                            M.centerCursorInScreen(id)
                        end
                    end
                }
            end)
        end
    }
end

function M.scan()
    scanForScreens()
    sortScreens()
    return screens
end

function M.getScreens()
    return screens
end

function M.centerCursorInScreen(screenId)
    screen = screens[screenId]
    x=screen.size.w/2
    y=screen.size.h/2
    hs.mouse.setRelativePosition({ x=x, y=y }, screen.hs_screen)
end

function M.init()
    scanForScreens()
    setupUrlEvents()
end

return M
-- ----------