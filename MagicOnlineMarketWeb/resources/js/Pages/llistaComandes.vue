<script setup>

import 'bootstrap/dist/css/bootstrap.css'
import AuthenticatedLayout from "@/Layouts/AuthenticatedLayout.vue";

defineProps({
    comandes:{
        type: Array(String),
    },
});
</script>

<template>
    <AuthenticatedLayout>
        <div class="d-flex justify-content-center m-3 ">
            <table class="table  table-striped  my-table w-50 ">
                <thead>
                <tr>
                    <th class="col-1">ID</th>
                    <th class="col-1">Comprador</th>
                    <th class="col-1">Venedor</th>
                    <th class="col-1">Total</th>
                    <th class="col-1">Estat</th>
                </tr>
                </thead>
                <tbody>
                <tr v-for="comanda in comandes" :key="comanda.id">
                    <td>{{comanda.idComanda}}</td>
                    <td>{{comanda.nickVenedor}}</td>
                    <td>{{comanda.nickComprador}}</td>
                    <td>{{comanda.total}}</td>
                    <td>{{comanda.estat}}</td>

                </tr>
                </tbody>
            </table>

        </div>
    </AuthenticatedLayout>
</template>

<style scoped>
.my-table td, .my-table th {
    background-color: rgba(0,214,153,0.5) !important;
    text-align: center;
    vertical-align: middle;
}

form {
    background-color:rgba(0,214,153,0.8) !important;
}
</style>
