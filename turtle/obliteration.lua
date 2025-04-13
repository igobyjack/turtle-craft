turtle.refuel()

local depth = 2
local bogoda = 40
local left = true
function dropJunk()
    local junk = {
        ["minecraft:cobblestone"] = true,
        ["minecraft:dirt"] = true,
        ["minecraft:gravel"] = true,
        ["minecraft:flint"] = true,
        ["minecraft:diorite"] = true,
        ["minecraft:andesite"] = true,
        ["minecraft:granite"] = true,
        ["minecraft:tuff"] = true,
        ["minecraft:calcite"] = true,
        ["minecraft:stone"] = true,
        ["minecraft:basalt"] = true,
        ["minecraft:deepslate"] = true,
        ["minecraft:cobbled_deepslate"] = true
    }

    for i = 1, 16 do
        local detail = turtle.getItemDetail(i)
        if detail and junk[detail.name] then
            turtle.select(i)
            turtle.drop() 
        end
    end
    turtle.select(1) 
end


function tossItems()
    if turtle.detectUp() then
        turtle.digUp()
    end
    for i = 1, 16 do
        local detail = turtle.getItemDetail(i)
        if detail and (detail.name == "dimstorage:dimensional_chest") then
            turtle.select(i)
            turtle.placeUp()
            break 
        end
    end

    for i=1, 16 do
        turtle.select(i)
        local detail = turtle.getItemDetail(i)
        if detail and detail.name ~= "minecraft:coal" and detail.name ~= "minecraft:coal_block" then
                turtle.dropUp()
        end
    end

    turtle.digUp()
end

function findFuel()
    for i = 1, 16 do
        local detail = turtle.getItemDetail(i)
        if detail and (detail.name == "minecraft:coal" or detail.name == "minecraft:coal_block") then
            turtle.select(i)
        end
    end
end


for d = 1, depth do
    for w = 1, bogoda do
        for l = 1, bogoda - 1 do
            turtle.dig()
            turtle.forward()
        end

        if w < bogoda then
            if w % 2 == 1 then
                turtle.turnRight()
                turtle.dig()
                turtle.forward()
                turtle.turnRight()
            else
                turtle.turnLeft()
                turtle.dig()
                turtle.forward()
                turtle.turnLeft()
            end
            tossItems()
        end
    end

    if bogoda % 2 == 1 then
        turtle.turnRight()
    else
        turtle.turnLeft()
    end

    turtle.turnRight()
    turtle.turnRight()

    if d < depth then
        turtle.digDown()
        turtle.down()
        findFuel()
        turtle.refuel()
        dropJunk()
        tossItems()
    end
end