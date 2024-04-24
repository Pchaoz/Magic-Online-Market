<script setup>
import 'bootstrap/dist/css/bootstrap.css';
import AuthenticatedLayout from "@/Layouts/AuthenticatedLayout.vue";


defineProps({
    cartes: {
        type: Array(String),
    },

    idRolUser:{
        type:String
    }
});
</script>

<template>
    <AuthenticatedLayout>
        <div class="d-flex justify-content-center m-3 ">
            <table class="table table-striped table-dark w-50 ">
                <thead>
                <tr>
                    <th>Nom Carta</th>
                    <th></th>
                    <th></th>
                    <th>Descripcio Carta</th>
                    <th>Imatge Carta</th>
                    <th>Raresa Carta</th>
                </tr>
                </thead>
                <tbody>
                <tr v-for="carta in cartes" :key="carta.id">
                    <td>{{carta.nom}}</td>
                    <td>
                        <button v-if="user.role === 'administrador'" class="btn btn-primary rounded-circle">Mod</button>
                    </td>
                    <td>
                        <button class="btn btn-primary rounded-circle">Elim</button>
                    </td>
                    <td>{{carta.descripcio}}</td>
                    <td>
                        <img :src="'/images/' + carta.imatge" alt="Imagen de la carta" width="150" height="200" class="zoomable-image">
                    </td>
                    <td>{{carta.raresa}}</td>
                </tr>
                </tbody>
            </table>
        </div>
    </AuthenticatedLayout>
</template>

<style scoped>
.zoomable-image {
    transition: transform 0.3s ease;
}

.zoomable-image:hover {
    transform: scale(4);
}
</style>
