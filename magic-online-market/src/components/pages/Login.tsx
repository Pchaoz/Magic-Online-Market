import { Link } from "react-router-dom"

const handleLogin = (event: React.MouseEvent) => {
  event.preventDefault();
  console.log(event);
}

const Login = () => {
  return (
    <>
      <form onSubmit={(event) => handleLogin} className="vh-100">
        <div className="container py-5 h-100">   
            <div className="row d-flex justify-content-center align-items-center h-100">
                <div className="col-12 col-md-8 col-lg-6 col-xl-5"> 
                    <div className="card bg-dark text-white" style={{borderRadius: "1rem"}}>
                        <div className="card-body p-5 text-center"> 

                            <div className="mb-md-5 mt-md-4 pb-5"> 
                                <h2 className="fw-bold mb-2 text-uppercase">Inicio de sesión</h2>
                                <p className="text-white-50 mb-5">Porfavor indica tu usario y contraseña!</p>

                                <div className="form-outline form-white mb-4">
                                    <input type="text" id="typeUserX" className="form-control form-control-lg" />
                                    <label className="form-label"  htmlFor="typeUserX">Ususario</label>
                                </div>

                                <div className="form-outline form-white mb-4">
                                    <input type="password" id="typePasswordX" className="form-control form-control-lg" />
                                    <label className="form-label" htmlFor="typePasswordX">Contraseña</label>
                                </div>
                            </div>

                            <p className="small mb-5 pb-lg-2"><Link className="text-white-50" to="#">Has olvidado tu contraseña?</Link></p>

                            <button className="btn btn-outline-light btn-lg px-5" type="submit">Iniciar sesión</button>

                            <div>
                              <p className="mb-0">No tienes cuenta? <Link to="/register" className="text-white-50 fw-bold">Registrate</Link></p>
                            </div>
                        </div>
                        
                    </div>
                </div>
            </div>
        </div>
      </form>
    </>
    
  )
}

export default Login
