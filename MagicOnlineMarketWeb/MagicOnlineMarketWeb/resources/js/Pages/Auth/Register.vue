<script setup>
import GuestLayout from '@/Layouts/GuestLayout.vue';
import InputError from '@/Components/InputError.vue';
import InputLabel from '@/Components/InputLabel.vue';
import PrimaryButton from '@/Components/PrimaryButton.vue';
import TextInput from '@/Components/TextInput.vue';
import { Head, Link, useForm } from '@inertiajs/vue3';
import {ref} from "vue";
import Modal from "@/Components/Modal.vue";

const props = defineProps({
    nicks:{
        type: Array,
        default: () => ([]),
    }
});

const form = useForm({
    name: '',
    cognom:'',
    nick:'',
    email: '',
    password: '',
    password_confirmation: '',
});

let obj = ref(props.nicks);
let targetArray = [];
let showModalNickIncorrecte = ref(false);

if (obj.value) {
    targetArray = obj.value.map(user => user.nick);
}

const submit = () => {
    if (targetArray.includes(form.nick)) {
        abrirModalNickIncorrecte();
        return;
    }

    form.post(route('register'), {
        onFinish: () => form.reset('password', 'password_confirmation'),
    });
};

const abrirModalNickIncorrecte = () => {
    showModalNickIncorrecte.value =true;
}

const cerrarModalNickIncorrecte=()=>{
    showModalNickIncorrecte.value =false;
}
</script>

<template>
    <GuestLayout>
        <Head title="Register" />

        <form @submit.prevent="submit">
            <div>
                <InputLabel for="nick" value="Nick" />

                <TextInput
                    id="nick"
                    type="text"
                    class="mt-1 block w-full"
                    v-model="form.nick"
                    required
                    autofocus
                    maxlength="15"
                />

                <InputError class="mt-2" :message="form.errors.nick" />
            </div>


            <div>
                <InputLabel for="name" value="Name" />

                <TextInput
                    id="name"
                    type="text"
                    class="mt-1 block w-full"
                    v-model="form.name"
                    required
                    autofocus
                    autocomplete="name"
                    maxlength="20"
                />

                <InputError class="mt-2" :message="form.errors.name" />
            </div>

            <div>
                <InputLabel for="cognom" value="Cognom" />

                <TextInput
                    id="cognom"
                    type="text"
                    class="mt-1 block w-full"
                    v-model="form.cognom"
                    required
                    autofocus
                    maxlength="20"
                />

                <InputError class="mt-2" :message="form.errors.name" />
            </div>

            <div class="mt-4">
                <InputLabel for="email" value="Email" />

                <TextInput
                    id="email"
                    type="email"
                    class="mt-1 block w-full"
                    v-model="form.email"
                    required
                    maxlength="40"
                />

                <InputError class="mt-2" :message="form.errors.email" />
            </div>

            <div class="mt-4">
                <InputLabel for="password" value="Password" />

                <TextInput
                    id="password"
                    type="password"
                    class="mt-1 block w-full"
                    v-model="form.password"
                    required
                    autocomplete="new-password"
                />

                <InputError class="mt-2" :message="form.errors.password" />
            </div>

            <div class="mt-4">
                <InputLabel for="password_confirmation" value="Confirm Password" />

                <TextInput
                    id="password_confirmation"
                    type="password"
                    class="mt-1 block w-full"
                    v-model="form.password_confirmation"
                    required
                    autocomplete="new-password"
                />

                <InputError class="mt-2" :message="form.errors.password_confirmation" />
            </div>

            <div class="flex items-center justify-end mt-4">
                <Link
                    :href="route('login')"
                    class="underline text-sm text-gray-600 hover:text-gray-900 rounded-md focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-indigo-500"
                >
                    Already registered?
                </Link>

                <PrimaryButton class="ms-4" :class="{ 'opacity-25': form.processing }" :disabled="form.processing">
                    Register
                </PrimaryButton>
            </div>
        </form>
        <Modal :show="showModalNickIncorrecte" maxWidth="2xl" closeable @close="cerrarModalNickIncorrecte" >
            <div class="modal-content w-100">
                <div class="d-flex justify-content-between m-3 align-items-start">
                    <button @click="cerrarModalNickIncorrecte" style="border: none; background: none;">
                        <img :src="/images/+'cierre.jpg'" alt="Cerrar" style="width: 10px; height: 10px;" />
                    </button>
                    <p>Aquest nick ja existeix!</p>
                    <div></div>
                </div>
            </div>
        </Modal>
    </GuestLayout>
</template>
