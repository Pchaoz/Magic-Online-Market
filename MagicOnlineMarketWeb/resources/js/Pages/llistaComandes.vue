<script setup>

import 'bootstrap/dist/css/bootstrap.css'
import AuthenticatedLayout from "@/Layouts/AuthenticatedLayout.vue";
import {ref} from "vue";
import {useForm} from "@inertiajs/vue3";
import Modal from "@/Components/Modal.vue";
import InputLabel from "@/Components/InputLabel.vue";
import InputError from "@/Components/InputError.vue";


const props = defineProps({
    comandes:{
        type: Array(String),
    },
    titol:String,
    saldo:Number,
    direccions:{
        type: Array(String),
    },
    tipusEnviaments:{
        type: Array(String),
    },
    wishlists:{
        type: Array(String),
    },
});

const options = ref([
    {
        name:"Pagada",
        value:"Pagada"
    },
    {
        name:"Pendent preparacio",
        value:"Pendent preparacio"
    },
    {
        name:"Pendent recollida",
        value:"Pendent recollida"
    },
    {
        name:"Pendent enviament",
        value:"Pendent enviament"
    },
    {
        name:"Enviada",
        value:"Enviada"
    },
    {
        name:"Complerta",
        value:"Complerta"
    },
    {
        name:"Incidencia",
        value:"Incidencia"
    }
])

let showModalEliminacio = ref(false);
let showModalEliminacioConfirmacio = ref(false);
//-------Tramitacio Pagament------//
let showModalTramitacio = ref(false);
let showModalTramitacioConfirmacio = ref(false);
let showModalTramitacioIncorrecta = ref(false);
let showModalInsuficientSaldo = ref(false);
let showModalPagamentConfirmacio = ref(false);
//-----Confirmació enviament----//
let showModalTasca= ref(false);
let showModalConfirmacioTasca = ref(false);
//-----Administració de comandes-------//
let showModalAdministracio= ref(false);
let showModalAdministracioIncorrecta = ref(false);
//-----Anulació de comandes-------//
let showModalAnulacio = ref(false);
let showErrorAnulacio = ref(false);



const formComanda= useForm({
    idComanda:null,
    idDireccio:"",
    isEnviament:null,
    idTipusEnviament:null,
    totalSenseEnvaiment:0,
    totalFinal:0,
    comisio:0,
    estat:null,
    idWishlists:[],
})

const formAdminComanda=  useForm({
    idComanda:null,
    estat:null,
})


const eliminarLinia =()=> {
    formComanda.delete('/eliminarComanda');
    showModalEliminacio.value = false;
    showModalEliminacioConfirmacio.value = true;
    setTimeout(() => {
        showModalEliminacioConfirmacio.value = false;
        useForm.visit(window.location.pathname);
    }, 500);
}


const cerrarModalEliminacio =()=> {
    showModalEliminacio.value = false;
    showModalEliminacioConfirmacio.value = false;
}
//-------Tramitacio------//

const realizarTramit =(comanda)=> {
    formComanda.comisio=Number((comanda.total * 0.05).toFixed(2));
    if(1.00>Number(formComanda.comisio)){
        formComanda.comisio= 1;
    }
    formComanda.total =Number((formComanda.comisio+comanda.total).toFixed(2));
    formComanda.totalFinal= formComanda.total;
    formComanda.idDireccio="";
    formComanda.idTipusEnviament ="";
    formComanda.idComanda =comanda.idComanda;
    formComanda.isEnviament=false;
    showModalTramitacio.value = true;

}
const closeTramit =()=> {
    showModalTramitacio.value = false;
    showModalTramitacioConfirmacio.value = false;
}

const  updateTotal =()=> {
    let selectedOption = props.tipusEnviaments.find(option => option.idTipusEnviament === formComanda.idTipusEnviament);
    if (selectedOption) {
        formComanda.totalFinal = (Number(formComanda.total) + Number(selectedOption.preu)).toFixed(2);
    }
}
const pagarTransaccio =()=> {

    if(formComanda.isEnviament===true && (formComanda.idDireccio==="" || formComanda.idTipusEnviament==="")){
        closeTramit();
        abrirModalTramitacioIncorrecta();
        return;
    }

    if(formComanda.totalFinal > props.saldo.saldoComprador ){
        closeTramit();
        abrirModalInsuficientSaldo();
        return;
    }

    formComanda.post('confirmarPagament');
    confirmacioPagament();
}

