import styles from "./Main.module.css";
import ShapeChoice from "./ShapeChoice/ShapeChoice";

const Main = () => {
  return (
    <div className={styles.main}>
      <ShapeChoice />
    </div>
  );
};
export default Main;
