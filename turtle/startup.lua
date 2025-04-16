--                  This is the script that must be inputted into the Turtle to establish the connection to the WebSocket                    --

os.loadAPI("json")
-- NGROK url --
local ws, err = http.WebSocket("wss://placeholder.net:5757")

if err then
        print("ws error: " .. err)

else if ws then
        print("> connected")
        while true do
                local message = ws.recieve()
                print("recieved: " .. ws)

                local obj = json.decode(message)
                if obj.type == 'eval' then
                        if obj.command == "forward" then
                                turtle.forward()
                        elseif obj.command == "back" then
                                turtle.back()
                        elseif obj.command == "dig" then
                                turtle.dig()
                        end
                end
        end
end