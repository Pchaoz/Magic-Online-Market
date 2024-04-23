<script setup>

import AuthenticatedLayout from "@/Layouts/AuthenticatedLayout.vue";
import 'bootstrap/dist/css/bootstrap.css';

defineProps({
    productes: {
        type: Array(String),
    },
});

</script>

<template>
    <AuthenticatedLayout>
        <div class="d-flex justify-content-center">
            <table class="table table-striped table-dark w-50">
                <thead>
                <tr>
                    <th>Nom Producte</th>
                    <th class="text-center mx-2" style="width: 300px">Descripcio Producte</th>
                    <th>Imatge Producte</th>
                    <th class="text-center mx-2">Categoria Producte</th>
                    <th class="text-center mx-2">Expansio Producte</th>

                </tr>
                </thead>
                <tbody>
                <tr v-for="producte in productes" :key="producte.id">
                    <td>{{producte.nom}}</td>
                    <td class="text-center mx-2" style="width: 300px">{{producte.descripcio}}</td>
                    <td><img :src="'/images/' + producte.imatge" alt="Imatge del producte" width="150" height="200"></td>
                    <td class="text-center"> {{producte.categoriaProducteNom}} </td>
                    <td class="text-center"> {{producte.expansioNom}}</td>
                </tr>
                </tbody>
            </table>
        </div>
    </AuthenticatedLayout>
</template>

<style scoped>


.card {
    border: 1px solid #ccc;
    padding: 10px;
    margin-bottom: 10px;
}
</style>
