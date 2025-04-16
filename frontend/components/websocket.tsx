'use client'

import { useState, useEffect } from 'react';
import styles from "./websocket.module.css";

export default function WebSocketComponent() {
        const [command, setCommand] = useState("");
        const [socket, setSocket] = useState<WebSocket | null>(null);
        const [status, setStatus] = useState("**loading**");
        
        useEffect(() => {
                const wsURL = process.env.NEXT_PUBLIC_WS_URL;
                if (!wsURL) {
                        console.error("WebSocket connection not found/defined.");
                        setStatus("Not Found")
                        return;
                }

                const ws = new WebSocket(wsURL);


                ws.onopen = () => {
                        console.log("WebSocket connected");
                        setStatus("Connected")
                };

                ws.onerror = () => {
                        console.error("WebSocket encountered a fatal error");
                        setStatus("Fatal Error")
                }

                setSocket(ws);

                // clean up socket when component is unmounted
                return () => {
                        ws.close();
                        setStatus("Closed")
                };
        }, []);

        const handleSubmit = (el: React.FormEvent) => {
                el.preventDefault();
                if (socket && command) {
                        console.log(`Sending command: ${command}`);
                        setStatus("Sending Command")
                        socket.send(command);
                        setCommand("");
                }
        };

        return (
                <div className="divWrapper">
                        <span>put the command here 🙂</span>
                        <form onSubmit={handleSubmit}>
                                <input type="text" value={command} onChange = {(el) => setCommand(el.target.value)}/>
                                <input type="submit" value="execute" />
                        </form>
                        <span style={{border: "solid white 1px", marginTop:"10px", padding: "25px", display: "inline-block"}}>Websocket Status: <span id='status'>{status}</span></span>
                </div>
        )
}