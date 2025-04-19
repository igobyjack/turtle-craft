--                  This is the script that must be inputted into the Turtle to establish the connection to the WebSocket                    --

--turtles dont have a compass so direction it be tracked manually 
--      1
--  4       2
--      3
local direction = 1

local function handleTurn(type)
    if type == "left" then
        direction =- 1
        if direction < 1 then
            direction = 4
        end
    elseif type == "right" then
        direction += 1
        if direction > 4 then
            direction = 1
        end
    end
end


-- NGROK url --
local ws, err = http.websocket("wss://<NGROK_URL>")

-- planned JSON format: 

if ws then
        print("> connected")
        while true do
                local message = ws.receive()
                print("received raw message: " .. tostring(message))
            
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
                            handleTurn("left")
                        elseif obj.command == "turnRight" then
                            turtle.turnRight()
                            handleTurn("right")
                        else
                            print("Unknown command: " .. tostring(obj.command))
                        end
                    --we want data to be sent back to the server from the turtle
                    --current JSON format: {type = "inspectResult", up={<INSPECT UP>, down=<INSPECT DOWN>, forward=<INSPECT FORWARD>}
                    elseif obj.type =="ping" then
                        if obj.command =="test" then
                            print("ping recieved")
                            ws.send("pong")
                        elseif obj.command =="inspect" then
                            local up = turtle.inspectUp()
                            local down = turtle.inspectDown()
                            local forward = turtle.inspect()
                            local data = {
                                type = "inspectResult",
                                up = up,
                                down = down,
                                forward = forward
                            }
                            local jsonData = textutils.serializeJSON(data)
                            ws.send(jsonData)
                        end
                    end
                end
            end
            
else
        print("> error: " .. err)
end
