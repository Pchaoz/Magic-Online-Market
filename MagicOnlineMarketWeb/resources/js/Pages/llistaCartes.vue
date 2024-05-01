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
}

const eliminarCarta = async () => {
    try {
        const response = await axios.delete(`/deleteCarta/${cartaId.value}`);
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

const abrirFormularioEdicion=(id)=>{
    form.idCartaModificada=id;
    form.get(route('FormEditCarta'));

}




</script>

<template>
    <AuthenticatedLayout>
        <div class="d-flex justify-content-center m-3 ">
            <table class="table table-striped table-dark w-50 ">
                <thead>
                <tr>
                    <th class="col-1">Nom Carta</th>
                    <th class="col-3">Descripcio Carta</th>
                    <th class="col-1">Imatge Carta</th>
                    <th class="col-1">Raresa Carta</th>
                    <th class="col-1"></th>
                    <th class="col-1"></th>
                </tr>
                </thead>
                <tbody>
                <tr v-for="carta in cartes" :key="carta.id">
                    <td>{{carta.nom}}</td>
                    <td>{{carta.descripcio}}</td>
                    <td>
                        <img :src="'/images/' + carta.imatge"  width="300" height="350" >
                    </td>
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
            </div>

    </AuthenticatedLayout>
</template>

<style scoped>
.zoomable-image {
    transition: transform 0.3s ease;
}

.zoomable-image:hover {
    transform: scale(4);
}


</style>
