--                  This is the script that must be inputted into the Turtle to establish the connection to the WebSocket                    --

local socket = "ws://localhost:5757"

local ws, err = http.websocket(socket)

if ws then
    print('connection estasblished')

    local dataOut = {
        message = "Hello world - turtle"
    }

    local jsonData = textutils.serializeJSON(dataOut)
    ws.send(jsonData)

    ws.close()
else
    print('error: ' .. err)
end