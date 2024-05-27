<script setup>

import 'bootstrap/dist/css/bootstrap.css'
import AuthenticatedLayout from "@/Layouts/AuthenticatedLayout.vue";
import {ref} from "vue";
import {useForm} from "@inertiajs/vue3";
import Modal from "@/Components/Modal.vue";
import InputLabel from "@/Components/InputLabel.vue";


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
});

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



const formComanda= useForm({
    idComanda:null,
    idDireccio:"",
    isEnviament:null,
    idTipusEnviament:null,
    totalSenseEnvaiment:0,
    totalFinal:0,
    comisio:0,
    estat:null,
})



const abrirModalEliminacio = (id) =>{
    showModalEliminacio.value=true;
    formComanda.idComanda=id;


}

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
    if(1>formComanda.comisio){
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

    if(formComanda.isEnviament===true && formComanda.idDireccio==="" && formComanda.idTipusEnviament===""){
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
                                @click="realitzarTasca(comanda,'Complerta')"  v-if="$page.props.auth.user.idUsuari==comanda.idComprador && comanda.estat==='Pendent recollida'">RECOLLIT</button>
                        <button class="btn btn-success rounded-pill" v-if="$page.props.auth.user.idUsuari==comanda.idComprador && comanda.estat==='Enviada'"
                                @click="realitzarTasca(comanda,'Complerta')">REBUT</button>
                    </td>
                    <td v-if="$page.props.auth.user.idRol==1||$page.props.auth.user.idRol==2">
                        <button class="btn btn-success rounded-pill"
                                @click=" ">ADMINISTRAR</button>
                    </td>
                    <td v-if="$page.props.auth.user.idRol==1||$page.props.auth.user.idRol==2">
                        <button class="btn btn-danger rounded-pill"
                                @click=" ">ANULAR</button>
                    </td>
                    <td>
                        <button class="btn btn-danger rounded-pill"
                                @click=" ">INCIDENCIA</button>
                    </td>

                </tr>
                </tbody>
            </table>
            <Modal :show="showModalEliminacio" maxWidth="2xl" closeable @close="cerrarModalEliminacio" >
                <div class="modal-content w-100">

                    <div class="d-flex justify-content-center m-3 ">
                        <p>¿Estas segur de que vols eliminar aquesta comanda?</p>
                    </div>
                    <div class="d-flex justify-content-center m-3 ">
                        <button type="button" class="btn btn-success mr-5"
                                @click="eliminarLinia">Sí</button>
                        <button type="button" class="btn btn-danger ml-5" @click="cerrarModalEliminacio">No</button>

                    </div>
                </div>
            </Modal>
            <Modal :show="showModalEliminacioConfirmacio" maxWidth="2xl" closeable @close="cerrarModalEliminacio" >
                <div class="modal-content w-100">

                    <div class="d-flex justify-content-center m-3 ">
                        <p>Comanda Eliminada</p>
                    </div>
                </div>
            </Modal>
            <Modal :show="showModalTramitacio" maxWidth="2xl" @close="closeTramit" >
                <div class="modal-content w-100">
                    <div class="d-flex justify-content-center m-3">
                        <form class="w-100 rounded">
                            <div class="m-2 text-center font-weight-bold">
                                <div class="d-flex justify-content-center m-3 ">
                                    <InputLabel for="isEnviament" value="Enviament?" class="m-2"  style="font-size: 16px;"/>
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
                        <p>Transacció de Pagament realitzada!</p>
                        <div></div>
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
