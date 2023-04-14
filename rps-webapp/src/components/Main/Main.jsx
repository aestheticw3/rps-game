import { Route, Routes } from "react-router-dom"
import SearchRoom from "../routes/SearchRoom/SearchRoom"
import ShapeChoice from "../routes/ShapeChoice/ShapeChoice"
import styles from "./Main.module.scss"

const Main = () => {
	return (
		<div className={styles.main}>
			<div className={styles.container}>
				<Routes>
					<Route path="/search-room" element={<SearchRoom />} />
					<Route path="/shape-choice" element={<ShapeChoice />} />
				</Routes>
			</div>
		</div>
	)
}
export default Main
