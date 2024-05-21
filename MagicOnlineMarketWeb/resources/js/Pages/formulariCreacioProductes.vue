<script setup>
import InputLabel from "@/Components/InputLabel.vue";
import { useForm } from "@inertiajs/vue3";
import { ref } from "vue";
import AuthenticatedLayout from "@/Layouts/AuthenticatedLayout.vue";
import 'bootstrap/dist/css/bootstrap.css';
import { required } from '@vee-validate/rules';
import { Form as VForm, Field as VField, defineRule, ErrorMessage } from 'vee-validate';
import Modal from "@/Components/Modal.vue";

defineRule('required', required);

defineProps({
    expansions:{
        type: Array(String),
    },
    categoriesProducte:{
        type: Array(String),
    },
    cartes:{
        type: Array(String),
    }
});


let showModal=ref(false);

const formProducteInsert= useForm({
        idProducte:"",
        nom: "",
        descripcio:"",
        imatge:null,
        idCategoriaProducte:"",
        idExpansio:"",
        idCarta:"",
        imatgeMiniatura:''
    })

const obtenirImatgeInsert = (event) => {
    const file = event.target.files[0];
    if (!file.type.match('image.*')) {
        alert('Si us plau només imatges!');
        event.target.value=null;
        return;
    }
    if (file.size > 1000000) {
        alert('La imatge té un tamany massa gran. El tamant màxim permés es de 1000KB.');
        event.target.value=null;
        return;
    }
    formProducteInsert.imatge = file;
    const reader = new FileReader();
    reader.onload = (e) => {
        formProducteInsert.imatgeMiniatura = e.target.result;
    };
    reader.readAsDataURL(file);
}



const insertProducte =()=>{
    formProducteInsert.post('crearProducte');
    confirmacio();
}

const confirmacio =()=>{
    showModal.value = true;
    setTimeout(() => {
        formProducteInsert.idProducte='';
        formProducteInsert.nom='';
        formProducteInsert.descripcio='';
        formProducteInsert.imatge='';
        formProducteInsert.idCategoriaProducte='';
        formProducteInsert.idExpansio='';
        formProducteInsert.idCarta='';
        formProducteInsert.imatgeMiniatura='';
        showModal.value = false;
        document.getElementById('imatge').value = '';
        useForm.visit(window.location.pathname);
    }, 500);

}

</script>

<template>
    <AuthenticatedLayout>
        <div class="d-flex justify-content-center m-3 ">
            <h2>Formulari creació Productes</h2>
        </div>
        <div class="d-flex justify-content-center  ">
            <div class="w-25 rounded"  style="background-color: rgba(255,255,255,0.2);padding: 10px; margin: 20px;">
    <VForm v-slot="{ errors }" @submit="insertProducte" class="w-100 rounded">
    <div class="d-flex flex-column align-items-center m-4 p-1">
        <InputLabel for="nom" value="Nom:" />
        <VField
            id="nom"
            name="nom"
            type="text"
            v-model="formProducteInsert.nom"
            rules="required"
            class="mt-1 block w-full"
            style="color: black;"/>
        <ErrorMessage name="nom" style="color: red; font-weight: bold;"/>
    </div>
    <div class="d-flex flex-column align-items-center m-4 p-1">
        <InputLabel for="descripcio" value="Descripcio:" />
        <VField
            id="descripcio"
            name="descripcio"
            type="text"
            v-model="formProducteInsert.descripcio"
            rules="required"
            class="mt-1 block w-full"
            style="color: black;"
        />
        <ErrorMessage name="descripcio" style="color: red; font-weight: bold;"/>
    </div>
    <div class="d-flex flex-column align-items-center m-4 ">
        <InputLabel for="imatge" value="Imatge:"/>
        <div class="d-flex flex-column align-items-center ">
        <VField
            id="imatge"
            name="imatge"
            type="file"
            class="mt-1 block w-full"
            accept="image/png, image/jpg"
            rules="required"
        @change="obtenirImatgeInsert" />
        </div>

        <ErrorMessage name="imatge" style="color: red; font-weight: bold;"/>
    </div>
    <div class="d-flex flex-column align-items-center m-4">
        <div>Categoria de Producte</div>
        <select id="idCategoriaProducte" v-model="formProducteInsert.idCategoriaProducte" style="color: black;">
            <option v-for="categoria in categoriesProducte"  v-bind:key="categoria.idCategoriaProductes" v-bind:value="categoria.idCategoriaProductes">
                {{ categoria.nom }}
            </option>
            <option >
                {{ "Sense Categoria" }}
            </option>
        </select>
    </div>
    <div class="d-flex flex-column align-items-center m-4">
        <div>Expansió</div>
        <select  id="idExpansio" v-model="formProducteInsert.idExpansio" style="color: black;">
            <option v-for="expansio in expansions" v-bind:key="expansio.idExpansio" v-bind:value="expansio.idExpansio">
                {{ expansio.nom }}
            </option>
            <option >
                {{ "Sense Expansio" }}
            </option>
        </select>
    </div>
    <div class="d-flex flex-column align-items-center m-4 ">
        <div>Carta a la que fa referencia</div>
        <select  id="idCarta" v-model="formProducteInsert.idCarta" style="color: black;">
            <option v-for="carta in cartes" v-bind:key="carta.idCarta" v-bind:value="carta.idCarta">
                {{ carta.nom }}
            </option>
            <option >
                {{ "No Carta" }}
            </option>
        </select>
    </div>
    <div class="d-flex flex-column align-items-center m-4">
        <figure>
            <img width="200" height="200" :src="formProducteInsert.imatgeMiniatura">
        </figure>
    </div>
    <div class="d-flex justify-content-center m-3 ">
        <button class="btn btn-success mr-5" :class="{ 'opacity-25': formProducteInsert.processing }" :disabled="Object.keys(errors).length > 0">Guardar</button>
    </div>
</VForm>
            </div>
            <Modal :show="showModal" maxWidth="2xl" closeable @close="cerrarForm" >
                <div class="modal-content w-100">
                    <div class="d-flex justify-content-center m-3 ">
                        <p>Producte Creat!</p>
                    </div>
                </div>
            </Modal>
        </div>
    </AuthenticatedLayout>
</template>

<style scoped>
form {
    background-color:rgba(0,214,153,0.8) !important;

}



</style>

