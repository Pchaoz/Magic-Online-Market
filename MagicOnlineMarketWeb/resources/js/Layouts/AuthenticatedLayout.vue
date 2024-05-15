<script setup>
import { ref } from 'vue';
import 'bootstrap/dist/css/bootstrap.css';
import Dropdown from '@/Components/Dropdown.vue';
import DropdownLink from '@/Components/DropdownLink.vue';
import ResponsiveNavLink from '@/Components/ResponsiveNavLink.vue';
import { Link } from '@inertiajs/vue3';
import 'bootstrap/dist/js/bootstrap.bundle';
import Carret from "@/Pages/Carret.vue";

const showingNavigationDropdown = ref(false);

</script>

<template>
    <div>
        <div class="min-h-screen bg-gray-100" style="background-image: linear-gradient(rgba(255, 255, 255, 0.8), rgba(255, 255, 255, 0.7)), url('/images/fondoPagina.jpg'); background-size: cover; background-position: center center;  position: relative;">            <nav class="border-b border-gray-100">
                <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
                    <div class="flex justify-between h-16">
                        <div class="flex">
                            <div class="shrink-0 flex items-center">
                                <Link :href="route('dashboard')">
                                    <img class="block h-9 w-auto fill-current text-gray-800"  src='/images/MMO_logo.png' alt="Laravel Logo" style="width: 80px; height: 80px;">

                                </Link>
                            </div>

                            <div class="space-x-3 sm:-my-px sm:ms-10 sm:flex">
                                <div class="hidden sm:flex sm:items-center sm:ms-6">
                                    <div class="ms-3 relative">
                                        <Dropdown align="left" width="48">
                                            <template #trigger>
                                        <span class="inline-flex rounded-md">
                                             <button
                                                 type="button"
                                                 class="inline-flex items-center px-3 py-2 border border-transparent text-sm leading-4 font-medium rounded-md text-gray-500 bg-white hover:text-gray-700 focus:outline-none transition ease-in-out duration-150"
                                             >
                                                 Comandes
                                                  <svg
                                                      class="ms-2 -me-0.5 h-4 w-4"
                                                      xmlns="http://www.w3.org/2000/svg"
                                                      viewBox="0 0 20 20"
                                                      fill="currentColor"
                                                  >
                                                    <path
                                                        fill-rule="evenodd"
                                                        d="M5.293 7.293a1 1 0 011.414 0L10 10.586l3.293-3.293a1 1 0 111.414 1.414l-4 4a1 1 0 01-1.414 0l-4-4a1 1 0 010-1.414z"
                                                        clip-rule="evenodd"
                                                    />
                                                </svg>
                                               </button>
                                        </span>
                                            </template>
                                            <template #content>
                                                <DropdownLink v-if="$page.props.auth.user.idRol==1||$page.props.auth.user.idRol==2" :href="route('listComandes')"> Totes les Comandes </DropdownLink>
                                                <DropdownLink  :href="route('listComandesCompres')">Les meves Compres </DropdownLink>
                                                <DropdownLink v-if="$page.props.auth.user.idRol==4||$page.props.auth.user.idRol==5 ||$page.props.auth.user.idRol==1" :href="route('listComandesVendes')">Les meves Vendes </DropdownLink>
                                            </template>
                                        </Dropdown>
                                    </div>
                                </div>
                                <div class="hidden sm:flex sm:items-center sm:ms-6">
                                    <div class="ms-3 relative">
                                        <Dropdown align="left" width="48">
                                            <template #trigger>
                                        <span class="inline-flex rounded-md">
                                             <button
                                                 type="button"
                                                 class="inline-flex items-center px-3 py-2 border border-transparent text-sm leading-4 font-medium rounded-md text-gray-500 bg-white hover:text-gray-700 focus:outline-none transition ease-in-out duration-150"
                                             >
                                                Productes
                                                  <svg
                                                      class="ms-2 -me-0.5 h-4 w-4"
                                                      xmlns="http://www.w3.org/2000/svg"
                                                      viewBox="0 0 20 20"
                                                      fill="currentColor"
                                                  >
                                                    <path
                                                        fill-rule="evenodd"
                                                        d="M5.293 7.293a1 1 0 011.414 0L10 10.586l3.293-3.293a1 1 0 111.414 1.414l-4 4a1 1 0 01-1.414 0l-4-4a1 1 0 010-1.414z"
                                                        clip-rule="evenodd"
                                                    />
                                                </svg>
                                               </button>
                                        </span>
                                            </template>
                                            <template #content>
                                                <DropdownLink :href="route('ListProductes')"> Tots els Productes </DropdownLink>
                                                <DropdownLink :href="route('ListArticles')"> Tots els Articles </DropdownLink>
                                            </template>
                                        </Dropdown>
                                    </div>
                                </div>
                                <div class="hidden sm:flex sm:items-center sm:ms-6">
                                    <div class="ms-3 relative">
                                        <Dropdown align="left" width="48">
                                            <template #trigger>
                                        <span class="inline-flex rounded-md">
                                             <button
                                                 type="button"
                                                 class="inline-flex items-center px-3 py-2 border border-transparent text-sm leading-4 font-medium rounded-md text-gray-500 bg-white hover:text-gray-700 focus:outline-none transition ease-in-out duration-150"
                                             >
                                                Tornejos
                                                  <svg
                                                      class="ms-2 -me-0.5 h-4 w-4"
                                                      xmlns="http://www.w3.org/2000/svg"
                                                      viewBox="0 0 20 20"
                                                      fill="currentColor"
                                                  >
                                                    <path
                                                        fill-rule="evenodd"
                                                        d="M5.293 7.293a1 1 0 011.414 0L10 10.586l3.293-3.293a1 1 0 111.414 1.414l-4 4a1 1 0 01-1.414 0l-4-4a1 1 0 010-1.414z"
                                                        clip-rule="evenodd"
                                                    />
                                                </svg>
                                               </button>
                                        </span>
                                            </template>
                                            <template #content>
                                                <DropdownLink> Crear Torneig</DropdownLink>
                                                <DropdownLink> Veure Tornejos</DropdownLink>
                                                <DropdownLink> Els meus Tornejos</DropdownLink>
                                                <DropdownLink> Modificar Tornejos</DropdownLink>

                                            </template>
                                        </Dropdown>
                                    </div>
                                </div>
                                <div class="hidden sm:flex sm:items-center sm:ms-6">
                                    <div class="ms-3 relative">
                                        <Dropdown align="left" width="48">
                                            <template #trigger>
                                        <span class="inline-flex rounded-md">
                                             <button
                                                 type="button"
                                                 class="inline-flex items-center px-3 py-2 border border-transparent text-sm leading-4 font-medium rounded-md text-gray-500 bg-white hover:text-gray-700 focus:outline-none transition ease-in-out duration-150"
                                             >
                                                Baralles
                                                  <svg
                                                      class="ms-2 -me-0.5 h-4 w-4"
                                                      xmlns="http://www.w3.org/2000/svg"
                                                      viewBox="0 0 20 20"
                                                      fill="currentColor"
                                                  >
                                                    <path
                                                        fill-rule="evenodd"
                                                        d="M5.293 7.293a1 1 0 011.414 0L10 10.586l3.293-3.293a1 1 0 111.414 1.414l-4 4a1 1 0 01-1.414 0l-4-4a1 1 0 010-1.414z"
                                                        clip-rule="evenodd"
                                                    />
                                                </svg>
                                               </button>
                                        </span>
                                            </template>
                                            <template #content>
                                                <DropdownLink :href="route('ListBarallesMeves')">Les meves Baralles</DropdownLink>
                                                <DropdownLink :href="route('ListBaralles')">Baralles públiques </DropdownLink>
                                                <DropdownLink :href="route('getAllCartes')"> Veure cartes</DropdownLink>
                                            </template>
                                        </Dropdown>
                                    </div>
                                </div>
                                <div class="hidden sm:flex sm:items-center sm:ms-6">
                                    <div class="ms-3 relative">
                                        <Link :href="route('listNoticies')">
                                            <button
                                                class="inline-flex items-center px-3 py-2 border border-transparent text-sm leading-4 font-medium rounded-md text-gray-500 bg-white hover:text-gray-700 focus:outline-none transition ease-in-out duration-150"
                                            >
                                                Noticies
                                            </button>
                                        </Link>
                                    </div>
                                </div>



                                <div class="hidden sm:flex sm:items-center sm:ms-6"  v-if="$page.props.auth.user.idRol==1 ||$page.props.auth.user.idRol==2 ">
                                    <div class="ms-3 relative">
                                        <Dropdown align="left" width="48">
                                            <template #trigger>
                                        <span class="inline-flex rounded-md">
                                             <button
                                                 type="button"
                                                 class="inline-flex items-center px-3 py-2 border border-transparent text-sm leading-4 font-medium rounded-md text-gray-500 bg-white hover:text-gray-700 focus:outline-none transition ease-in-out duration-150"
                                             >
                                                Administrador
                                                  <svg
                                                      class="ms-2 -me-0.5 h-4 w-4"
                                                      xmlns="http://www.w3.org/2000/svg"
                                                      viewBox="0 0 20 20"
                                                      fill="currentColor"
                                                  >
                                                    <path
                                                        fill-rule="evenodd"
                                                        d="M5.293 7.293a1 1 0 011.414 0L10 10.586l3.293-3.293a1 1 0 111.414 1.414l-4 4a1 1 0 01-1.414 0l-4-4a1 1 0 010-1.414z"
                                                        clip-rule="evenodd"
                                                    />
                                                </svg>
                                               </button>
                                        </span>
                                            </template>
                                            <template #content>
                                                <DropdownLink v-if="$page.props.auth.user.idRol==1" :href="route('ListRols')"> Administrar Rols </DropdownLink>
                                                <DropdownLink v-if="$page.props.auth.user.idRol==1" :href="route('getUsersForm')"> Administrar Usuaris </DropdownLink>
                                                <DropdownLink  :href="route('ListExpansions')"> Administrar Expansions </DropdownLink>
                                                <DropdownLink  :href="route('ListCategProductes')"> Administrar Categories de Productes </DropdownLink>
                                                <DropdownLink  :href="route('formulariCartes')"> Crear Cartes </DropdownLink>

                                            </template>
                                        </Dropdown>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="hidden sm:flex sm:items-center sm:ms-6">

                            <div class="ms-3 relative">
                                <Dropdown align="right" width="48">
                                    <template #trigger>
                                        <span class="inline-flex rounded-md">
                                            <button
                                                type="button"
                                                class="inline-flex items-center px-3 py-2 border border-transparent text-sm leading-4 font-medium rounded-md text-gray-500 bg-white hover:text-gray-700 focus:outline-none transition ease-in-out duration-150"
                                            >
                                                {{ $page.props.auth.user.name }}

                                                <svg
                                                    class="ms-2 -me-0.5 h-4 w-4"
                                                    xmlns="http://www.w3.org/2000/svg"
                                                    viewBox="0 0 20 20"
                                                    fill="currentColor"
                                                >
                                                    <path
                                                        fill-rule="evenodd"
                                                        d="M5.293 7.293a1 1 0 011.414 0L10 10.586l3.293-3.293a1 1 0 111.414 1.414l-4 4a1 1 0 01-1.414 0l-4-4a1 1 0 010-1.414z"
                                                        clip-rule="evenodd"
                                                    />
                                                </svg>
                                            </button>
                                        </span>
                                    </template>

                                    <template #content>
                                        <DropdownLink :href="route('profile.edit')"> Profile </DropdownLink>
                                        <DropdownLink :href="route('logout')" method="post" as="button">
                                            Log Out
                                        </DropdownLink>
                                    </template>
                                </Dropdown>
                            </div>
                        </div>

                        <div class="hidden sm:flex sm:items-center sm:ms-6">
                            <Carret>
                            </Carret>
                        </div>
                        <div class="-me-2 flex items-center sm:hidden">
                            <button
                                @click="showingNavigationDropdown = !showingNavigationDropdown"
                                class="inline-flex items-center justify-center p-2 rounded-md text-gray-400 hover:text-gray-500 hover:bg-gray-100 focus:outline-none focus:bg-gray-100 focus:text-gray-500 transition duration-150 ease-in-out"
                            >
                                <svg class="h-6 w-6" stroke="currentColor" fill="none" viewBox="0 0 24 24">
                                    <path
                                        :class="{
                                            hidden: showingNavigationDropdown,
                                            'inline-flex': !showingNavigationDropdown,
                                        }"
                                        stroke-linecap="round"
                                        stroke-linejoin="round"
                                        stroke-width="2"
                                        d="M4 6h16M4 12h16M4 18h16"
                                    />
                                    <path
                                        :class="{
                                            hidden: !showingNavigationDropdown,
                                            'inline-flex': showingNavigationDropdown,
                                        }"
                                        stroke-linecap="round"
                                        stroke-linejoin="round"
                                        stroke-width="2"
                                        d="M6 18L18 6M6 6l12 12"
                                    />
                                </svg>
                            </button>
                        </div>
                    </div>
                </div>

                <!-- Responsive Navigation Menu -->
                <div
                    :class="{ block: showingNavigationDropdown, hidden: !showingNavigationDropdown }"
                    class="sm:hidden"
                >
                    <div class="pt-2 pb-3 space-y-1">
                        <ResponsiveNavLink :href="route('dashboard')" :active="route().current('dashboard')">
                            Dashboard
                        </ResponsiveNavLink>
                    </div>

                    <!-- Responsive Settings Options -->
                    <div class="pt-4 pb-1 border-t border-gray-200">
                        <div class="px-4">
                            <div class="font-medium text-base text-gray-800">
                                {{ $page.props.auth.user.name }}
                            </div>
                            <div class="font-medium text-sm text-gray-500">{{ $page.props.auth.user.email }}</div>
                        </div>

                        <div class="mt-3 space-y-1">
                            <ResponsiveNavLink :href="route('profile.edit')"> Profile </ResponsiveNavLink>
                            <ResponsiveNavLink :href="route('logout')" method="post" as="button">
                                Log Out
                            </ResponsiveNavLink>
                        </div>
                    </div>
                </div>
            </nav>

            <header class="bg-white shadow" v-if="$slots.header">
                <div class="max-w-7xl mx-auto py-6 px-4 sm:px-6 lg:px-8">
                    <slot name="header" />
                </div>
            </header>


            <main>
                <slot />
            </main>
        </div>
    </div>
</template>

<style>
nav {
    background-color: rgb(0, 214, 153);

}
</style>
