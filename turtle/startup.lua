--                  This is the script that must be inputted into the Turtle to establish the connection to the WebSocket                    --

-- NGROK url --
local ws, err = http.websocket("wss://<NGROK_URL>")

-- JSON in fromat of { "type": "<what kind of action>", "command": "<what turtle does>" } --
-- JSON out format of { "type": "<what were sending back>", "up": "<what turtle sees up>", "down": "<what turtle sees down>", "forward": "<what turtle sees forward>" } --
if ws then
        print("> connected")
        parallel.waitForAny(listenForMessages, dataBack)            
else
        print("> error: " .. err)
end

local function listenForMessages()
    while true do
        print("Waiting for message...")
        local message = ws.receive()
        
        if message then
            local obj = textutils.unserializeJSON(message)
           
            if obj == nil then
                print("Failed to parse JSON.")
            else
                print("Parsed JSON.")
        
                if obj.type == "eval" then
                    if obj.command == "forward" then
                        turtle.forward()
                    elseif obj.command == "back" then
                        turtle.back()
                    elseif obj.command == "dig" then
                        turtle.dig()
                    elseif obj.command == "down" then
                        turtle.down()
                    elseif obj.command == "up" then
                        turtle.up()
                    elseif obj.command == "turnLeft" then
                        turtle.turnLeft()
                    elseif obj.command == "turnRight" then
                        turtle.turnRight()
                    else
                        print("Unknown command: " .. tostring(obj.command))
                    end
                else
                    print("Unknown message type: " .. tostring(obj.type))
                end
            end

        end
    end
end

local function dataBack()
    
    while true do
        local up = turtle.inspectUp()
        local down = turtle.inspectDown()
        local forward = turtle.inspect()

        local inspectData = {
            type = "inspect",
            up = up,
            down = down,
            forward = forward
        }

        local jsonData = textutils.serializeJSON(inspectData)
        print("sending data")
        ws.send(jsonData)
        sleep(3) -- 1 second delay between data updates

    end

end
