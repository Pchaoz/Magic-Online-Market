<script setup>

import AuthenticatedLayout from "@/Layouts/AuthenticatedLayout.vue";
import InputLabel from "@/Components/InputLabel.vue";
import Modal from "@/Components/Modal.vue";
import {ref} from "vue";
import {useForm} from "@inertiajs/vue3";


defineProps({
    tipusEnviaments: {
        type: Array(String),
    }
});


const formTipusEnviament= useForm({
    nom: null,
    id:null,
    preu:0,
})

let showModal = ref(false);
let showModalEliminacio = ref(false);
let showModalEliminacioConfirmacio= ref(false);
let showModalCreacio=ref(false);
let showModalCreacioConfirmacio=ref(false);
let showModalModificacio=ref(false);
let showModalModificacioConfirmacio=ref(false);

//eliminacio
const abrirModalEliminacio =  (tipEnv) => {

    formTipusEnviament.id=tipEnv.idTipusEnviament;
    showModalEliminacio.value=true;

}




</script>

<template>
    <AuthenticatedLayout>
        <div class="d-flex justify-content-center m-3 ">
            <h2>Administrar Tipus Enviaments</h2>
        </div>
        <div class="d-flex justify-content-center m-3 ">
            <table class="table table-striped my-table w-25 ">
                <thead>
                <tr>
                    <th>Nom</th>
                    <th>Preu</th>
                    <th></th>
                    <th></th>
                </tr>
                </thead>
                <tbody>
                <tr v-for="tipusEnviament in tipusEnviaments" :key="tipusEnviament.id">
                    <td>{{tipusEnviament.nom}}</td>
                    <td>{{tipusEnviament.preu}}</td>
                    <td>
                        <button  class="btn btn-success rounded-pill"
                                 @click="abrirModalMod(tipusEnviament)">Modificar</button>

                    </td>
                    <td>
                        <button  class="btn btn-danger rounded-pill"
                                 @click="abrirModalEliminacio(tipusEnviament)">Eliminar</button>

                    </td>
                </tr>
                </tbody>
            </table>


        </div>
        <div class="d-flex justify-content-center m-3 ">
            <button  class="btn btn-success"
                     @click="abrirModalCreacio()">Crear Tipus Enviament</button>
        </div>
    </AuthenticatedLayout>
</template>

<style scoped>

.my-table td, .my-table th {
    background-color: rgba(0,214,153,0.7) !important;
    text-align: center;
    vertical-align: middle;
}

</style>
