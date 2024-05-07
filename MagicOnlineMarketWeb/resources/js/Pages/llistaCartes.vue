<script setup>
import {ref} from "vue";
import 'bootstrap/dist/css/bootstrap.css';
import AuthenticatedLayout from "@/Layouts/AuthenticatedLayout.vue";
import Modal from '@/Components/Modal.vue';
import axios from 'axios';
import {useForm} from "@inertiajs/vue3";


defineProps({
    cartes: {
        type: Array(String),
    },

    idRolUser:{
        type:String
    }
});
let showModal = ref(false);
let showModalElim = ref(false);
let cartaId =ref(null);

const abrirModalConfirmacion = (id) => {
    showModal.value = true;
    cartaId.value = id;
}


const cerrarModal = () => {
    showModal.value = false;
    showModalElim.value=false;
    showModalImage.value =false;
}

const eliminarCarta = async () => {
    try {
        const response = await axios.delete(`/deleteCarta/${cartaId.value}`);
        console.log(response.data);
        cerrarModal();
        showModalElim.value = true;
        setTimeout(() => {
            showModalElim.value = false;
        }, 2000);
        location.reload();

    } catch (error) {
        console.error(error);
    }
}

const form = useForm({
    idCartaModificada: null,

});

const abrirFormularioEdicion=(id)=>{
    form.idCartaModificada=id;
    form.get(route('FormEditCarta'));

}



let selectedImage = ref(null);
let showModalImage = ref(false);

const openImageModal = (image) => {
    selectedImage.value = image;
    showModalImage.value = true;
}

const closeImageModal = () => {
    selectedImage.value = null;
    showModalImage.value = false;
}
</script>

<template>
    <AuthenticatedLayout>
        <div class="d-flex justify-content-center m-3 " >
            <table class="table table-striped my-table w-50" >
                <thead>
                <tr>
                    <th class="col-1"></th>
                    <th class="col-1">Nom Carta</th>
                    <th class="col-3">Descripcio Carta</th>
                    <th class="col-1">Raresa Carta</th>
                    <th class="col-1"></th>
                    <th class="col-1"></th>
                </tr>
                </thead>
                <tbody>
                <tr v-for="carta in cartes" :key="carta.id">
                    <td>
                        <div class="d-flex justify-content-center m-3 ">
                            <img :src="/images/+'camara.png'" alt="Imagen Foto" width="25" height="25" style="filter: brightness(0) invert(1);" @click="openImageModal(carta.imatge)">
                        </div>
                    </td>
                    <td>{{carta.nom}}</td>
                    <td>{{carta.descripcio}}</td>
                    <td>{{carta.raresa}}</td>
                    <td>
                        <button v-if="idRolUser == '2'||idRolUser == '1'" class="btn btn-success rounded-pill"
                                @click="abrirFormularioEdicion(carta.idCarta)">Modificar</button>
                    </td>
                    <td>
                        <button v-if="idRolUser == '2'||idRolUser == '1'"  class="btn btn-danger rounded-pill"
                                @click="abrirModalConfirmacion(carta.idCarta)">Eliminar</button>
                    </td>
                </tr>
                </tbody>
            </table>
            <Modal :show="showModal" maxWidth="2xl" closeable @close="cerrarModal" >
                <div class="modal-content w-100">
                    <div class="d-flex justify-content-center m-3 ">
                        <p>¿Estas segur de que vols eliminar aquesta carta?</p>
                    </div>
                    <div class="d-flex justify-content-center m-3 ">
                        <button type="button" class="btn btn-success mr-5"
                            @click="eliminarCarta">Sí</button>
                        <button type="button" class="btn btn-danger ml-5" @click="cerrarModal">No</button>
                    </div>
                </div>
            </Modal>
            <Modal :show="showModalElim" maxWidth="2xl" closeable @close="cerrarModal" >
                <div class="modal-content w-100">
                    <div class="d-flex justify-content-center m-3 ">
                        <p>Carta Eliminada!</p>
                    </div>
                </div>
            </Modal>
            <Modal :show="showModalImage" maxWidth="2xl" closeable @close="closeImageModal" >
                    <div class="d-flex justify-content-center  p-5">
                        <img :src="'/images/' + selectedImage" width="500" height="600">
                    </div>
            </Modal>
            </div>

    </AuthenticatedLayout>
</template>

<style>

.my-table td, .my-table th {
    background-color: rgba(0,214,153,0.5) !important;
    text-align: center;
    vertical-align: middle;
}
</style>
