<script setup>


import AuthenticatedLayout from "@/Layouts/AuthenticatedLayout.vue";
import 'bootstrap/dist/css/bootstrap.css';
import {useForm} from "@inertiajs/vue3";
import {ref} from "vue";
import Modal from "@/Components/Modal.vue";

defineProps({
    baralles: {
        type: Array(String),
    }
});
let showModal = ref(false);
let showModalEliminacio = ref(false);

const form = useForm({
    idBaralla: null,

});

const abrirModalConfirmacionEliminacio = (id) => {
    showModal.value = true;
    form.idBaralla=id;
}

const cerrarModalCancelar = () =>{
    showModal.value = false;
}
const cerrarModalConfirmacionElimincion = () =>{
    showModalEliminacio.value = false;
}

const eliminarBaralla =() => {
    form.delete('/deleteBaralla');
    cerrarModal();
}

const cerrarModal = () => {
    showModal.value = false;
    showModalEliminacio.value = true;

    setTimeout(() => {
        showModalEliminacio.value = false;
        useForm.visit(window.location.pathname);
    }, 500);
}

</script>

<template>

    <AuthenticatedLayout>
        <div class="d-flex justify-content-center m-3 ">
            <h2>Llistat de Baralles</h2>
        </div>
        <div class="d-flex justify-content-center m-3 ">
            <table class="table table-striped my-table w-50 ">
                <thead>
                <tr>
                    <th>Nom Baralla</th>
                    <th>Creador Baralla</th>
                    <th></th>
                    <th></th>
                </tr>
                </thead>
                <tbody>
                <tr v-for="baralla in baralles" :key="baralla.id"  >
                    <td v-if=" $page.props.auth.user.idRol==1 ||$page.props.auth.user.idUsuari===baralla.idUsuari || baralla.isPublic===1">
                        <a :href="'/veureBaralla/' + baralla.idBaralla"> {{baralla.nomBaralla}}</a>
                    </td>
                    <td v-if=" $page.props.auth.user.idRol==1 ||$page.props.auth.user.idUsuari===baralla.idUsuari || baralla.isPublic===1">{{baralla.nickCreador}}</td>
                    <td v-if="$page.props.auth.user.idRol==1||$page.props.auth.user.idUsuari===baralla.idUsuari">
                        <button  class="btn btn-success rounded-pill" v-if="$page.props.auth.user.idRol==1 ||$page.props.auth.user.idRol==2 "
                                 @click="abrirModalConfirmacionModificacio(baralla)">Modificar</button>
                    </td>
                    <td v-if="$page.props.auth.user.idRol==1||$page.props.auth.user.idUsuari===baralla.idUsuari">
                    <button  class="btn btn-danger rounded-pill" v-if="$page.props.auth.user.idRol==1 ||$page.props.auth.user.idRol==2 "
                             @click="abrirModalConfirmacionEliminacio(baralla.idBaralla)">Eliminar</button>
                </td>
                </tr>
                </tbody>
            </table>
        </div>

        <Modal :show="showModal" maxWidth="2xl" closeable @close="cerrarModalCancelar" >
            <div class="modal-content w-100">
                <div class="d-flex justify-content-center m-3 ">
                    <p>¿Estas segur de que vols eliminar aquesta Baralla?</p>
                </div>
                <div class="d-flex justify-content-center m-3 ">
                    <button type="button" class="btn btn-success mr-5"
                            @click="eliminarBaralla">Sí</button>
                    <button type="button" class="btn btn-danger ml-5" @click="cerrarModalCancelar">No</button>

                </div>
            </div>
        </Modal>
        <Modal :show="showModalEliminacio" maxWidth="2xl" closeable @close="cerrarModalConfirmacionElimincion" >
            <div class="modal-content w-100">
                <div class="d-flex justify-content-center m-3 ">
                    <p>Baralla Eliminada</p>
                </div>
            </div>
        </Modal>

        <div class="d-flex justify-content-center m-3 ">
            <b-button class="btn btn-success rounded-pill" style="width: 200px;" @click="crearBaralla">Crear Baralla</b-button>
        </div>
    </AuthenticatedLayout>
</template>

<style scoped>
.my-table td, .my-table th {
    background-color: rgba(0,214,153,0.7) !important;
    text-align: center;
    vertical-align: middle;
}

</style>
