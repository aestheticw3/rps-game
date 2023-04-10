import styles from "./Shape.module.css";
const Shape = (props) => {
  return <button className={styles.shape}>{props.shape}</button>;
};
export default Shape;
