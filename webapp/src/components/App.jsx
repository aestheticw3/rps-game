import styles from "./App.module.css";
import Header from "./Header/Header";
import Main from "./Main/Main";
function App() {
  return (
    <div className="App" style={styles.title}>
      <Header />
      <Main />
    </div>
  );
}

export default App;
