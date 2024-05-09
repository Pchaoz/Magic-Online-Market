<script setup>

import AuthenticatedLayout from "@/Layouts/AuthenticatedLayout.vue";
import {ref} from "vue";
import {useForm} from "@inertiajs/vue3";
import Modal from "@/Components/Modal.vue";
import InputLabel from "@/Components/InputLabel.vue";
import 'bootstrap/dist/css/bootstrap.css';import { required } from '@vee-validate/rules';
import { Form as VForm, Field as VField, defineRule, ErrorMessage } from 'vee-validate';

defineRule('required', required);
defineProps({
    categoriesProductes: {
        type: Array(String),
    }
});

let showModal = ref(false);
let showModalEliminacio = ref(false);
let showModalCreacio=ref(false);
let showModalCreacioConfirmacio=ref(false);
let showModalModificacio=ref(false);
let showModalModificacioConfirmacio=ref(false);

const abrirModalCreacio = () =>{
    cerrarModal();
    formCategoriesProductes.nom="";
    showModalCreacio.value=true;
}

const cerrarModalCreacio = () =>{
    showModalCreacio.value=false;
}

const abrirModalConfirmacion = (id) => {
    showModal.value = true;
    formCategoriesProductes.id=id;
}


const cerrarModal = () => {
    showModal.value = false;
    showModalEliminacio.value=false;
}

const abrirModalMod = (categoriesProductes) =>{
    cerrarModal();
    showModalModificacio.value=true;
    formCategoriesProductes.nom=categoriesProductes.nom;
    formCategoriesProductes.id=categoriesProductes.idCategoriaProductes;
}

const modificarCategoria = () => {
    formCategoriesProductes.post('editarCategProductes');
    finModificacio();

}

const finModificacio=()=>{
    showModalModificacio.value=false;
    showModalModificacioConfirmacio.value=true;
    setTimeout(() => {
        showModalModificacioConfirmacio.value = false;
        useForm.visit(window.location.pathname);
    }, 500);

}

const cerrarModalMod=()=>{
    showModalModificacio.value=false;
}



const eliminarCategoria =  () => {
    formCategoriesProductes.delete(`eliminarCategProductes`);
    finEliminacio();

}

const finEliminacio=()=>{
    showModal.value=false;
    showModalEliminacio.value=true;
    setTimeout(() => {
        showModalEliminacio.value = false;
        formCategoriesProductes.id="";
        useForm.visit(window.location.pathname);
    }, 500);

}

const formCategoriesProductes= useForm({
    nom: "",
    id:"",

})
const crearCategoria=()=> {

    formCategoriesProductes.post('crearCategProductes');
    confirmacionCreacio();
}

const confirmacionCreacio=()=>{
    showModalCreacio.value=false;
    showModalCreacioConfirmacio.value=true;
    setTimeout(() => {
        showModalCreacioConfirmacio.value = false;
        useForm.visit(window.location.pathname);
    }, 500);

}


</script>

