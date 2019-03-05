-- Provide the script access to the relevant modules
package.path = os.getenv("HOME") .. "/.hammerspoon/modules/?.lua; " .. package.path

local try = require("try")

-- ============================================================================
--  Automatic config reloading
local M = {}

function M.start()
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
end

return M
-- ----------