import { WebSocketServer } from "ws";
import { connect } from 'ngrok';

const wss = new WebSocketServer({port:5757});

wss.on('connection', function connection(ws) {
        console.log('client connected');
        ws.on('message', function incoming(message) {
                console.log('recieved: %s', message);
        });

        ws.send('something')
});
(async () => {
        const url = await connect(5757);
        console.log('irl is: ' + url)
})();