const confirmacioPagament=()=>{
    closeTramit();
    showModalPagamentConfirmacio.value=true;
    setTimeout(() => {

        useForm.visit(window.location.pathname);
    }, 500);

}

const cerrarconfirmacioPagament = () =>{
    showModalPagamentConfirmacio.value =false;
}

const cerrarTramitacioIncorrecta = () =>{
    showModalTramitacioIncorrecta.value =false;
}

const abrirModalTramitacioIncorrecta = () => {
    showModalTramitacioIncorrecta.value =true;
}

const cerrarInsuficientSaldo = () =>{
    showModalInsuficientSaldo.value =false;
}

const abrirModalInsuficientSaldo = () => {
    showModalInsuficientSaldo.value =true;
}


//--------Eliminar productes de Wishlist-------//
const eliminarProductesWishlist = () => {
    formComanda.post('eliminarProductesWishlist');
    //  confirmacioPagament();
}



//realitzar tasques de canvi estat
const realitzarTasca = (comanda,estat) => {
    formComanda.idComanda =comanda.idComanda;
    formComanda.estat=estat;
    showModalTasca.value =true;
}

const tancarTasca = () =>{
    showModalTasca.value =false;
    showModalConfirmacioTasca.value =false;
}

const confirmarTasca =()=> {
    formComanda.post('confirmarNouEstat');
    confirmacioProcesTasca();
}

const confirmacioProcesTasca=()=>{
    tancarTasca();
    showModalConfirmacioTasca.value=true;
    setTimeout(() => {

        useForm.visit(window.location.pathname);
    }, 500);

}
//administracio
const closeAdministracio = () =>{
    showModalAdministracio.value =false;
}
const obrirAdministracio = (comanda) =>{
    formAdminComanda.estat="";
    formAdminComanda.idComanda=comanda.idComanda;
    showModalAdministracio.value =true;
}

const administrarComanda = () =>{
    if(formAdminComanda.estat===""){
        closeAdministracio();
        abrirModalAdministracioIncorrecta();
    }else{
        formAdminComanda.post('confirmarNouEstat');
        showModalAdministracio.value =false;
        confirmacioProcesTasca();
    }

}
const abrirModalAdministracioIncorrecta = () =>{
    showModalAdministracioIncorrecta.value=true;
}

const closeModalAdministracioIncorrecta = () =>{
    showModalAdministracioIncorrecta.value=false;
}
//Anular Comanda
const closeAnulacio = () =>{
    showModalAnulacio.value =false;
    showErrorAnulacio.value =false;
}

const obrirAnularComanda = (comanda) =>{
    if( comanda.estat==='Anulada'){
        showErrorAnulacio.value=true;
        return;
    }
    formAdminComanda.estat="";
    formAdminComanda.idComanda=comanda.idComanda;
    showModalAnulacio.value =true;
}
const anularComanada = () =>{
    formAdminComanda.post('anularComanda');
    showModalAnulacio.value =false;
    confirmacioProcesTasca();
}

</script>

