shell.run("rename disk/startup.lua disk/.startup.lua")

local faces = {"top","bottom","right","left","front","back"}
for i = 1,6,1 do
    shell.run("eject "..faces[i])
end

if not settings.get("admin") then
    shell.run("os/menu.lua")
end