<script setup>
import InputLabel from "@/Components/InputLabel.vue";
import { useForm } from "@inertiajs/vue3";
import { ref } from "vue";
import AuthenticatedLayout from "@/Layouts/AuthenticatedLayout.vue";
import 'bootstrap/dist/css/bootstrap.css';
import Modal from "@/Components/Modal.vue";
import { required } from '@vee-validate/rules';
import { Form as VForm, Field as VField, defineRule, ErrorMessage } from 'vee-validate';


defineRule('required', required);

const formCarta = useForm({
    nom:'',
    descripcio:'',
    imatge:null,
    raresa:'Comun',
    imatgeMiniatura:'',
});

let showModal = ref(false);

const obtenirImatge = (e) => {
    let file = e.target.files[0];
    formCarta.imatge = file;
    mostrarImatge(file);
};

const mostrarImatge = (file) => {
    let reader = new FileReader();
    reader.onload = (e) => {
        formCarta.imatgeMiniatura = e.target.result;
    }
    reader.readAsDataURL(file);
}

const myfunction = () => {
    formCarta.post('/crearCarta');
    cerrarForm()
}

const cerrarForm = () => {
    showModal.value = true;
    location.reload();

}

const options = ref([
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
]);
</script>

<template>
    <AuthenticatedLayout>
        <div class="d-flex justify-content-center pt-16 ">
            <div class="w-25 rounded"  style="background-color: rgba(255,255,255,0.2);padding: 20px; margin: 20px;">
                <VForm v-slot="{ errors }" @submit="myfunction" class="w-100 rounded">
                    <div class="d-flex flex-column align-items-center m-4 p-1">
                        <InputLabel for="nom" value="Nom:" />
                        <VField id="nom" name="nom" type="text" v-model="formCarta.nom" rules="required" class="mt-1 block w-full" style="color: black;" />
                        <ErrorMessage name="nom" />
                    </div>
                    <div class="d-flex flex-column align-items-center m-4 p-1">
                        <InputLabel for="descripcio" value="Descripcio:" />
                        <VField id="descripcio" name="descripcio" type="text" v-model="formCarta.descripcio" rules="required" class="mt-1 block w-full" style="color: black;" />
                        <ErrorMessage name="descripcio" />
                    </div>
                    <div class="d-flex flex-column align-items-center m-4 p-1">
                        <InputLabel for="imatge" value="Imatge:" />
                        <VField id="imatge" name="imatge" type="file" class="mt-1 block w-full" rules="required" style="color: black" @change="obtenirImatge" />
                        <ErrorMessage name="imatge" />
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
                        <img width="200" height="200" :src="formCarta.imatgeMiniatura">
                    </figure>
                    </div>
                    <div class="d-flex flex-column align-items-center m-4 p-1">
                        <button class="btn btn-success" :class="{ 'opacity-25': formCarta.processing }" :disabled="Object.keys(errors).length > 0">
                            Afegir
                        </button>
                    </div>
                </VForm>
            </div>
            <Modal :show="showModal" maxWidth="2xl" closeable @close="cerrarForm">
                <div class="modal-content w-100">
                    <div class="d-flex justify-content-center m-3 ">
                        <p>Carta Creada!</p>
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
