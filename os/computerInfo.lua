if os.getComputerLabel() == nil then
    print("This computer isnt labeled")
else
    print("The name of this computer is","'"..os.getComputerLabel().."'")
end

print("The current user is",settings.get("userName"))
print("You are on Computer",os.getComputerID())
if settings.get("admin") then
    print("You have administrator access")
end