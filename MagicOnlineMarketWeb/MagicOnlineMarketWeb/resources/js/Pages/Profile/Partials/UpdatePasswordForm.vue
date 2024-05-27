<script setup>
import InputError from '@/Components/InputError.vue';
import InputLabel from '@/Components/InputLabel.vue';
import TextInput from '@/Components/TextInput.vue';
import { useForm } from '@inertiajs/vue3';
import { ref } from 'vue';
import 'bootstrap/dist/css/bootstrap.css';


const passwordInput = ref(null);
const currentPasswordInput = ref(null);

const form = useForm({
    current_password: '',
    password: '',
    password_confirmation: '',
});

const updatePassword = () => {
    form.put(route('password.update'), {
        preserveScroll: true,
        onSuccess: () => form.reset(),
        onError: () => {
            if (form.errors.password) {
                form.reset('password', 'password_confirmation');
                passwordInput.value.focus();
            }
            if (form.errors.current_password) {
                form.reset('current_password');
                currentPasswordInput.value.focus();
            }
        },
    });
};
</script>

<template>
    <div class="d-flex justify-content-center  ">
        <div class="w-50  " >
            <section class="rounded">
        <header class="p-4">
            <h2 class="text-lg font-medium text-gray-900 ">Actualitzar contrassenya</h2>

            <p class="mt-1 text-sm text-gray-600">
                Assegureu-vos que el vostre compte utilitzi una contrasenya llarga i aleatòria per mantenir la seguretat.
            </p>
        </header>

        <form @submit.prevent="updatePassword">
            <div class="d-flex flex-column align-items-center m-4">
                <InputLabel for="current_password" value="Contrassenya Actual" />

                <TextInput
                    id="current_password"
                    ref="currentPasswordInput"
                    v-model="form.current_password"
                    type="password"
                    class="mt-1 block w-full"
                    autocomplete="current-password"
                />

                <InputError :message="form.errors.current_password" class="mt-2" />
            </div>

            <div class="d-flex flex-column align-items-center m-4 pt-3 ">
                <InputLabel for="password" value="Contrassenya Nova" />

                <TextInput
                    id="password"
                    ref="passwordInput"
                    v-model="form.password"
                    type="password"
                    class="mt-1 block w-full"
                    autocomplete="new-password"
                />

                <InputError :message="form.errors.password" class="mt-2" />
            </div>

            <div class="d-flex flex-column align-items-center m-4 pt-3 ">
                <InputLabel for="password_confirmation" value="Confirmar Contrassenya" />

                <TextInput
                    id="password_confirmation"
                    v-model="form.password_confirmation"
                    type="password"
                    class="mt-1 block w-full"
                    autocomplete="new-password"
                />

                <InputError :message="form.errors.password_confirmation" class="mt-2" />
            </div>

            <div class="d-flex flex-column align-items-center m-4 p-3">
                <button class="btn btn-success"  :disabled="form.processing">Guardar</button>

                <Transition
                    enter-active-class="transition ease-in-out"
                    enter-from-class="opacity-0"
                    leave-active-class="transition ease-in-out"
                    leave-to-class="opacity-0"
                >
                    <p v-if="form.recentlySuccessful" class="text-sm text-gray-600">Guardat.</p>
                </Transition>
            </div>
        </form>
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
