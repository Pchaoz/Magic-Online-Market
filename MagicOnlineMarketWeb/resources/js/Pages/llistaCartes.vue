<script setup>
import GuestLayout from "@/Layouts/GuestLayout.vue";
import 'bootstrap/dist/css/bootstrap.css';


defineProps({
    cartes: {
        type: Array(String),
    },
});
</script>

<template>
    <GuestLayout>
        <table class="table table-striped">
            <thead>
            <tr>
                <th>Nom Carta</th>
                <th>Descripcio Carta</th>
                <th>Imatge Carta</th>
                <th>Raresa Carta</th>
            </tr>
            </thead>
            <tbody>
            <tr v-for="carta in cartes" :key="carta.id">
                <td>{{carta.nom}}</td>
                <td>{{carta.descripcio}}</td>
                <td>{{carta.imatge}}</td>
                <td>{{carta.raresa}}</td>
            </tr>
            </tbody>
        </table>

    </GuestLayout>
</template>

<style scoped>


.card {
    border: 1px solid #ccc;
    padding: 10px;
    margin-bottom: 10px;
}
</style>
