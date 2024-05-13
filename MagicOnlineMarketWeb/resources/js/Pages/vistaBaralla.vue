<script setup>

import AuthenticatedLayout from "@/Layouts/AuthenticatedLayout.vue";
import 'bootstrap/dist/css/bootstrap.css';
import Modal from "@/Components/Modal.vue";
import {useForm} from "@inertiajs/vue3";
import {ref} from "vue";
import { reactive } from 'vue';
import InputLabel from "@/Components/InputLabel.vue";

let props = defineProps({
    cartesBaralla: {
        type: Array(String),
    },
    baralla:Object,
    cartes:{
        type: Array(String),
    }
});

const formCartaInsert= useForm({
    idCarta:"",
    quantitat:0,
    idBaralla:props.baralla.idBaralla,
})

const formCartaMod= useForm({
    idCarta:"",
    quantitat:0,
    idBaralla:props.baralla.idBaralla,
})


let imatgeMiniaturaMod=reactive(null);
let imatgeMiniatura=reactive(null);
let showModalAfegirCarta = ref(false);
let showModalModificar = ref(false);

const AfegirCarta =()=>{
    formCartaInsert.idProducte="";
    formCartaInsert.quantitat=0;
    imatgeMiniatura="";
    showModalAfegirCarta.value=true;
}

const cerrarModalAfegirCarta =()=>{
    showModalAfegirCarta.value=false;

}
const cerrarModalModCarta =()=>{
    showModalModificar.value=false;

}


let state = reactive({
    cartes: props.cartes,
});
const actualizarImagen = (event) => {
    let idCarta = event.target.value
    const cartaSeleccionada = state.cartes.find(carta => carta.idCarta == idCarta);
    if (cartaSeleccionada) {
        imatgeMiniatura = '/images/'+cartaSeleccionada.imatge;
        formCartaInsert.quantitat=0;
    }
    formCartaInsert.quantitat=1;

};

const afegirCartaBaralla =()=>{
    formCartaInsert.post('/agregarCartaBaralla');
    setTimeout(() => {
        cerrarModalAfegirCarta();
        useForm.visit(window.location.pathname);
    }, 500);
}
//modificar o eliminar carta
const ModificarCarta =(carta)=>{
    formCartaMod.idCarta=carta.idCarta;
    formCartaMod.quantitat=carta.quantitat;
    imatgeMiniaturaMod= '/images/'+carta.imatgeCarta;
    showModalModificar.value=true;
}
const eliminarCartaBaralla =()=>{
    formCartaMod.delete('/deleteCartaBaralla');
    setTimeout(() => {
        cerrarModalModCarta();
        useForm.visit(window.location.pathname);
    }, 500);
}

const modCarta =()=>{
    formCartaMod.post('/modCartaBaralla');
    setTimeout(() => {
        cerrarModalModCarta();
        useForm.visit(window.location.pathname);
    }, 500);
}


</script>

