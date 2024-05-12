<script setup>

import AuthenticatedLayout from "@/Layouts/AuthenticatedLayout.vue";
import 'bootstrap/dist/css/bootstrap.css';

defineProps({
    cartesBaralla: {
        type: Array(String),
    },
    baralla:Object,


});

</script>

<template>
    <AuthenticatedLayout>
        <div class="d-flex justify-content-center m-3 ">
            <h2>Baralla {{baralla.nomBaralla}}</h2>
        </div>

        <div class="d-flex justify-content-center m-3 ">
            <div class="row hidden">
                <div class="carta-container" v-for="(carta, index) in cartesBaralla" :key="carta.idCarta" :class="{ 'clase-especial': cartesBaralla.length < 5 }">
                    <div class="card bg-transparent">
                        <div class="card-header text-right">
                            <small class="text-muted" style="font-size: 2em;">X{{carta.quantitat}}</small>
                        </div>
                        <img :src="'/images/' + carta.imatgeCarta" class="card-img-top" alt="...">
                        <div class="card-body">
                            <h5 class="card-title text-center">{{carta.nomCarta}}</h5>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </AuthenticatedLayout>
</template>

<style scoped>
* {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
}

.carta-container {
    width: 20%;
    float: left;
}

.card {
    width: 300px;
    height: 400px;
    border: none !important;
    margin-left: 10px;
    margin-bottom: 130px !important;
}

.clase-especial {
    margin-left: 100px;
}


</style>
