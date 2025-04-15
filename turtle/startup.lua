--socket address
local socket = "ws://localhost:5757"

ws, err = http.websocket(socket)

local function receiveMessages()
    while true do
      local event, receivedWs, message = os.pullEvent("websocket_message")
      if receivedWs == ws then
        print("Received message: " .. tostring(message))
      end
    end
  end  

local function sendMessages()
    while true do
        local input = read()
        if input == "exit" then
            break
        end
        ws.send(input)
        print("Sent message: " .. input)
    end
end

parallel.waitForAny(receiveMessages, sendMessages)

ws.close()
print("closed socket")