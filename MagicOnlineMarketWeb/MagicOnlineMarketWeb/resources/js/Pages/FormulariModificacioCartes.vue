<script setup>

import InputLabel from "@/Components/InputLabel.vue";
import {useForm} from "@inertiajs/vue3";
import {ref} from "vue";
import AuthenticatedLayout from "@/Layouts/AuthenticatedLayout.vue";
import 'bootstrap/dist/css/bootstrap.css';
import Modal from "@/Components/Modal.vue";
import { required } from '@vee-validate/rules';
import { Form as VForm, Field as VField, defineRule, ErrorMessage } from 'vee-validate';

defineRule('required', required);

const props = defineProps({
    carta: Object
});


const cerrarModal = () => {
    showModal.value = false;
}

let showModal = ref(false);

const formCarta = useForm({
    id: props.carta.idCarta,
    nom: props.carta.nom,
    descripcio: props.carta.descripcio,
    imatge: null,
    raresa: props.carta.raresa,

})

let imatgeUrl = ref('/images/' + props.carta.imatge)

const obtenirImatge = (event) => {
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
    formCarta.imatge = file;
    const reader = new FileReader();
    reader.onload = (e) => {
        imatgeUrl = e.target.result;
    };
    reader.readAsDataURL(file);

}

const myfunction =   () => {
     formCarta.post('editarCarta');
     completarModificacio();
}
const completarModificacio =   () => {
    showModal.value = true;
    setTimeout(() => {
        showModal.value = false;
        window.location.href = '/getAllCartes';
    }, 500);

}



const options= ref([
    {
        name:"Comun",
        value:"Comun"
    },
    {
        name:"Infrecuente",
        value:"Infrecuente"
    },
    {
        name:"Rara",
        value:"Rara"
    },
    {
        name:"Mitica",
        value:"Mitica"
    }
])


</script>
<template>
    <AuthenticatedLayout>
        <div class="d-flex justify-content-center m-3 ">
            <h2>Formulari modificació Cartes</h2>
        </div>
        <div  class="d-flex justify-content-center">
            <div class="w-25 rounded"  style="background-color: rgba(255,255,255,0.2);padding: 20px; margin: 20px;">
                <VForm v-slot="{ errors }" @submit="myfunction" class="w-100 rounded">
                    <div class="d-flex flex-column align-items-center m-4 p-1">
                        <InputLabel for="nom" value="Nom:" />
                        <VField id="nom" name="nom" type="text" v-model="formCarta.nom" rules="required" maxlength="50" class="mt-1 block w-full" style="color: black;" />
                        <ErrorMessage name="nom" style="color: red; font-weight: bold;"/>
                    </div>
                    <div class="d-flex flex-column align-items-center m-4 p-1">
                        <InputLabel for="descripcio" value="Descripcio:" />
                        <VField id="descripcio" name="descripcio" type="text" v-model="formCarta.descripcio" rules="required" maxlength="500" class="mt-1 block w-full" style="color: black;" />
                        <ErrorMessage name="descripcio" style="color: red; font-weight: bold;"/>
                    </div>
                    <div class="d-flex flex-column align-items-center m-4 p-1">
                        <InputLabel for="imatge" value="Imatge:" />
                        <div class="d-flex flex-column align-items-center ">
                            <VField id="imatge" name="imatge" type="file" class="mt-1 block w-full"   accept="image/png, image/jpg" style="color: black" @change="obtenirImatge" />
                        </div>
                    </div>
                    <div class="d-flex flex-column align-items-center m-4 p-1">
                        <select id="raresa" required v-model="formCarta.raresa" style="color: black;">
                            <option v-for="option in options" :key="option.name" :value="option.value">
                                {{ option.name }}
                            </option>
                        </select>
                    </div>
                    <div class="d-flex flex-column align-items-center m-4 p-1">
                        <figure>
                            <img width="200" height="200" :src="imatgeUrl">
                        </figure>
                    </div>
                    <div class="d-flex flex-column align-items-center m-4 p-1">
                        <button class="btn btn-success" :class="{ 'opacity-25': formCarta.processing }" :disabled="Object.keys(errors).length > 0">
                            Modificar
                        </button>
                    </div>
                </VForm>
            </div>
            <Modal :show="showModal" maxWidth="2xl" closeable @close="cerrarModal" >
                <div class="modal-content w-100">
                    <div class="d-flex justify-content-center m-3 ">
                        <p>Carta Modificada!</p>
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
