import {Routes, Route} from 'react-router-dom'
import Home from "./components/pages/Home";
import About from "./components/pages/About";
import Navbar from './components/util/Navbar';
import Login from './components/pages/Login';
import Register from './components/pages/Register';

function App() {

  return (
    <>
      <Navbar/>
      <Routes>
        <Route path="/" element={ <Home /> }> </Route>
        <Route path="/about" element={ <About /> }></Route>
        <Route path="/login" element={ <Login /> }></Route>
        <Route path="/register" element={ <Register /> }></Route>
      </Routes>
    </>
  )
  
  
}

export default App;