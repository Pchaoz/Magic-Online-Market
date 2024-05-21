<script setup>
import AuthenticatedLayout from '@/Layouts/AuthenticatedLayout.vue';
import DeleteUserForm from './Partials/DeleteUserForm.vue';
import UpdatePasswordForm from './Partials/UpdatePasswordForm.vue';
import UpdateProfileInformationForm from './Partials/UpdateProfileInformationForm.vue';
import { Head } from '@inertiajs/vue3';

defineProps({
    mustVerifyEmail: {
        type: Boolean,
    },
    status: {
        type: String,
    },
});
</script>

<template>
    <Head title="Profile" />

    <AuthenticatedLayout>
        <div class="d-flex justify-content-center m-3 ">
            <h2>Perfil Usuari</h2>
        </div>
        <UpdateProfileInformationForm/>
        <UpdatePasswordForm/>
        <DeleteUserForm  />
    </AuthenticatedLayout>
</template>
