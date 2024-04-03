import { Link } from 'react-router-dom'

const Navbar = () => {
  return (
    <>
        <nav className='navbar navbar-expand-lg bg-body-tertiary'>
            <div className="container-fluid"> 
                <a className="navbar-brand">Magic Online Market</a>
            </div>
            <div className="collapse navbar-collapse">
                <ul className="navbar-nav me-auto mb-2 mb-lg-0">
                    <li className='nav-item'>
                        <Link className='nav-link' to={'/'}>Home</Link>
                    </li>
                    <li className='nav-item'>
                        <Link className='nav-link' to={'/about'}>About</Link>
                    </li>
                    <li className='nav-item'>
                        <Link className='nav-link' to={'/login'}>Login</Link>
                    </li>
                    <li className='nav-item'>
                        <Link className='nav-link' to={'/register'}>Register</Link>
                    </li>
                </ul>
            </div>
        </nav>
    </>
  )
}

export default Navbar
