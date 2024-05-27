<script setup>
import ApplicationLogo from '@/Components/ApplicationLogo.vue';
import { Link } from '@inertiajs/vue3';
</script>

<template>

    <div class="min-h-screen flex flex-col sm:justify-center items-center pt-5 sm:pt-0 bg-gray-100" style="background-image: linear-gradient(rgba(255, 255, 255, 0.8), rgba(255, 255, 255, 0.7)), url('/images/fondoPagina.jpg'); background-size: cover; background-position: center center; position: relative;">
    <div>
            <Link href="/">
                <ApplicationLogo class="w-20 h-20 fill-current text-gray-500" style="width: 250px; height: 250px;"/>
            </Link>
        </div>

        <div
            class="w-full sm:max-w-md mt-6 px-6 py-4 bg-white shadow-md overflow-hidden sm:rounded-lg"
        >
            <slot />
        </div>
    </div>

</template>
