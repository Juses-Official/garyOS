term.clear()
local termLength, termHeight = term.getSize()
local snakePos = {math.floor(termLength/2),math.floor(termHeight/2)}
local function printColoredAt (a,b,color)
    term.setCursorPos(a,b)
    term.setTextColor(color)
    write("#")
end

for i = 1,termLength,1 do
    printColoredAt(i,1,colors.yellow)
    printColoredAt(i,termHeight,colors.yellow)
    printColoredAt(1,i,colors.yellow)
    printColoredAt(termLength,i,colors.yellow)
end

term.setTextColor(colors.green)
local snakeMoveDir = {0,1}
local event, key = os.pullEvent("key")

local function waitForKey ()
    event, key = os.pullEvent("key")
    sleep(0.1)
end

local function dummy ()
    sleep(0.1)
end


while true do 
    parallel.waitForAny(dummy,waitForKey)

    if key == keys.up then
        snakeMoveDir = {0,-1}
    elseif key == keys.down then
        snakeMoveDir = {0,1}
    elseif key == keys.right then
        snakeMoveDir = {1,0}
    elseif key == keys.left then
        snakeMoveDir = {-1,0}
    elseif key == keys.space then
        shell.run("os/menu.lua")
    end

    snakePos = {snakePos[1] + snakeMoveDir[1], snakePos[2] + snakeMoveDir[2]}
    term.setCursorPos(snakePos[1], snakePos[2]) 
    write("#")
end
