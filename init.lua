print(string.format("\n\n---\nRELOAD\n---\n"))

-- Promise-esque error handling mechanism
function try(_athing)
    if pcall(_athing.func) then
        if _athing.accept then _athing.accept() end
    else
        if _athing.reject then _athing.reject() end
    end
    if _athing.finally then _athing.finally() end
end

--
_screens = {}

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

-- ============================================================================
--  Automatic config reloading
try{
    func=function()
        print("Setting up automatic config reload...")
        hs.pathwatcher.new(os.getenv("HOME") .. "/.hammerspoon/", function(files)
            doReload = false
            for _,file in pairs(files) do
                if file:sub(-4) == ".lua" then
                    doReload = true
                end
            end
            if doReload then
                hs.reload()
            end
        end):start()
    end,
    accept=function()
        print("... automatic config reload setup complete.")
    end,
    reject=function()
        print("... automatic config reload setup failed.")
    end
}
-- ----------

-- ============================================================================
--  Screens 
try{
    func=function() 
        print("Checking screens... ")
        screens = hs.screen.allScreens()
        for i, screen in ipairs(screens) do
            x, y = screen:position()
            mode = screen:currentMode()
            _screens[i] = {
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
-- ----------

-- ============================================================================
--  Set the cursor position. 
-- 
--      Usage: open -g hammerspoon://cursor?x=<x_value>&y=<y_value>
--
try{
    func=function()
        hs.urlevent.bind("cursor", function(eventName, params)
            try {
                func=function() 
                    paramName="toScreen"
                    if params[paramName] then
                        id = tonumber(params[paramName])
                        screen = _screens[id]
                        x=screen.size.w/2
                        y=screen.size.h/2
                        hs.mouse.setRelativePosition({ x=x, y=y })
                    end
                end
            }
        end)
    end
}
-- ----------