<template>
    <AuthenticatedLayout>
        <div class="d-flex justify-content-center m-3 ">
            <h2>Baralla {{baralla.nomBaralla}}</h2>
        </div>
        <div class="d-flex justify-content-center m-3 ">
            <b-button class="btn btn-success rounded-pill"  style="width: 200px;"  v-if= "$page.props.auth.user.idRol==1 ||$page.props.auth.user.idUsuari===baralla.idCreador" @click="AfegirCarta">Afegir Carta</b-button>
        </div>
        <div class="d-flex justify-content-center m-3 ">

            <div class="row hidden">
                <div class="carta-container" v-for="cartaBaralla in cartesBaralla" :key="cartaBaralla.idCarta" :class="{ 'clase-especial': cartesBaralla.length < 5 }">
                    <div class="card bg-transparent">
                        <div class="card-header text-right">
                            <small class="text-muted" style="font-size: 2em;">X{{cartaBaralla.quantitat}}</small>
                        </div>
                        <img :src="'/images/' + cartaBaralla.imatgeCarta" class="card-img-top" alt="..."
                             @click="($page.props.auth.user.idRol==1 || $page.props.auth.user.idUsuari===baralla.idCreador) ? ModificarCarta(cartaBaralla) : null">
                        <div class="card-body">
                            <h5 class="card-title text-center">{{cartaBaralla.nomCarta}}</h5>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <Modal :show="showModalAfegirCarta" maxWidth="2xl" closeable @close="cerrarModalAfegirCarta" >
            <div class="modal-content w-100">
                <div class="d-flex justify-content-center m-3">
                    <form class="w-100 rounded">
                        <div class="m-2 text-center font-weight-bold">
                            <div class="m-2 text-center font-weight-bold">
                                <InputLabel for="quantitat" value="Carta:" class="m-2" style="font-size: 16px;" />
                                <div class="d-flex justify-content-center">
                    <select id="idCarta" v-model="formCartaInsert.idCarta" @change="actualizarImagen"   style="color: black;">
                        <option >
                            {{ }}
                        </option>
                        <option v-for="carta in cartes" v-bind:key="carta.idCarta" v-bind:value="carta.idCarta">
                            {{ carta.nom }}
                        </option>
                    </select>
                                </div>
                            </div>
                            <div class="m-2 text-center font-weight-bold">
                                <InputLabel for="quantitat" value="Quantitat: " />
                    <div class="d-flex justify-content-center">
                        <input
                            id="quantitat"
                            type="number"
                            class="mt-1 block w-full"
                            v-model="formCartaInsert.quantitat"
                            min="1"
                            step="1"
                            required
                            style="color: black; width: 100px;"
                        />
                    </div  >
                            </div>
                            <div class="d-flex justify-content-center m-3 p-3">
                    <figure>
                        <img width="200" height="200" :src="imatgeMiniatura">
                    </figure>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
            <div class="d-flex justify-content-center m-3 ">
                <button class="btn btn-success col-2" @click="afegirCartaBaralla">Guardar</button>
                <div class="col-1"></div>
                <button class="btn btn-danger col-2 " @click="cerrarModalAfegirCarta">Cancelar</button>
            </div>
        </Modal>
        <Modal :show="showModalModificar" maxWidth="2xl" closeable @close="cerrarModalModCarta" >
            <div class="modal-content w-100">
                <div class="d-flex justify-content-center m-3">
                    <form class="w-100 rounded">
                        <div class="m-2 text-center font-weight-bold">
                            <div class="m-2 text-center font-weight-bold">
                                <InputLabel for="quantitat" value="Quantitat: " />
                                <div class="d-flex justify-content-center">
                                    <input
                                        id="quantitat"
                                        type="number"
                                        class="mt-1 block w-full"
                                        v-model="formCartaMod.quantitat"
                                        min="1"
                                        step="1"
                                        required
                                        style="color: black; width: 100px;"
                                    />
                                </div  >
                            </div>
                            <div class="d-flex justify-content-center m-3 p-3">
                                <figure>
                                    <img width="200" height="200" :src="imatgeMiniaturaMod">
                                </figure>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
            <div class="d-flex justify-content-center m-3 ">
                <button class="btn btn-success col-2" @click="modCarta">Modificar</button>
                <div class="col-1"></div>
                <button class="btn btn-danger col-2 " @click="cerrarModalModCarta">Cancelar</button>
            </div>
            <div class="d-flex justify-content-center m-3 ">
                <button class="btn btn-danger col-2 " @click="eliminarCartaBaralla">Eliminar Carta</button>
            </div>

        </Modal>

    </AuthenticatedLayout>
</template>

<style scoped>
* {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
}

.carta-container {
    width: 20%;
    float: left;
}

.card {
    width: 300px;
    height: 400px;
    border: none !important;
    margin-left: 10px;
    margin-bottom: 130px !important;
}

.clase-especial {
    margin-left: 100px;
}

form {
    background-color:rgba(0,214,153,0.8) !important;

}



</style>
