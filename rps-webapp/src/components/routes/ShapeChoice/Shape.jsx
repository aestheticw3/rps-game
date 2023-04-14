import styles from "./Shape.module.scss"
const Shape = props => {
	return <div className={styles.shape}>{props.shape}</div>
}
export default Shape
