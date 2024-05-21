<script setup>
import AuthenticatedLayout from '@/Layouts/AuthenticatedLayout.vue';
import 'bootstrap/dist/css/bootstrap.css';
import { Head } from '@inertiajs/vue3';
import axios from "axios";
import {ref} from "vue";

let noticies = ref([])
async function obtenerNoticiasRecientes() {
    try {
        const response = await axios.get('/api/lastNoticies');
        noticies.value = response.data;

    } catch (error) {
        console.error(error);
    }
}

obtenerNoticiasRecientes();
</script>

<template>
    <Head title="Pàgina Principal" />

    <AuthenticatedLayout>
        <div>
            <div class="flex justify-center items-center">
            <h2 class="p-4">Noticies Recents</h2>
            </div>
            <div class="flex justify-center items-center p-4">
            <Carousel v-bind="settings" :breakpoints="breakpoints" class="w-50">
                <Slide v-for="(noticia, index) in noticies" :key="index">
                    <div class="carousel__item">
                        <a :href="`veureNoticia/${noticia.idNoticia}`"> <img :src="'/images/'+noticia.imatge" alt="Slide {{ index + 1 }}"
                                                                   style="width: 950px; height: 500px; object-fit: cover;"/></a>
                        <h1>{{ noticia.titol }}</h1>
                    </div>

                </Slide>

                <template #addons>
                    <Pagination />
                    <Navigation />
                </template>
            </Carousel>
            </div>
        </div>
    </AuthenticatedLayout>
</template>

<script>
// If you are using PurgeCSS, make sure to whitelist the carousel CSS classes
import 'vue3-carousel/dist/carousel.css'
import { Carousel, Slide, Pagination, Navigation } from 'vue3-carousel'

export default {
    name: 'App',
    components: {
        Carousel,
        Slide,
        Pagination,
        Navigation,
    },
}
</script>
