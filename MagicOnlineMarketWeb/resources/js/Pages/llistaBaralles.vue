<script setup>


import AuthenticatedLayout from "@/Layouts/AuthenticatedLayout.vue";
import 'bootstrap/dist/css/bootstrap.css';

defineProps({
    baralles: {
        type: Array(String),
    }
});


</script>

<template>

    <AuthenticatedLayout>
        <div class="d-flex justify-content-center m-3 ">
            <h2>Llistat de Baralles</h2>
        </div>
        <div class="d-flex justify-content-center m-3 ">
            <table class="table table-striped my-table w-50 ">
                <thead>
                <tr>
                    <th>Nom Baralla</th>
                    <th>Creador Baralla</th>
                </tr>
                </thead>
                <tbody>
                <tr v-for="baralla in baralles" :key="baralla.id"  >
                    <td v-if=" $page.props.auth.user.idRol==1 ||$page.props.auth.user.idUsuari===baralla.idUsuari || baralla.isPublic===1">
                        <a :href="'/veureBaralla/' + baralla.idBaralla"> {{baralla.nomBaralla}}</a>
                    </td>
                    <td v-if=" $page.props.auth.user.idRol==1 ||$page.props.auth.user.idUsuari===baralla.idUsuari || baralla.isPublic===1">{{baralla.nickCreador}}</td>

                </tr>
                </tbody>
            </table>
        </div>
    </AuthenticatedLayout>
</template>

<style scoped>
.my-table td, .my-table th {
    background-color: rgba(0,214,153,0.7) !important;
    text-align: center;
    vertical-align: middle;
}

</style>
