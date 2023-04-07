import styles from "./App.module.css";
import Header from "./components/Header/Header";
function App() {
  return (
    <div className="App" style={styles.title}>
      <Header />
    </div>
  );
}

export default App;
