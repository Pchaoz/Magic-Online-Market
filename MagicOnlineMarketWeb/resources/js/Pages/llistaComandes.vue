<script setup>

import 'bootstrap/dist/css/bootstrap.css'
import AuthenticatedLayout from "@/Layouts/AuthenticatedLayout.vue";
import {ref} from "vue";
import {useForm} from "@inertiajs/vue3";
import Modal from "@/Components/Modal.vue";

defineProps({
    comandes:{
        type: Array(String),
    },
});

let showModalEliminacio = ref(false);
let showModalEliminacioConfirmacio = ref(false);
const formComanda= useForm({
    idComanda:null,

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


</script>

<template>
    <AuthenticatedLayout>
        <div class="d-flex justify-content-center m-3 ">
            <h2>Llistat de Comandes</h2>
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
                    <td v-if="$page.props.auth.user.idRol==1||$page.props.auth.user.idRol==2">
                        <button class="btn btn-success rounded-pill"
                                @click=" ">Administrar</button>
                    </td>
                    <td v-if="$page.props.auth.user.idRol==1||$page.props.auth.user.idRol==2">
                        <button class="btn btn-danger rounded-pill"
                                @click="abrirModalEliminacio(comanda.idComanda)">Eliminar</button>
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
