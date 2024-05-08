<script setup>

import 'bootstrap/dist/css/bootstrap.css';
import AuthenticatedLayout from "@/Layouts/AuthenticatedLayout.vue";
import {ref} from "vue";
import Modal from "@/Components/Modal.vue";
import {useForm} from "@inertiajs/vue3";

defineProps({
    noticies: {
        type: Array(String),
    }
});

const form = useForm({
    idNoticia: null,

});

let showModal = ref(false);
let showModalEliminacio = ref(false);

const abrirModalConfirmacion = (id) => {
    showModal.value = true;
    form.idNoticia=id;
}

const eliminarNoticia =() => {
    form.get(route('deleteNoticia'));
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


//crearNoticia
const crearNoticia=()=> {
    form.get('/formCrearNoticia');
}

</script>

<template>
    <AuthenticatedLayout>
        <div class="d-flex justify-content-center m-3 ">
            <h2>Llistat de Noticies</h2>
        </div>
        <div class="d-flex justify-content-center m-3 ">
            <table class="table table-striped my-table w-50 ">
                <thead>
                <tr>
                    <th>Titol</th>
                    <th>Creador</th>
                    <th>Data</th>
                    <th v-if="$page.props.auth.user.idRol==1||$page.props.auth.user.idRol==2"></th>
                </tr>
                </thead>
                <tbody>
                <tr v-for="noticia in noticies" :key="noticia.id">
                    <td>
                        <a :href="'/veureNoticia/' + noticia.idNoticia"> {{noticia.titol}}</a>
                    </td>
                    <td>{{noticia.nick}}</td>
                    <td>{{noticia.created}}</td>
                    <td v-if="$page.props.auth.user.idRol==1||$page.props.auth.user.idRol==2">
                        <button  class="btn btn-danger rounded-pill" v-if="$page.props.auth.user.idRol==1 ||$page.props.auth.user.idRol==2 "
                                 @click="abrirModalConfirmacion(noticia.idNoticia)">Eliminar</button>
                    </td>
                </tr>
                </tbody>
            </table>


            <Modal :show="showModal" maxWidth="2xl" closeable @close="cerrarModal" >
                <div class="modal-content w-100">
                    <div class="d-flex justify-content-center m-3 ">
                        <p>¿Estas segur de que vols eliminar aquesta Noticia?</p>
                    </div>
                    <div class="d-flex justify-content-center m-3 ">
                        <button type="button" class="btn btn-success mr-5"
                                @click="eliminarNoticia">Sí</button>
                        <button type="button" class="btn btn-danger ml-5" @click="cerrarModal">No</button>

                    </div>
                </div>
            </Modal>
            <Modal :show="showModalEliminacio" maxWidth="2xl" closeable @close="cerrarModal" >
                <div class="modal-content w-100">
                    <div class="d-flex justify-content-center m-3 ">
                        <p>Noticia Eliminada</p>
                    </div>
                </div>
            </Modal>
        </div>
        <div class="d-flex justify-content-center m-3 " v-if="$page.props.auth.user.idRol==1 ||$page.props.auth.user.idRol==2 ">
            <b-button class="btn btn-success rounded-pill" style="width: 200px;" @click="crearNoticia">Crear Noticia</b-button>
        </div>
    </AuthenticatedLayout>
</template>

<style>

.my-table td, .my-table th {
    background-color: rgba(0,214,153,0.7) !important;
    text-align: center;
    vertical-align: middle;
}
</style>
