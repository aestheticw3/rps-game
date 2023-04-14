import { ethers } from "ethers"
import { useState } from "react"
import { Link } from "react-router-dom"
import styles from "./Header.module.scss"

const Header = () => {
	const [userWalletAddress, setUserWalletAddress] = useState("Connect")
	const [isConnected, setIsConnected] = useState(false)
	let state = {}
	let disconnectStyle = isConnected && styles.disconnectWalletButton

	let requestAccounts = async () => {
		state.provider = new ethers.providers.Web3Provider(window.ethereum)
		await state.provider.send("eth_requestAccounts", [])
		state.signer = state.provider.getSigner()
	}

	return (
		<div className={styles.header}>
			<div className={styles.container}>
				<Link to={"/search-room"} className={styles.logo}>
					Rock! Paper! Scissors!
				</Link>
				<button
					className={styles.connectWalletButton + " " + disconnectStyle}
					onClick={async () => {
						if (isConnected) {
							setUserWalletAddress("Connect")
							setIsConnected(!isConnected)
						} else {
							try {
								await requestAccounts()
								let userCurrentWallet = await state.signer.getAddress()
								setUserWalletAddress(
									userCurrentWallet.slice(0, 6) +
										"..." +
										userCurrentWallet.slice(36)
								)
								setIsConnected(!isConnected)
							} catch (e) {
								alert(e.message)
							}
						}
					}}
				>
					{userWalletAddress}
				</button>
			</div>
		</div>
	)
}
export default Header
