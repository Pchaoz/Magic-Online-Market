<script setup>
import InputError from '@/Components/InputError.vue';
import InputLabel from '@/Components/InputLabel.vue';
import TextInput from '@/Components/TextInput.vue';
import { Link, useForm, usePage } from '@inertiajs/vue3';
import 'bootstrap/dist/css/bootstrap.css';


defineProps({
    mustVerifyEmail: {
        type: Boolean,
    },
    status: {
        type: String,
    },
});

const user = usePage().props.auth.user;


const form = useForm({
    nick: user.nick,
    name: user.name,
    cognom: user.cognom,
});

const myfunction =   () => {
    form.post('profile.update');
    recarga();

}
const recarga =   () => {
    setTimeout(() => {
        location.reload();
    }, 500);

}
</script>

<template>

        <div class="d-flex justify-content-center ">
            <div class="w-50 " >

        <form class="rounded"  @submit="myfunction" >
            <div class="d-flex flex-column align-items-center m-4 pt-3 ">
                <InputLabel for="nick" value="Nick" />

                <TextInput
                    id="nick"
                    type="text"
                    class="mt-1 block w-full"
                    v-model="form.nick"
                    required
                    autofocus
                    autocomplete="nick"
                />

                <InputError class="mt-2" :message="form.errors.nick" />
            </div>

            <div class="d-flex flex-column align-items-center m-4 pt-3">
                <InputLabel for="name" value="Name" />

                <TextInput
                    id="name"
                    type="text"
                    class="mt-1 block w-full"
                    v-model="form.name"
                    required
                    autofocus
                    autocomplete="name"
                />

                <InputError class="mt-2" :message="form.errors.name" />
            </div>

            <div class="d-flex flex-column align-items-center m-4 pt-3">
                <InputLabel for="cognom" value="Cognom" />

                <TextInput
                    id="cognom"
                    type="text"
                    class="mt-1 block w-full"
                    v-model="form.cognom"
                    required
                    autofocus
                    autocomplete="cognom"
                />

                <InputError class="mt-2" :message="form.errors.cognom" />
            </div>


            <div class="d-flex flex-column align-items-center m-4 p-3">
                <button class="btn btn-success" >Guardar</button>
            </div>
        </form>
            </div>
        </div>
</template>

<style scoped>
form {
    background-color:rgba(0,214,153,0.8) !important;

}

</style>

