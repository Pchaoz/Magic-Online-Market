<script setup>
import AuthenticatedLayout from '@/Layouts/AuthenticatedLayout.vue';
import DeleteUserForm from './Partials/DeleteUserForm.vue';
import UpdatePasswordForm from './Partials/UpdatePasswordForm.vue';
import {Head, useForm, usePage} from '@inertiajs/vue3';
import InputLabel from "@/Components/InputLabel.vue";
import TextInput from "@/Components/TextInput.vue";
import InputError from "@/Components/InputError.vue";
import {ref} from "vue";
import Modal from "@/Components/Modal.vue";

const props = defineProps({
    mustVerifyEmail: {
        type: Boolean,
    },
    status: {
        type: String,
    },
    nicks:{
        type: Array,
        default: () => ([]),
    }
});

let obj = ref(props.nicks);
let targetArray = [];
let showModalNickIncorrecte = ref(false);

if (obj.value) {
    targetArray = obj.value.map(user => user.nick);
}
const user = usePage().props.auth.user;


const form = useForm({
    nick: user.nick,
    name: user.name,
    cognom: user.cognom,
});

const myfunction =   (e) => {
    e.preventDefault();
    if (targetArray.includes(form.nick)) {
        abrirModalNickIncorrecte();
        return;
    }
    form.post('profile.update');
    setTimeout(() => {
        useForm.visit(window.location.pathname);
    }, 500);
}

const abrirModalNickIncorrecte = () => {
    showModalNickIncorrecte.value =true;
}

const cerrarModalNickIncorrecte=()=>{
    showModalNickIncorrecte.value =false;
}




</script>

<template>
    <Head title="Profile" />

    <AuthenticatedLayout>
        <div class="d-flex justify-content-center m-3 ">
            <h2>Perfil Usuari</h2>
        </div>
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
                            maxlength="15"
                            required
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
                            maxlength="20"
                            required
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
                            maxlength="20"
                            required
                        />

                        <InputError class="mt-2" :message="form.errors.cognom" />
                    </div>


                    <div class="d-flex flex-column align-items-center m-4 p-3">
                        <button class="btn btn-success" >Guardar</button>
                    </div>
                </form>
            </div>
        </div>
        <UpdatePasswordForm/>
        <DeleteUserForm  />

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
    </AuthenticatedLayout>
</template>

<style scoped>
form {
    background-color:rgba(0,214,153,0.8) !important;

}

</style>
