<script setup>
import DangerButton from '@/Components/DangerButton.vue';
import InputError from '@/Components/InputError.vue';
import InputLabel from '@/Components/InputLabel.vue';
import Modal from '@/Components/Modal.vue';
import SecondaryButton from '@/Components/SecondaryButton.vue';
import TextInput from '@/Components/TextInput.vue';
import { useForm } from '@inertiajs/vue3';
import { nextTick, ref } from 'vue';
import 'bootstrap/dist/css/bootstrap.css';

const confirmingUserDeletion = ref(false);
const passwordInput = ref(null);

const form = useForm({
    password: '',
});

const confirmUserDeletion = () => {
    confirmingUserDeletion.value = true;

    nextTick(() => passwordInput.value.focus());
};

const deleteUser = () => {
    form.delete(route('profile.destroy'), {
        preserveScroll: true,
        onSuccess: () => closeModal(),
        onError: () => passwordInput.value.focus(),
        onFinish: () => form.reset(),
    });
};

const closeModal = () => {
    confirmingUserDeletion.value = false;

    form.reset();
};
</script>

<template>
    <div class="d-flex justify-content-center  ">
        <div class="w-50  " >
            <section class="rounded">
        <header class="p-4">
            <h2 class="text-lg font-medium text-gray-900">Borrar Compte</h2>

            <p class="mt-1 text-sm text-gray-600">
                Un cop suprimit el vostre compte, tots els seus recursos i dades se suprimiran permanentment. Abans d'esborrar
                al vostre compte, baixeu qualsevol dada o informació que vulgueu conservar.
            </p>
        </header>
                <div class="d-flex flex-column align-items-center m-4 p-3">
        <button class="btn btn-danger" @click="confirmUserDeletion">Delete Account</button>
                </div>
        <Modal :show="confirmingUserDeletion" @close="closeModal">
            <div class="p-6">
                <h2 class="text-lg font-medium text-gray-900">
                    Esteu segur que voleu suprimir el vostre compte?
                </h2>

                <p class="mt-1 text-sm text-gray-600">
                    Un cop suprimit el vostre compte, tots els seus recursos i dades es suprimiran permanentment. Abans d'esborrar el vostre compte, baixeu qualsevol dada o informació que vulgueu conservar.

                </p>

                <div class="d-flex flex-column align-items-center m-4 pt-3">
                    <InputLabel for="password" value="Password" class="sr-only" />

                    <TextInput
                        id="password"
                        ref="passwordInput"
                        v-model="form.password"
                        type="password"
                        class="mt-1 block w-3/4"
                        placeholder="Password"
                        @keyup.enter="deleteUser"
                    />

                    <InputError :message="form.errors.password" class="mt-2" />
                </div>

                <div class="d-flex justify-content-center m-3 ">
                    <button type="button" class="btn btn-success mr-5" @click="closeModal"> Cancel </button>

                    <button type="button" class="btn btn-danger ml-5"
                        :class="{ 'opacity-25': form.processing }"
                        :disabled="form.processing"
                        @click="deleteUser"
                    >
                        Delete Account
                    </button>
                </div>
            </div>
        </Modal>
    </section>
        </div>
    </div>
</template>

<style scoped>
form.rounded, section.rounded  {
    background-color:rgba(0,214,153,0.8) !important;
    border-radius: 1rem !important;

}

</style>
