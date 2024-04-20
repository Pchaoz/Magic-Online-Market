<script setup>

import GuestLayout from "@/Layouts/GuestLayout.vue";
import InputLabel from "@/Components/InputLabel.vue";
import TextInput from "@/Components/TextInput.vue";
import {useForm} from "@inertiajs/vue3";
import PrimaryButton from "@/Components/PrimaryButton.vue";
import {ref} from "vue";

const formCarta = useForm({
    nom:'',
    descripcio:'',
    imatge:'',
    raresa:'Comun',
})

const myfunction = () => {
    formCarta.post('/AddCarta');
};

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
    <GuestLayout>
        <Head><title>Afegir Carta</title></Head>
        <div>
            <InputLabel for="nom" value="Nom:" />
            <TextInput
                id="nom"
                type="text"
                class="mt-1 block w-full"
                v-model="formCarta.nom"
                required
                autofocus
                autocomplete="nom"
            />
        </div>
        <div>
            <InputLabel for="descripcio" value="Descripcio:" />
            <TextInput
                id="descripcio"
                type="text"
                class="mt-1 block w-full"
                v-model="formCarta.descripcio"
                required
                autofocus
                autocomplete="descripcio"
            />
        </div>
        <div>
            <InputLabel for="imatge" value="Imatge:"  v-model="formCarta.imatge" />
            <input
                id="imatge"
                type="file"
                class="mt-1 block w-full"
                required
                autofocus
                autocomplete="imatge"
            />
        </div>

        <div>
            <select  id="raresa" v-model="formCarta.raresa">
                <option v-for="option in options" v-bind:key="option.name" v-bind:value="option.value">
                    {{ option.name }}
                </option>

            </select>

        </div>
        <div class="flex items-center justify-end mt-4">
            <PrimaryButton @click="myfunction" class="ms-4" :class="{ 'opacity-25': formCarta.processing }" :disabled="formCarta.processing">
                Afegir
            </PrimaryButton>
        </div>

    </GuestLayout>

</template>

<style scoped>

</style>
