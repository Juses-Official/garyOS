write("set label to:")
os.setComputerLabel(read())

if not settings.get("admin") then
    shell.run("os/menu.lua")
end