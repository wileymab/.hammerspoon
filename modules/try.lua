-- Promise-esque error handling mechanism
local try = function(_athing)
    if pcall(_athing.func) then
        if _athing.accept then _athing.accept() end
    else
        if _athing.reject then _athing.reject() end
    end
    if _athing.finally then _athing.finally() end
end

return try