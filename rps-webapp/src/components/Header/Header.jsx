import { ethers } from "ethers"
import { useState } from "react"
import { Link } from "react-router-dom"
import styles from "./Header.module.css"

const Header = () => {
	const [userWalletAddress, setUserWalletAddress] = useState("Connect")
	let state = {}
	let isConnected = false

	let requestAccounts = async () => {
		state.provider = new ethers.providers.Web3Provider(window.ethereum)
		await state.provider.send("eth_requestAccounts", [])
		state.signer = state.provider.getSigner()
		setUserWalletAddress(await state.signer.getAddress())
	}

	return (
		<div className={styles.header}>
			<Link to={"/search-room"} className={styles.logo}>
				Rock! Paper! Scissors!
			</Link>
			<button
				className={styles.connectWalletButton}
				onClick={async () => {
					try {
						await requestAccounts()
						!isConnected
					} catch (e) {
						alert(e.message)
					}
				}}
			>
				{userWalletAddress}
			</button>
		</div>
	)
}
export default Header
