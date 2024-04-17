<script setup>

import GuestLayout from "@/Layouts/GuestLayout.vue";
import InputLabel from "@/Components/InputLabel.vue";
import TextInput from "@/Components/TextInput.vue";
import {useForm} from "@inertiajs/vue3";
import PrimaryButton from "@/Components/PrimaryButton.vue";

const formCarta = useForm({
    nom:'',
    descripcio:'',
    imatge:'',
    raresa:'',
})


const submit = () => {
    formCarta.post(route('AddCarta'));
};

const myfunction = () => {
    formCarta.post(route('AddCarta'));
};

</script>


<template>
    <GuestLayout>
        <Head><title>Afegir Carta</title></Head>
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
            <InputLabel for="imatge" value="Imatge:" />
            <TextInput
                id="imatge"
                type="text"
                class="mt-1 block w-full"
                v-model="formCarta.imatge"
                required
                autofocus
                autocomplete="imatge"
            />
        </div>
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
            <b-dropdown id="dropdown-1" text="Dropdown Button" class="m-md-2">
                <b-dropdown-item>Comun</b-dropdown-item>
                <b-dropdown-item>Infrecuente</b-dropdown-item>
                <b-dropdown-item>Rara</b-dropdown-item>
                <b-dropdown-item>Mitica</b-dropdown-item>
            </b-dropdown>
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
