import WebSocket, { WebSocketServer } from "ws";
import { connect } from "ngrok";

const wss = new WebSocketServer({ port: 5757 });

wss.on("connection", ws => {
  console.log("Client connected");

  ws.on("message", message => {
    console.log("Received from React:", message);
    wss.clients.forEach(client => {
      if (client.readyState === WebSocket.OPEN) {
        client.send(message);
      }
    });
  });

  ws.on("close", () => console.log("Client disconnected"));
});

(async () => {
  const url = await connect({ proto: "http", addr: 5757 });
  console.log("Tunnel URL:", url);  
})();
