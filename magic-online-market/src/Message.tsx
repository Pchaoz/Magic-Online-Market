//COMPONENTE DE PRUEBA

function Message() {

    //JSX: JavaScript XML
    const name = 'Mosh';
    if(name) 
        return <h1>Hello {name}</h1>;
    return <h1>Hello World</h1>
}

//SIEMPRE HAY QUE EXPORTAR EL COMPONENTE POR DEFECTO
export default Message;