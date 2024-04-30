<script setup>
import { Head, Link } from '@inertiajs/vue3';
import 'bootstrap/dist/css/bootstrap.css';

defineProps({
    canLogin: {
        type: Boolean,
    },
    canRegister: {
        type: Boolean,
    },
    laravelVersion: {
        type: String,
        required: true,
    },
    phpVersion: {
        type: String,
        required: true,
    },
});

function handleImageError() {
    document.getElementById('screenshot-container')?.classList.add('!hidden');
    document.getElementById('docs-card')?.classList.add('!row-span-1');
    document.getElementById('docs-card-content')?.classList.add('!flex-row');
    document.getElementById('background')?.classList.add('!hidden');
}
</script>

<template>
    <Head title="Welcome" />
    <div class="min-h-screen bg-gray-100" style="background-image: linear-gradient(rgba(255, 255, 255, 0.8), rgba(255, 255, 255, 0.7)), url('/images/fondoPagina.jpg'); background-size: cover; background-position: center center; position: relative;">

        <div class="text-center pt-5">
            <h4>Benvingut a Magic Online Market</h4>
        </div>

        <img
            id="background"
            class="absolute left-1/2 top-1/3 transform -translate-x-1/2 -translate-y-1/2 max-w-[700px]"
            style="height: 400px;"
            src="images/MMO_logo.png"
        />

        <div class="relative w-full px-6">

            <nav v-if="canLogin" class="flex justify-end">
                <Link
                    v-if="$page.props.auth.user"
                    :href="route('dashboard')"
                    class="rounded-md px-5 py-3 text-black ring-1 ring-transparent transition hover:text-black/70 focus:outline-none focus-visible:ring-[#FF2D20] dark:text-white dark:hover:text-white/80 dark:focus-visible:ring-white"
                >
                    Dashboard
                </Link>

                <template v-else>
                    <Link
                        :href="route('login')"
                        class="rounded-md px-5 py-3 text-black ring-1 ring-transparent transition hover:text-black/70 focus:outline-none focus-visible:ring-[#FF2D20] dark:text-white dark:hover:text-white/80 dark:focus-visible:ring-white"
                    >
                        Log in
                    </Link>

                    <Link
                        v-if="canRegister"
                        :href="route('register')"
                        class="rounded-md px-5 py-3 text-black ring-1 ring-transparent transition hover:text-black/70 focus:outline-none focus-visible:ring-[#FF2D20] dark:text-white dark:hover:text-white/80 dark:focus-visible:ring-white"
                    >
                        Register
                    </Link>
                </template>
            </nav>

        </div>

        <div class="flex flex-col h-screen justify-between">

            <div class="text-center text-base mt-96">

                <p> Pàgina per a la compra i venta de producte de cartes coleccionables.</p>
                <p>Podras crear baralles amb la nostra base de dades.      </p>
                <p> I inscriure't en els diversos tornejos que organitzen les nostres tendes.</p>
            </div>
        </div>

    </div>
</template>

<style>
nav {
    background-color: rgb(0, 214, 153);
    width: 100%;
}
</style>
