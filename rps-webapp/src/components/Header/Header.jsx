import styles from "./Header.module.css";
import { useState } from "react";
import { ethers } from "ethers";

const Header = () => {
  let state = {};
  const [userWalletAddress, setUserWalletAddress] = useState("CONNECT");

  let requestAccounts = async () => {
    state.provider = new ethers.providers.Web3Provider(window.ethereum);
    await state.provider.send("eth_requestAccounts", []);
    state.signer = state.provider.getSigner();
    setUserWalletAddress(await state.signer.getAddress());
  };

  return (
    <div className={styles.Header}>
      <a href="index.html" className={styles.title}>
        ROCK! PAPER! SCISSORS!
      </a>
      <button
        className={styles.connectWalletButton}
        onClick={async () => {
          try {
            await requestAccounts();
          } catch (e) {
            alert(e.message);
          }
        }}
      >
        {userWalletAddress}
      </button>
    </div>
  );
};
export default Header;
