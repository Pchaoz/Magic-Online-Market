<script setup>
import 'bootstrap/dist/css/bootstrap.css';
import { useForm } from "@inertiajs/vue3";
import AuthenticatedLayout from "@/Layouts/AuthenticatedLayout.vue";

defineProps({
    noticia: {
        type: Array(String),
    },
});

const formNoticia = useForm({
    idNoticia: null
});

const modificarNoticia=(id)=> {
    formNoticia.idNoticia= id;
    formNoticia.get('/formModNoticia');
}
</script>

<template>
    <AuthenticatedLayout>
        <div class="news-container">
            <h1 class="news-title">{{ noticia[0].titol }}</h1>
            <h2 class="news-subtitle">{{ noticia[0].subtitol }}</h2>
            <div class="news-content">
                <b-container class="news-image-container ">
                    <b-row class="news-image-row">
                        <b-col cols="6">
                            <img :src="'/images/' + noticia[0].imatge" alt="Foto del noticia" class="news-image" />
                        </b-col>
                    </b-row>
                </b-container>
                <p class="news-author">Creado por {{ noticia[0].nick }} a las {{ noticia[0].dataHora }}</p>
                <p class="news-text">{{ noticia[0].contingut }}</p>
            </div>
        </div>
        <div class="d-flex justify-content-center m-3 " v-if="$page.props.auth.user.idRol==1 ||$page.props.auth.user.idRol==2 ">
            <b-button class="btn btn-success rounded-pill" style="width: 200px;" @click="modificarNoticia(noticia[0].idNoticia)">Modificar Noticia</b-button>
        </div>
    </AuthenticatedLayout>
</template>

<style scoped>
.news-container {
    background-color: rgba(0, 214, 153, 0.29);
    padding: 50px;
    margin: 50px auto 20px;
    width: 1000px;
    border-radius: 10px;
}

.news-title {
    font-size: 2em;
    font-weight: bold;
}

.news-subtitle {
    font-size: 1.5em;
    color: #666;
}

.news-content {
    background-color: rgba(128, 128, 128, 0.3);
    padding: 20px;
    border-radius: 10px;
}

.news-image-container {
    display: flex;
    justify-content: center;
}

.news-image-row {
    width: 75%;
    margin: 3px;
}

.news-image {
    max-width: 100%;
    max-height: 100%;
    object-fit: contain;
}

.news-author {
    font-size: 0.8em;
    color: #ffde01;
    margin-top: 15px;
}

.news-text {
    margin-top: 20px;
}
</style>
