home = os.getenv("HOME")
package.path =  home .. "/.hammerspoon/modules/?.lua;" ..
                home .. "/.hammerspoon/modules/?/init.lua;"  ..
                home .. "/.hammerspoon/modules/vendor/?.lua;" ..
                home .. "/.hammerspoon/modules/vendor/?/init.lua;"  ..
                home .. "/.hammerspoon/.luarocks/share/lua/5.3/?.lua;" ..
                home .. "/.hammerspoon/.luarocks/share/lua/5.3/?/init.lua;" ..
                package.path