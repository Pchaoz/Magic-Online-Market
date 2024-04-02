import { useState } from "react";
import Button from "./components/TestComponents/Button";
import Altert from "./components/TestComponents/Altert";



function App() {
  const [showAlert, setAlert] = useState(false);

  return (
    <div>
      {showAlert && <Altert onClose={() => setAlert(false)}> Hello <span> world </span> </Altert> }
      <Button color="dark" onClick={() => setAlert(true)}> Soy un boton </Button>
    </div>
  )
  
  
}

export default App;