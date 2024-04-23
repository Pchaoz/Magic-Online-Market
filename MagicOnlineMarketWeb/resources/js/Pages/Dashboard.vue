<script setup>
import AuthenticatedLayout from '@/Layouts/AuthenticatedLayout.vue';
import 'bootstrap/dist/css/bootstrap.css';
import { Head } from '@inertiajs/vue3';
</script>

<template>
    <Head title="Pàgina Principal" />

    <AuthenticatedLayout>
        <template #header>
            <div class="flex justify-center items-center">
            <h2 class=" font-semibold text-xl text-gray-800 leading-tight">Noticias</h2>
            </div>

        <div id="carouselExampleControls" class="carousel slide" data-ride="carousel">
            <div class="carousel-inner">
                <div class="carousel-item active">
                    <img class="d-block w-100" src='/images/noticias/karlov.jpg' alt="Primera diapositiva">
                </div>
                <div class="carousel-item">
                    <img class="d-block w-100" src='/images/noticias/karlov.jpg' alt="Segunda diapositiva">
                </div>
                <div class="carousel-item">
                    <img class="d-block w-100" src="" alt="Tercera diapositiva">
                </div>
            </div>
            <a class="carousel-control-prev" href="#carouselExampleControls" role="button" data-slide="prev">
                <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                <span class="sr-only">Anterior</span>
            </a>
            <a class="carousel-control-next" href="#carouselExampleControls" role="button" data-slide="next">
                <span class="carousel-control-next-icon" aria-hidden="true"></span>
                <span class="sr-only">Siguiente</span>
            </a>
        </div>
        </template>
    </AuthenticatedLayout>
</template>
