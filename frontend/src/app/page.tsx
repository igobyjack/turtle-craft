import styles from "./page.module.css";
import Image from "next/image";
import WebSocketComponent from "../../components/websocket";

export default function Home() {
  return (
    <div className="mainWrapper">
      <main>
        <WebSocketComponent/>
        <Image
        src = "/alex-jones-infowars.gif"
        width={200}
        height={100}
        alt="alex jones saying jew repeatedly while expanding his hand"
        style={{paddingTop:"20px", height:"auto"}}
        />
      </main>
    </div>
  );
}
