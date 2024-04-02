import { ReactNode } from "react";

interface Props  {
    children: ReactNode;
    onClose: () => void
}

const Altert = ({ children, onClose}: Props) => {
  return (
    <div className="alert alert-primary">
      {children}
      <button onClick={onClose} type="button" className="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
    </div>
  )
}

export default Altert