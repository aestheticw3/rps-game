import Emoji from "../../ui/Emoji"
import styles from "./SearchRoom.module.css"

const SearchRoom = () => {
	return (
		<div className={styles.searchRoom}>
			<Emoji emoji="🤠" />
			<h1 className={styles.title}>Search room</h1>
			<button className={styles.searchBtn}>LET'S GO!</button>
		</div>
	)
}
export default SearchRoom
