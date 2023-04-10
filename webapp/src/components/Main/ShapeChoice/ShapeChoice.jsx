import styles from "./ShapeChoice.module.css";
import Shape from "./Shape";
const ShapeChoice = () => {
  return (
    <div className={styles.shapechoice}>
      <h1 className={styles.title}>Choose your shape!</h1>
      <div className={styles.shapes}>
        <Shape shape="👊" />
        <Shape shape="🤚" />
        <Shape shape="✌️" />
      </div>
    </div>
  );
};
export default ShapeChoice;