<template>
    <AuthenticatedLayout>
        <div class="d-flex justify-content-center m-3 ">
            <h2>Administrar Categories de Productes</h2>
        </div>
        <div class="d-flex justify-content-center m-3 ">
            <table class="table table-striped my-table w-25 ">
                <thead>
                <tr>
                    <th>Nom</th>
                    <th></th>
                    <th></th>
                </tr>
                </thead>
                <tbody>
                <tr v-for="categoriaProducte in categoriesProductes" :key="categoriaProducte.id">
                    <td>{{categoriaProducte.nom}}</td>
                    <td>
                        <button  class="btn btn-success rounded-pill"
                                 @click="abrirModalMod(categoriaProducte)">Modificar</button>

                    </td>
                    <td>
                        <button  class="btn btn-danger rounded-pill"
                                 @click="abrirModalConfirmacion(categoriaProducte.idCategoriaProductes)">Eliminar</button>

                    </td>
                </tr>
                </tbody>
            </table>

            <Modal :show="showModal" maxWidth="2xl" closeable @close="cerrarModal" >
                <div class="modal-content w-100">
                    <div class="d-flex justify-content-center m-3 ">
                        <p>¿Estas segur de que vols eliminar aquesta categoria de producte?</p>
                    </div>
                    <div class="d-flex justify-content-center m-3 ">
                        <button type="button" class="btn btn-success mr-5"
                                @click="eliminarCategoria">Sí</button>
                        <button type="button" class="btn btn-danger ml-5" @click="cerrarModal">No</button>

                    </div>
                </div>
            </Modal>
            <Modal :show="showModalEliminacio" maxWidth="2xl" closeable @close="cerrarModal" >
                <div class="modal-content w-100">
                    <div class="d-flex justify-content-center m-3 ">
                        <p>Categoria de Producte Eliminada</p>
                    </div>
                </div>
            </Modal>

            <Modal :show="showModalCreacio" maxWidth="2xl" closeable @close="cerrarModalCreacio" >
                <div class="d-flex justify-content-center ">
                    <div class="w-50 rounded my-table"  style="padding: 20px; margin: 20px;">
                        <VForm v-slot="{ errors }" @submit="crearCategoria" class="w-100 rounded">
                            <div class="d-flex flex-column align-items-center m-4 p-1">
                                <InputLabel for="nom" value="Nom:" />
                                <VField id="nom" name="nom" type="text" v-model="formCategoriesProductes.nom" rules="required" class="mt-1 block w-full" style="color: black;" />
                                <ErrorMessage name="nom" />
                            </div>
                            <div class="d-flex justify-content-center m-3 ">
                                <button class="btn btn-success mr-5" :class="{ 'opacity-25': formCategoriesProductes.processing }" :disabled="Object.keys(errors).length > 0">Crear</button>
                                <button type="button" class="btn btn-danger ml-5"
                                        @click="cerrarModalCreacio">Cancelar</button>
                            </div>
                        </VForm>
                    </div>
                </div>
            </Modal>

            <Modal :show="showModalModificacio" maxWidth="2xl" closeable @close="cerrarModalMod" >
                <div class="d-flex justify-content-center ">
                    <div class="w-50 rounded my-table"  style="padding: 20px; margin: 20px;">
                        <VForm v-slot="{ errors }" @submit="modificarCategoria" class="w-100 rounded">
                            <div class="d-flex flex-column align-items-center m-4 p-1">
                                <InputLabel for="nom" value="Nom:" />
                                <VField id="nom" name="nom" type="text" v-model="formCategoriesProductes.nom" rules="required" class="mt-1 block w-full" style="color: black;" />
                                <ErrorMessage name="nom" />
                            </div>
                            <div class="d-flex justify-content-center m-3 ">
                                <button class="btn btn-success mr-5" :class="{ 'opacity-25': formCategoriesProductes.processing }" :disabled="Object.keys(errors).length > 0">Modificar</button>
                                <button type="button" class="btn btn-danger ml-5"
                                        @click="cerrarModalMod">Cancelar</button>
                            </div>
                        </VForm>
                    </div>
                </div>
            </Modal>
            <Modal :show="showModalModificacioConfirmacio" maxWidth="2xl" closeable @close="cerrarModalMod" >
                <div class="modal-content w-100">
                    <div class="d-flex justify-content-center m-3 ">
                        <p>Categoria de Productes Modificada</p>
                    </div>
                </div>
            </Modal>

            <Modal :show="showModalCreacioConfirmacio" maxWidth="2xl" closeable @close="cerrarModalMod" >
                <div class="modal-content w-100">
                    <div class="d-flex justify-content-center m-3 ">
                        <p>Categoria de Productes Creada</p>
                    </div>
                </div>
            </Modal>
        </div>
        <div class="d-flex justify-content-center m-3 ">
            <button  class="btn btn-success"
                     @click="abrirModalCreacio()">Crear Categoria de Productes</button>
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
