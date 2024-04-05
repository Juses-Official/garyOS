--i think this prevents you from closing the program
os.pullEvent = os.pullEventRaw

settings.set("shell.allow_disk_startup", false)
settings.save()

os.loadAPI("bigfont")

--this function clears the terminal and sets the the cursor at 1,1
local function resetTerm ()
    term.clear()
    term.setCursorPos(1,1)
end

--loading fake loading graphic upon startup
term.setTextColor(colors.white)
resetTerm()

local termLength, termHeight = term.getSize()
bigfont.writeOn(term,1,"garyOS", nil,termHeight/4)
term.setCursorPos(termLength/2 - 12,termHeight/2)
print("Press any key to continue...")
local _,key = os.pullEvent("key")
sleep(0.2)

resetTerm()

--settings the users name as the inputed string
write("Enter Name: ") 
local userName = read()
settings.define("userName")
settings.set("userName", userName)
settings.save()

local password = "1"
local passAttempts = 5
local userInputPass --the password guess from the user

--while the inputed string doesnt match the password it keeps asking until correct
settings.define("admin")
settings.set("admin", false)
settings.save()

--runs while the password isnt equal to the default or admin password
while userInputPass ~= password and userInputPass ~= "admin"
do
    --prompts the user for the password and decrements passAttempts
    resetTerm()
    write("Enter Password: ")
    passAttempts = passAttempts - 1
    userInputPass = read("*")
    
    --if the user gets the password wrong 5 times in a row, the computer is rebooted
    if passAttempts <= 0 then
        term.setTextColour(colors.red)
        textutils.slowPrint("Failed Password 5 Times, rebooting...",5)
        shell.execute("reboot")
    end

    --if the password is the admin password the user gains admin privilages
    if userInputPass == "admin" then
        settings.set("admin", true)
        settings.save()
    end
end

--shell.run("resetTerminal")
resetTerm()
if userInputPass == "admin" then
    shell.run("os/menu", "Terminal", "os/resetTerminal.lua", "Reboot", "os/qReboot.lua", "Shutdown", "shutdown")
else 
    shell.run("os/menu", "Programs", "os/programMenu.lua", "Reboot", "os/qReboot.lua", "Shutdown", "shutdown")
end