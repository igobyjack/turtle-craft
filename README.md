# THE BACKEND
Turtles will communicate to my (alockinalock) localhost on port 5757 through ngrok tunneling. this is subject to change once we reach prod deployment, in which we must phase out ngrok for a production-ready library

# THE FRONTEND
The front end folder will stage our react components, hosted on nextjs & Vercel

# TURTLE
The turtle will listen as commands come through the websocket, and perform actions accordingly. The turtle will also transmit data about what it sees and its current status back across the websocket, in parallel.
