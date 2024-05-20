<script setup>

import AuthenticatedLayout from "@/Layouts/AuthenticatedLayout.vue";
import Modal from "@/Components/Modal.vue";
import {ref} from "vue";
import 'bootstrap/dist/css/bootstrap.css';
import {useForm} from "@inertiajs/vue3";


defineProps({
    whishlistProductes:{
        type: Array(String),
    },
});

let showModalEliminacio = ref(false);
let showModalEliminacioConfirmacio = ref(false);
let selectedImage = ref(null);
let showModalImage = ref(false)

const form= useForm({
    idWishlistProducte:null,
})
const openImageModal = (image) => {
    selectedImage.value = image;
    showModalImage.value = true;
}

const closeImageModal = () => {
    selectedImage.value = null;
    showModalImage.value = false;
}

//eliminar producte wishlist
const cerrarModalEliminacio = () => {
    showModalEliminacio.value=false;
    showModalEliminacioConfirmacio.value=false;
}

const abrirModalEliminacio = (wp) => {
    showModalEliminacio.value=true;
    form.idWishlistProducte=wp.idwp;
}


const eliminarProducteWishlist =()=> {
    form.delete('/eliminarProducteWishlist');
    recargaPaginaElim();
}

const recargaPaginaElim = () => {
    showModalEliminacio.value=false;
    showModalEliminacioConfirmacio.value=true;
    setTimeout(() => {
        useForm.visit(window.location.pathname);
    }, 500);

}


</script>

<template>
    <AuthenticatedLayout>
        <div class="d-flex justify-content-center m-3 ">
            <h2>Llista de articles</h2>
        </div>
        <div class="d-flex justify-content-center m-3 ">
            <table class="table  table-striped  my-table w-50 ">
                <thead>
                <tr>
                    <th>Imatge</th>
                    <th>Nom Producte</th>
                    <th></th>

                </tr>
                </thead>
                <tbody>
                <tr v-for="whishlistProducte in whishlistProductes" :key="whishlistProducte.id">
                    <td>
                        <div class="d-flex justify-content-center m-3 ">
                            <img :src="/images/+'camara.png'" alt="Imagen Foto" width="25" height="25" style="filter: brightness(0) invert(1);" @click="openImageModal(whishlistProducte.imatgeProducte)">
                        </div>
                    </td>
                    <td>
                        <a :href="'/veureArticlesProducte/' + whishlistProducte.idProducte">{{ whishlistProducte.nomProducte }}</a>
                    </td>
                    <td>
                        <button class="btn btn-danger rounded-pill" @click="abrirModalEliminacio(whishlistProducte)">Eliminar</button>
                    </td>

                </tr>
                </tbody>
            </table>

        </div>

        <Modal :show="showModalImage" maxWidth="2xl" closeable @close="closeImageModal" >
            <button class="p-2" @click="closeImageModal" style="border: none; background: none;">
                <img :src="/images/+'cierre.jpg'" alt="Cerrar" style="width: 15px; height: 15px;" />
            </button>
            <div class="d-flex justify-content-center p-5">
                <img :src="'/images/' + selectedImage" width="500" height="600">
            </div>
        </Modal>

        <Modal :show="showModalEliminacio" maxWidth="2xl" closeable @close="cerrarModalEliminacio" >
            <div class="modal-content w-100">
                <div class="d-flex justify-content-center m-3 ">
                    <p>¿Estas segur de que vols eliminar aquest producte de la teva Wishlist?</p>
                </div>
                <div class="d-flex justify-content-center m-3 ">
                    <button type="button" class="btn btn-success mr-5"
                            @click="eliminarProducteWishlist">Sí</button>
                    <button type="button" class="btn btn-danger ml-5" @click="cerrarModalEliminacio">No</button>

                </div>
            </div>
        </Modal>
        <Modal :show="showModalEliminacioConfirmacio" maxWidth="2xl" closeable @close="cerrarModalEliminacio" >
            <div class="modal-content w-100">
                <button class="p-2" @click="cerrarModalEliminacio" style="border: none; background: none;">
                    <img :src="/images/+'cierre.jpg'" alt="Cerrar" style="width: 10px; height: 10px;" />
                </button>
                <div class="d-flex justify-content-center m-3 ">
                    <p>Producte de la Wishlist Eliminat!</p>
                </div>
            </div>
        </Modal>

    </AuthenticatedLayout>
</template>

<style scoped>

.my-table td, .my-table th {
    background-color: rgba(0,214,153,0.5) !important;
    text-align: center;
    vertical-align: middle;
}



</style>
