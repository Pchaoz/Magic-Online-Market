<script setup>

import InputLabel from "@/Components/InputLabel.vue";
import TextInput from "@/Components/TextInput.vue";
import {useForm} from "@inertiajs/vue3";
import PrimaryButton from "@/Components/PrimaryButton.vue";
import {ref} from "vue";
import AuthenticatedLayout from "@/Layouts/AuthenticatedLayout.vue";
import 'bootstrap/dist/css/bootstrap.css';
import Modal from "@/Components/Modal.vue";


const props = defineProps({
    carta: Object
});

const abrirModal = () => {
    showModal.value = true;

}

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

const obtenirImatge = (e) => {
    let file = e.target.files[0]
    formCarta.imatge = file
    mostrarImatge(file)
}


const mostrarImatge = (file) => {
    let reader = new FileReader()
    reader.onload = (e) => {
        imatgeUrl.value = e.target.result
    }
    reader.readAsDataURL(file)
}

const myfunction = () => {
    formCarta.post('editarCarta');
    location.reload();
    abrirModal();
}

const options= ref([
    {
        name:"comun",
        value:"comun"
    },
    {
        name:"infrecuente",
        value:"infrecuente"
    },
    {
        name:"rara",
        value:"rara"
    },
    {
        name:"mitica",
        value:"mitica"
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
                            <img width="200" height="200" :src="imatgeUrl">
                        </figure>

                        <div class="flex items-center justify-end mt-4 m-2">
                            <PrimaryButton @click="myfunction" class="ms-4" :class="{ 'opacity-25': formCarta.processing }" :disabled="formCarta.processing">
                                Modificar
                            </PrimaryButton>
                        </div>
                    </div>
                </form>
            </div>
            <Modal :show="showModal" maxWidth="2xl" closeable @close="cerrarModal" >
                <div class="modal-content w-100">
                    <span class="close" @click="cerrarModal">×</span>
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
    background-color: #888888;
    color: white;
}
</style>
