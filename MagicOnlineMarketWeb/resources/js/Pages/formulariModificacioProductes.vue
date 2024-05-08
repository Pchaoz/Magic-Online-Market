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


const props =defineProps({
    producte: Object,
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

let imatgeUrl = ref('/images/' + props.producte.imatge)
let producte=props.producte;

const formProducte= useForm({
    idProducte:producte.idProducte,
    nom: producte.nom,
    descripcio: producte.descripcio,
    imatge:'/images/'+producte.imatge,
    idCategoriaProducte:producte.idCategoriaProducte==null? null: producte.idCategoriaProducte,
    idExpansio:producte.idExpansio==null?  null: producte.idExpansio,
    idCarta:producte.idCarta==null?  null: producte.idCarta,
    imatgeMiniatura:'/images/'+producte.imatge,
})


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
    formProducte.imatge = file;
    const reader = new FileReader();
    reader.onload = (e) => {
        imatgeUrl = e.target.result;
    };
    reader.readAsDataURL(file);
}


const modProducte =()=>{
    formProducte.post('modificarProducte');
    confirmacio();
}

const confirmacio =()=>{
    showModal.value=true;
    setTimeout(() => {
        showModal.value = false;
        window.location.href = '/getAllProductes';
    }, 500);

}



</script>

<template>
    <AuthenticatedLayout>
        <div class="d-flex justify-content-center pt-5 ">
            <div class="w-25 rounded"  style="background-color: rgba(255,255,255,0.2);padding: 10px; margin: 20px;">
                <VForm v-slot="{ errors }" @submit="modProducte" class="w-100 rounded">
                    <div class="d-flex flex-column align-items-center m-4 ">
                        <InputLabel for="nom" value="Nom:" />
                        <VField
                            id="nom"
                            name="nom"
                            type="text"
                            v-model="formProducte.nom"
                            rules="required"
                            class="mt-1 block w-full"
                            style="color: black;"/>
                        <ErrorMessage name="nom" />
                    </div>
                    <div class="d-flex flex-column align-items-center m-4 p-1">
                        <InputLabel for="descripcio" value="Descripcio:" />
                        <VField
                            id="descripcio"
                            name="descripcio"
                            type="text"
                            v-model="formProducte.descripcio"
                            rules="required"
                            class="mt-1 block w-full"
                            style="color: black;"
                        />
                        <ErrorMessage name="descripcio" />
                    </div>
                    <div class="d-flex flex-column align-items-center m-4 p-1">
                        <InputLabel for="imatge" value="Imatge:"/>
                        <div class="d-flex flex-column align-items-center ">
                        <VField
                            id="imatge"
                            name="imatge"
                            type="file"
                            class="mt-1 block w-full"
                            @change="obtenirImatge"
                        />
                        </div>
                    </div>
                    <div class="d-flex flex-column align-items-center m-4">
                        <div>Categoria de Producte</div>
                        <select id="idCategoriaProducte" v-model="formProducte.idCategoriaProducte" style="color: black;">
                            <option v-for="categoria in props.categoriesProducte"  v-bind:key="categoria.idCategoriaProductes" v-bind:value="categoria.idCategoriaProductes">
                                {{ categoria.nom }}
                            </option>
                            <option >
                                {{ "Sense Categoria" }}
                            </option>
                        </select>
                    </div>
                    <div class="d-flex flex-column align-items-center m-4">
                        <div>Expansió</div>
                        <select  id="idExpansio" v-model="formProducte.idExpansio" style="color: black;">
                            <option v-for="expansio in props.expansions" v-bind:key="expansio.idExpansio" v-bind:value="expansio.idExpansio">
                                {{ expansio.nom }}
                            </option>
                            <option >
                                {{ "Sense Expansio" }}
                            </option>
                        </select>
                    </div>
                    <div class="d-flex flex-column align-items-center m-4 ">
                        <div>Carta a la que fa referencia</div>
                        <select  id="idCarta" v-model="formProducte.idCarta" style="color: black;">
                            <option v-for="carta in props.cartes" v-bind:key="carta.idCarta" v-bind:value="carta.idCarta">
                                {{ carta.nom }}
                            </option>
                            <option >
                                {{ "No Carta" }}
                            </option>
                        </select>
                    </div>
                    <div class="d-flex flex-column align-items-center m-4">
                        <figure>
                            <img width="200" height="200" :src="imatgeUrl">
                        </figure>
                    </div>
                    <div class="d-flex justify-content-center m-3 ">
                        <button class="btn btn-success mr-5" :class="{ 'opacity-25': formProducte.processing }" :disabled="Object.keys(errors).length > 0">Guardar</button>

                    </div>
                </VForm>
            </div>
            <Modal :show="showModal" maxWidth="2xl" >
                <div class="modal-content w-100">
                    <div class="d-flex justify-content-center m-3 ">
                        <p>Producte Modificat!</p>
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