<template>
    <AuthenticatedLayout>
        <div class="d-flex justify-content-center m-3 ">
            <h2>{{titol}}</h2>
        </div>
        <div class="d-flex justify-content-center m-3 ">
            <table class="table  table-striped  my-table w-50 ">
                <thead>
                <tr>
                    <th class="col-1">ID</th>
                    <th class="col-1">Venedor</th>
                    <th class="col-1">Comprador</th>
                    <th class="col-1">Total</th>
                    <th class="col-1">Estat</th>
                    <th class="col-1" ></th>
                    <th class="col-1"></th>
                    <th class="col-1" v-if="$page.props.auth.user.idRol==1||$page.props.auth.user.idRol==2"></th>
                    <th class="col-1" v-if="$page.props.auth.user.idRol==1||$page.props.auth.user.idRol==2"></th>

                </tr>
                </thead>
                <tbody>
                <tr v-for="comanda in comandes" :key="comanda.id">
                    <td>
                        <a :href="'/veureLinies/' + comanda.idComanda"> {{comanda.idComanda}}</a>
                    </td>
                    <td>{{comanda.nickVenedor}}</td>
                    <td>{{comanda.nickComprador}}</td>
                    <td>{{comanda.total}}</td>
                    <td>{{comanda.estat}}</td>
                    <td >
                        <button class="btn btn-success rounded-pill"
                                @click="realizarTramit(comanda)" v-if="$page.props.auth.user.idUsuari==comanda.idComprador && comanda.estat==='Pendent pagament'">PAGAR</button>
                        <button class="btn btn-success rounded-pill"
                                @click="realitzarTasca(comanda,'Enviada')" v-if="$page.props.auth.user.idUsuari==comanda.idVenedor && comanda.estat==='Pendent enviament'">ENVIAT</button>
                        <button class="btn btn-success rounded-pill"
                                @click="realitzarTasca(comanda,'Pendent recollida')" v-if="$page.props.auth.user.idUsuari==comanda.idVenedor && comanda.estat==='Pendent preparacio'">PREPARAT</button>
                        <button class="btn btn-success rounded-pill"
                                @click="realitzarTasca(comanda,'Complerta')"  v-if="$page.props.auth.user.idUsuari==comanda.idVenedor && comanda.estat==='Pendent recollida'">RECOLLIT</button>
                        <button class="btn btn-success rounded-pill" v-if="$page.props.auth.user.idUsuari==comanda.idComprador && comanda.estat==='Enviada'"
                                @click="realitzarTasca(comanda,'Complerta')">REBUT</button>
                    </td>
                    <td v-if="$page.props.auth.user.idRol==1||$page.props.auth.user.idRol==2">
                        <button class="btn btn-success rounded-pill"
                                @click="obrirAdministracio(comanda)">ADMINISTRAR</button>
                    </td>
                    <td v-if="$page.props.auth.user.idRol==1||$page.props.auth.user.idRol==2">
                        <button class="btn btn-danger rounded-pill"
                                @click="obrirAnularComanda(comanda)">ANULAR</button>
                    </td>
                    <td>
                        <button class="btn btn-danger rounded-pill"
                                @click=" ">INCIDENCIA</button>
                    </td>

                </tr>
                </tbody>
            </table>
            <Modal :show="showModalTramitacio" maxWidth="2xl" @close="closeTramit" >
                <div class="d-flex justify-content-center p-2">
                    <h5 class="modal-title" id="exampleModalLabel">Tipus de recollida y pagament de la comanda</h5>
                </div>
                <div class="modal-content w-100">
                    <div class="d-flex justify-content-center m-3">
                        <form class="w-100 rounded">
                            <div class="m-2 text-center font-weight-bold">
                                <div class="d-flex justify-content-center m-3 ">
                                    <InputLabel for="isEnviament" value="Vols enviar aquest producte?" class="m-2"  style="font-size: 16px;"/>
                                    <input
                                        id="isEnviament"
                                        type="checkbox"
                                        v-model="formComanda.isEnviament"
                                        style="color: black;">
                                </div>
                                <div v-if="formComanda.isEnviament" class="m-2 text-center font-weight-bold">
                                    <InputLabel for="idDireccio" value="Direccio Enviament: " class="m-2" style="font-size: 16px;" />
                                    <div class="d-flex justify-content-center">
                                        <select id="idDireccio" v-model="formComanda.idDireccio" style="color: black;">
                                            <option v-for="direccio in direccions" v-bind:key="direccio.idDireccio" v-bind:value="direccio.idDireccio">
                                                {{ direccio.direccio+ " "}} {{ direccio.codiPostal+" " }}{{ direccio.nomCiutat+" " }} {{ direccio.nomPais }}
                                            </option>
                                        </select>
                                    </div>
                                </div>
                                <div  v-if="formComanda.isEnviament" class="m-2 text-center font-weight-bold">
                                    <InputLabel for="idTipusEnviament" value="Tipus Enviament: " class="m-2" style="font-size: 16px;" />
                                    <div class="d-flex justify-content-center">
                                        <select id="idTipusEnviament" v-model="formComanda.idTipusEnviament"  @change="updateTotal"  style="color: black;">
                                            <option v-for="tipusEnviament in tipusEnviaments" v-bind:key="tipusEnviament.idTipusEnviament" v-bind:value="tipusEnviament.idTipusEnviament">
                                                {{ tipusEnviament.nom+ ": "}} {{ tipusEnviament.preu+"€" }}
                                            </option>
                                        </select>
                                    </div>
                                </div>
                                <div class="m-2 text-center font-weight-bold">
                                    El Total de la comanda será {{formComanda.totalFinal+"€"}}<br>
                                    El teu saldo actual es de {{$page.props.auth.user.saldo+"€"}}.
                                </div>
                            </div>
                        </form>
                    </div>
                </div>
                <div class="d-flex justify-content-center m-3 ">
                    <button class="btn btn-success col-2" @click="pagarTransaccio">Pagar</button>
                    <div class="col-1"></div>
                    <button class="btn btn-danger col-2 " @click="closeTramit">Cancelar</button>
                </div>
            </Modal>
            <Modal :show="showModalTramitacioIncorrecta" maxWidth="2xl" closeable @close="cerrarTramitacioIncorrecta" >
                <div class="modal-content w-100">
                    <div class="d-flex justify-content-between m-3 align-items-start">
                        <button @click="cerrarTramitacioIncorrecta" style="border: none; background: none;">
                            <img :src="/images/+'cierre.jpg'" alt="Cerrar" style="width: 10px; height: 10px;" />
                        </button>
                        <p>Dades de tramitació incorrectes!</p>
                        <div></div>
                    </div>
                </div>
            </Modal>
            <Modal :show="showModalInsuficientSaldo" maxWidth="2xl" closeable @close="cerrarInsuficientSaldo" >
                <div class="modal-content w-100">
                    <div class="d-flex justify-content-between m-3 align-items-start">
                        <button @click="cerrarInsuficientSaldo" style="border: none; background: none;">
                            <img :src="/images/+'cierre.jpg'" alt="Cerrar" style="width: 10px; height: 10px;" />
                        </button>
                        <p>Saldo insuficient!</p>
                        <div></div>
                    </div>
                </div>
            </Modal>
            <Modal :show="showModalPagamentConfirmacio" maxWidth="2xl" closeable @close="cerrarconfirmacioPagament" >
                <div class="modal-content w-100">
                    <div class="d-flex justify-content-between m-3 align-items-start">
                        <button @click="cerrarconfirmacioPagament" style="border: none; background: none;">
                            <img :src="/images/+'cierre.jpg'" alt="Cerrar" style="width: 10px; height: 10px;" />
                        </button>
                        <h2 class="text-center mr-14">Pagament realitzat correctament!</h2>
                    </div>
                    <div class="d-flex justify-content-center m-3 ">
                        <p>Vols eliminar els articles comprats de les teves Wishlist?<br>
                        Quines wishlists vols eleminar?</p>
                    </div>
                    <div class="d-flex flex-column align-items-center m-3 ">
                        <div v-for="wishlist in wishlists" :key="wishlist.idWishlist">
                            <input class="m-2" type="checkbox" :id="wishlist.idWishlist" :value="wishlist.idWishlist" v-model="formComanda.idWishlists">
                            <label :for="wishlist.idWishlist">{{ wishlist.nomWishlist }}</label>
                        </div>
                    </div>
                    <div class="d-flex justify-content-center m-3 ">
                        <button type="button" class="btn btn-success mr-5"
                                @click="eliminarProductesWishlist">Sí</button>
                        <button type="button" class="btn btn-danger ml-5" @click="cerrarconfirmacioPagament">No</button>
                    </div>
                </div>
            </Modal>
            <Modal :show="showModalTasca" maxWidth="2xl" closeable @close="tancarTasca" >
                <div class="modal-content w-100">
                    <div class="d-flex justify-content-center m-3 ">
                        <p>¿Confirmes que vols realitzar la tasca?</p>
                    </div>
                    <div class="d-flex justify-content-center m-3 ">
                        <button type="button" class="btn btn-success mr-5"
                                @click="confirmarTasca">Sí</button>
                        <button type="button" class="btn btn-danger ml-5" @click="tancarTasca">No</button>
                    </div>
                </div>
            </Modal>
            <Modal :show="showModalConfirmacioTasca" maxWidth="2xl" closeable @close="tancarTasca" >
                <div class="modal-content w-100">
                    <div class="d-flex justify-content-between m-3 align-items-start">
                        <button @click="tancarTasca" style="border: none; background: none;">
                            <img :src="/images/+'cierre.jpg'" alt="Cerrar" style="width: 10px; height: 10px;" />
                        </button>
                        <p>Tasca realitzada correctament!</p>
                        <div></div>
                    </div>
                </div>
            </Modal>
            <Modal :show="showModalAdministracio" maxWidth="2xl" @close="closeAdministracio" >
                <div class="modal-content w-100">
                    <div class="d-flex justify-content-center m-3">
                        <form class="w-100 rounded"  >
                            <div class="m-2 text-center font-weight-bold">
                                <InputLabel for="estat" value="Nou estat de la comanda: " class="m-2" style="font-size: 16px;" />
                                <div class="d-flex justify-content-center">
                                    <select id="estat" v-model="formAdminComanda.estat"  style="color: black;">
                                        <option v-for="option in options" v-bind:key="option.name" v-bind:value="option.value">
                                            {{ option.name }}
                                        </option>
                                    </select>
                                </div>
                            </div>
                        </form>
                    </div>
                </div>
                <div class="d-flex justify-content-center m-3 ">
                    <button class="btn btn-success col-2" @click="administrarComanda">Cambiar</button>
                    <div class="col-1"></div>
                    <button class="btn btn-danger col-2 " @click="closeAdministracio">Cancelar</button>
                </div>
            </Modal>
            <Modal :show="showModalAdministracioIncorrecta" maxWidth="2xl" closeable @close="closeModalAdministracioIncorrecta" >
                <div class="modal-content w-100">
                    <div class="d-flex justify-content-between m-3 align-items-start">
                        <button @click="closeModalAdministracioIncorrecta" style="border: none; background: none;">
                            <img :src="/images/+'cierre.jpg'" alt="Cerrar" style="width: 10px; height: 10px;" />
                        </button>
                        <p>Has de seleccionar un nou estat per a la comanda!</p>
                        <div></div>
                    </div>
                </div>
            </Modal>
            <Modal :show="showModalAnulacio" maxWidth="2xl" closeable @close="closeAnulacio" >
                <div class="modal-content w-100">
                    <div class="d-flex justify-content-center m-3 ">
                        <p>¿Estas segur de que vols anular aquesta comanda?</p>
                    </div>
                    <div class="d-flex justify-content-center m-3 ">
                        <button type="button" class="btn btn-success mr-5"
                                @click="anularComanada">Sí</button>
                        <button type="button" class="btn btn-danger ml-5" @click="closeAnulacio">No</button>
                    </div>
                </div>
            </Modal>
            <Modal :show="showErrorAnulacio" maxWidth="2xl" closeable @close="closeAnulacio" >
                <div class="modal-content w-100">
                    <div class="d-flex justify-content-between m-3 align-items-start">
                        <button @click="closeAnulacio" style="border: none; background: none;">
                            <img :src="/images/+'cierre.jpg'" alt="Cerrar" style="width: 10px; height: 10px;" />
                        </button>
                        <p>No pots anular una comanda ja anulada!</p>
                        <div></div>
                    </div>
                </div>
            </Modal>
        </div>
    </AuthenticatedLayout>
</template>

<style scoped>
.my-table td, .my-table th {
    background-color: rgba(0,214,153,0.5) !important;
    text-align: center;
    vertical-align: middle;
}

form {
    background-color:rgba(0,214,153,0.8) !important;
}
</style>
