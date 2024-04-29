<script setup>
import {ref} from "vue";
import 'bootstrap/dist/css/bootstrap.css';
import AuthenticatedLayout from "@/Layouts/AuthenticatedLayout.vue";
import Modal from '@/Components/Modal.vue';
import axios from 'axios';
import {useForm} from "@inertiajs/vue3";


defineProps({
    usuaris: {
        type: Array(String),
    }
});

let showModal = ref(false);
let showModalElim = ref(false);
let userId =ref(null);

const abrirModalConfirmacion = (id) => {
    showModal.value = true;
    userId.value=id;
}


const cerrarModal = () => {
    showModal.value = false;
    showModalElim.value=false;
}

const eliminarUsuari = async () => {
    try {
        const response = await axios.delete(`/deleteUser/${userId.value}`);
        console.log(response.data);
        cerrarModal();
        location.reload();
        showModalElim.value = true;
    } catch (error) {
        console.error(error);
    }
}

const form = useForm({
    idCartaModificada: null,

});

</script>

<template>
    <AuthenticatedLayout>
        <div class="d-flex justify-content-center m-3 ">
            <table class="table table-striped table-dark w-50 ">
                <thead>
                <tr>
                    <th>Nick</th>
                    <th>Nom</th>
                    <th>Cognom</th>
                    <th>Email</th>
                    <th>Rol</th>
                    <th></th>
                </tr>
                </thead>
                <tbody>
                <tr v-for="usuari in usuaris" :key="usuari.id">
                    <td>{{usuari.nick}}</td>
                    <td>{{usuari.name}}</td>
                    <td>{{usuari.cognom}}</td>
                    <td>{{usuari.email}}</td>
                    <td>{{usuari.nomRol}}</td>
                    <td>
                        <button  class="btn btn-primary rounded-circle"
                                 @click="abrirModalConfirmacion(usuari.idUsuari)">Elim</button>
                    </td>
                </tr>
                </tbody>
            </table>
            <Modal :show="showModal" maxWidth="2xl" closeable @close="cerrarModal" >
                <div class="modal-content w-100">
                    <span class="close" @click="cerrarModal">×</span>
                    <div class="d-flex justify-content-center m-3 ">
                        <p>¿Estas segur de que vols eliminar aquest usuari/a?</p>
                    </div>
                    <div class="d-flex justify-content-center m-3 ">
                        <button type="button" class="btn btn-danger mr-5" @click="cerrarModal">No</button>
                        <button type="button" class="btn btn-primary ml-5"
                                @click="eliminarUsuari">Sí</button>
                    </div>
                </div>
            </Modal>
            <Modal :show="showModalElim" maxWidth="2xl" closeable @close="cerrarModal" >
                <div class="modal-content w-100">
                    <span class="close" @click="cerrarModal">×</span>
                    <div class="d-flex justify-content-center m-3 ">
                        <p>Usuari/a Eliminat/da</p>
                    </div>
                </div>
            </Modal>
        </div>

    </AuthenticatedLayout>
</template>

<style scoped>


</style>
