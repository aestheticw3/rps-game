import { Route, Routes } from "react-router-dom"
import styles from "./Main.module.css"
import SearchRoom from "../routes/SearchRoom/SearchRoom"
import ShapeChoice from "../routes/ShapeChoice/ShapeChoice"

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
