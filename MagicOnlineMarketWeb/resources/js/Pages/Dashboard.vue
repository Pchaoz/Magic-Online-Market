<script setup>
import AuthenticatedLayout from '@/Layouts/AuthenticatedLayout.vue';
import 'bootstrap/dist/css/bootstrap.css';
import { Head } from '@inertiajs/vue3';
</script>

<template>
    <Head title="Pàgina Principal" />

    <AuthenticatedLayout>
        <div>
            <div class="flex justify-center items-center">
            <h2 class=" font-semibold text-xl text-gray-800 leading-tight">Noticias</h2>
            </div>
            <div class="flex justify-center items-center">
            <Carousel v-bind="settings" :breakpoints="breakpoints" class="w-50">
                <Slide v-for="(slide, index) in slides" :key="index">
                    <div class="carousel__item">
                        <a :href="getUrlForSlide(index)"> <img :src="getImageForSlide(index)" alt="Slide {{ index + 1 }}" /></a>
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
    data() {
        return {
            slides: [
                // Add your image URLs here
                '/images/noticias/karlov.jpg',
                '/images/noticias/thunder.jpg',
                '/images/noticias/moderhorizons.jpg',
                // ... more images ...
            ],
            urls: [
                // Add your image URLs here
                '/images/noticias/karlov1.jpg',
                '/images/noticias/thunder1.jpg',
                '/images/noticias/moderhorizons1.jpg',
                // ... more URLs ...
            ]
        };
    },
    methods: {
        getImageForSlide(index) {
            // Return the image URL for the given slide index
            return this.slides[index];
        },
        getUrlForSlide(index) {
            // Return the image URL for the given slide index
            return this.urls[index];
        },
    }
}
</script>
