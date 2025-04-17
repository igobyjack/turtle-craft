--                  This is the script that must be inputted into the Turtle to establish the connection to the WebSocket                    --

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
                        else
                            print("Unknown command: " .. tostring(obj.command))
                        end
                    else
                        print("Unknown message type: " .. tostring(obj.type))
                    end
                end
            end
            
else
        print("> error: " .. err)
end