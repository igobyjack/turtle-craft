import { WebSocketServer } from "ws";
import { connect } from 'ngrok';

const wss = new WebSocketServer({port:5757});

interface Turtle {
        
}

wss.on('connection', function connection(ws) {
        ws.on('message', function incoming(message) {
                console.log('recieved: %s', message);
        });

        ws.send('something')
});
(async () => {
        const url = await connect(5757);
        console.log(url)
})();