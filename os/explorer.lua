local dir = ...
if ... == nil then
    dir = "os/programs/"
end

local files = fs.list(dir)
local filesLen = table.getn(files)
local menuRunArgs = "os/menu.lua back os/menu.lua"

for i = 1,filesLen,1 do
    if fs.isDir(dir..files[i]) then
        menuRunArgs = menuRunArgs.." "..files[i].."/"
        menuRunArgs = menuRunArgs.." "..dir..files[i]
    else
        menuRunArgs = menuRunArgs.." "..files[i]
        menuRunArgs = menuRunArgs.." "..dir..files[i]
    end
end
--[[
for i = 1,table.getn(menuList),1 do
    print(menuList[i])
end
]]
--print(menuRunArgs)
shell.run(menuRunArgs)