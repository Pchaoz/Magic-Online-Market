<script setup>
import 'bootstrap/dist/css/bootstrap.css';


defineProps({
    cartes: {
        type: Array(String),
    },
});
</script>

<template>
    <div class="d-flex justify-content-center">
        <table class="table table-striped table-dark w-50">
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
                <td><img :src="'/images/' + carta.imatge" alt="Imagen de la carta" width="50" height="100"></td>
                <td>{{carta.raresa}}</td>
            </tr>
            </tbody>
        </table>
    </div>

</template>

<style scoped>


.card {
    border: 1px solid #ccc;
    padding: 10px;
    margin-bottom: 10px;
}
</style>
