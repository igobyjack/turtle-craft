const socket = require("ws");
var clients = [];
const webSocket = new socket.Server({ port: 5757});

webSocket.on("connection", wsClient => {

    console.log("Client connected");

    clients.push(wsClient);

    wsClient.on("message", messageData => {
        console.log("Received message: " + messageData.toString());
        
        clients.forEach(function(client) {
            client.send(messageData.toString());
        });
    
    })

    wsClient.on("close", () => { console.log("Client disconnected");});

})