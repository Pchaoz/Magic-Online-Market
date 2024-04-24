<script setup>

import InputLabel from "@/Components/InputLabel.vue";
import TextInput from "@/Components/TextInput.vue";
import {useForm} from "@inertiajs/vue3";
import PrimaryButton from "@/Components/PrimaryButton.vue";
import {ref} from "vue";
import AuthenticatedLayout from "@/Layouts/AuthenticatedLayout.vue";
import 'bootstrap/dist/css/bootstrap.css';


    const formCarta = useForm({
        nom:'',
        descripcio:'',
        imatge:'',
        raresa:'Comun',
        imatgeMiniatura:'',

    })


const obtenirImatge = (e) => {

    let file =e.target.files[0];
    formCarta.imatge =file;
    mostrarImatge(file);
};


const mostrarImatge = (file) => {
    let reader = new FileReader();
    reader.onload=(e) =>{
        formCarta.imatgeMiniatura= e.target.result;
    }
    reader.readAsDataURL(file);
}

const myfunction = () => {
    formCarta.post('/crearCarta');
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
        <div  class="d-flex justify-content-center ">
            <div class=" w-25 rounded" style="background-color: black; padding: 20px; margin: 20px;">
                <form enctype="multipart/form-data" class="w-100 rounded">
                <div class="m-2">
                    <InputLabel for="nom" value="Nom:" />
                    <TextInput
                        id="nom"
                        type="text"
                        class="mt-1 block w-full"
                        v-model="formCarta.nom"
                        required
                        autofocus
                        autocomplete="nom"
                        style="color: black;"
                    />
                </div>
                <div class="m-2">
                    <InputLabel for="descripcio" value="Descripcio:" />
                    <TextInput
                        id="descripcio"
                        type="text"
                        class="mt-1 block w-full"
                        v-model="formCarta.descripcio"
                        required
                        autofocus
                        autocomplete="descripcio"
                        style="color: black;"
                    />
                </div>
                <div class="d-flex flex-column align-items-center m-2">
                <div>
                    <InputLabel for="imatge" value="Imatge:"  v-model="formCarta.imatge" />
                    <input
                        id="imatge"
                        type="file"
                        class="mt-1 block w-full"
                        required
                        autofocus
                        autocomplete="imatge"
                        @change="obtenirImatge"

                    />
                </div>

                <div class="m-2">
                    <select  id="raresa" v-model="formCarta.raresa" style="color: black;">
                        <option v-for="option in options" v-bind:key="option.name" v-bind:value="option.value">
                            {{ option.name }}
                        </option>
                    </select>
                </div>
                <figure>
                    <img width="200" height="200" :src="formCarta.imatgeMiniatura">
                </figure>

                <div class="flex items-center justify-end mt-4 m-2">
                    <PrimaryButton @click="myfunction" class="ms-4" :class="{ 'opacity-25': formCarta.processing }" :disabled="formCarta.processing">
                        Afegir
                    </PrimaryButton>
                </div>
                </div>
            </form>
        </div>
        </div>
    </AuthenticatedLayout>
</template>


<style scoped>
form {
    background-color: #888888;
    color: white;
}
</style>
