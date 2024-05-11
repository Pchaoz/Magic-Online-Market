<script setup>

import 'bootstrap/dist/css/bootstrap.css'
import AuthenticatedLayout from "@/Layouts/AuthenticatedLayout.vue";
import {ref} from "vue";
import {useForm} from "@inertiajs/vue3";
import Modal from "@/Components/Modal.vue";

defineProps({
    comanda:{
        type: Object,
    },
    linies:{
        type: Array(String),
    }
});


let showModalEliminacio = ref(false);
let showModalEliminacioConfirmacio = ref(false);
const formLinia= useForm({
    idLinia:null,
    idComanda:null,
    quantitatLinia:0,
    preuLinia:0,
})


const abrirModalEliminacio = (linia) =>{
    showModalEliminacio.value=true;
    formLinia.idLinia=linia.idLinia;
    formLinia.quantitatLinia=linia.quantitat;
    formLinia.preuLinia=linia.preuUnitari;
    formLinia.idComanda=linia.idComanda;

}
const cerrarModalEliminacio = () => {
    showModalEliminacio.value=false;
    showModalEliminacioConfirmacio.value=false;
}

const eliminarLinia =()=> {
    formLinia.delete('/eliminarLinia');
    recargaPaginaElim();
}

const recargaPaginaElim = () => {
    showModalEliminacio.value=false;
    showModalEliminacioConfirmacio=true;
    setTimeout(() => {
        useForm.visit(window.location.pathname);
    }, 500);
}

</script>

<template>
    <AuthenticatedLayout>
        <div class="d-flex justify-content-center m-3 ">
         <h2>Comanda</h2>
        </div>
        <div class="d-flex justify-content-center m-3 ">

            <table class="table  table-striped  my-table w-50 ">
                <thead>
                <tr>
                    <th class="col-1">Venedor</th>
                    <th class="col-1">Comprador</th>
                    <th class="col-1">Total</th>
                    <th class="col-1">Estat</th>
                </tr>
                </thead>
                <tbody>
                <tr>
                    <td>{{comanda.nickVenedor}}</td>
                    <td>{{comanda.nickComprador}}</td>
                    <td>{{comanda.total}}</td>
                    <td>{{comanda.estat}}</td>
                </tr>
                </tbody>
            </table>

        </div>

        <div class="d-flex justify-content-center m-3 ">
            <h2>Linies Comanda</h2>
        </div>


        <div class="d-flex justify-content-center m-3 ">
            <table class="table  table-striped  my-table w-50 ">
                <thead>
                <tr>
                    <th class="col-1">Nom Producte</th>
                    <th class="col-1">Quantitat Comprada</th>
                    <th class="col-1">Preu Unitari</th>
                    <th class="col-1">Subtotal</th>
                    <th class="col-1"></th>
                </tr>
                </thead>
                <tbody>
                <tr v-for="linia in linies" :key="linia.id">
                    <td>{{linia.nomProducte}}</td>
                    <td>{{linia.quantitat}}</td>
                    <td>{{linia.preuUnitari}}</td>
                    <td>{{(linia.preuUnitari*linia.quantitat).toFixed(2)}}</td>
                    <td>
                        <button class="btn btn-danger rounded-pill"
                                @click="abrirModalEliminacio(linia)">Eliminar</button>
                    </td>


                </tr>
                </tbody>
            </table>

            <Modal :show="showModalEliminacio" maxWidth="2xl" closeable @close="cerrarModalEliminacio" >
                <div class="modal-content w-100">

                    <div class="d-flex justify-content-center m-3 ">
                        <p>¿Estas segur de que vols eliminar aquesta linia?</p>
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
                        <p>Linia Eliminada</p>
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
</style>
