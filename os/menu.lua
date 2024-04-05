local args = {...}
--if no args are provided it sets it as the default non-admin menu
if ... == nil then
    args = {"Programs", "os/programMenu.lua", "Reboot", "os/qReboot.lua", "Shutdown", "shutdown"}
end
local menuOptions = args
local menuLength = table.getn(menuOptions)
local currentMenuPos = 1
local termLength, termHeight = term.getSize()
term.setTextColor(colors.white)
term.clear()

--this function sets up the menu (hence the name) by printing each menu item, with square brackets if its selected
local function setupMenu ()
    bigfont.writeOn(term,1,"garyOS", nil,termHeight/4)

    for i = 1,menuLength / 2,1 do
        if i == currentMenuPos then
            term.setCursorPos(math.floor(termLength/2) - math.ceil(string.len(menuOptions[i * 2 - 1]) / 2) - 2,math.floor(termHeight/2) + i)
            print("[",menuOptions[i * 2 - 1],"]")
        else
            term.setCursorPos(math.floor(termLength/2) - math.ceil(string.len(menuOptions[i * 2 - 1]) / 2),math.floor(termHeight/2) + i)
            print(menuOptions[i * 2 - 1])
        end
    end
end

term.clear()
setupMenu()

--forever checks whether the right keys are pressed and switches which menu item is chosen accordingly
while true do
    local _, key = os.pullEvent("key")

    if key == keys.up then
        term.clear()
        currentMenuPos = math.ceil((currentMenuPos + menuLength/2 - 1) % (menuLength/2 + 0.01))
        setupMenu()
    elseif key == keys.down then
        term.clear()
        currentMenuPos = math.ceil((currentMenuPos + 1) % (menuLength/2 + 0.01))
        setupMenu()
    end

    --runs the argument containing the file name and path
    if key == keys.enter then
        if fs.isDir(menuOptions[currentMenuPos * 2]) then
            shell.run("os/explorer.lua "..menuOptions[currentMenuPos * 2])
        else
            shell.run(menuOptions[currentMenuPos * 2])
        end
        error()
    end
end