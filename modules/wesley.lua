local json = require('json')

local lastWindow = {
    host='',
    name='',
    app='',
    epoch=''
}

-- local today = os.date('*t')
-- print(hs.json.encode(today))
-- local outputFile = "wesley" .. today['year'] .. "." .. today['month'] .. "." .. today['day'] .. ".csv"

local dbPath = os.getenv("HOME") .. "/Desktop/wesley.db"
-- print(dbPath)
local db = hs.sqlite3.open(dbPath)
-- print(db)

result = db:execute('SELECT count(*) FROM log;')
if result == hs.sqlite3.OK
then
else
    db:execute("CREATE TABLE 'log' ( 'hostname' TEXT NOT NULL, 'app_name' TEXT NOT NULL, 'window_title' TEXT NOT NULL, 'epoch' INTEGER NOT NULL)")
    print('Created table log.')
end


hs.timer.doEvery(
    3, -- 3 seconds
    function() 
    try {
        func=function() 
            -- windows = hs.window.allWindows()
            -- tableDump(windows)
            -- 
            -- print(" ")
            primaryWindow = hs.window.focusedWindow()

            if primaryWindow:title():match('^[0-9:]+.*Clockify.*') or primaryWindow:title() == ''
            then
                print(primaryWindow.title())
            else 
                if lastWindow.name == primaryWindow:title() and lastWindow.host == hs.host:localizedName()
                then
                else
                    lastWindow.host = hs.host:localizedName()
                    lastWindow.name = primaryWindow:title()
                    lastWindow.app = primaryWindow:application():name()
                    lastWindow.epoch = os.time()
                    print(hs.json.encode(lastWindow, true))
                    result = db:execute("INSERT INTO log VALUES (" .. 
                        "\"" .. lastWindow.host .. "\"," .. 
                        "\"" .. lastWindow.app .. "\"," .. 
                        "\"" .. lastWindow.name .. "\"," .. 
                        lastWindow.epoch ..
                        ")")
                    if result == hs.sqlite3.OK
                    then
                        print('Insert successful.')
                    else
                        print('Insert resulted in error code: ' .. result)
                        print(db:errmsg())
                    end
                end
            end

        end

    }
end)