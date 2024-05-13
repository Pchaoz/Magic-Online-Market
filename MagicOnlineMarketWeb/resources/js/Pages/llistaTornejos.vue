<script setup>

import AuthenticatedLayout from "@/Layouts/AuthenticatedLayout.vue";
import {ref} from "vue";
import {useForm} from "@inertiajs/vue3";
import InputLabel from "@/Components/InputLabel.vue";
import Modal from "@/Components/Modal.vue";

defineProps({
    tornejos: {
        type: Array(String),
    }
});
let showModal = ref(false);
let showModalEliminacio = ref(false);
let showModalCreacio = ref(false);
let showModalCreacioConfirmacio=ref(false);
let showModalModificacio = ref(false);
let showModalModificacioConfirmacio=ref(false);

const form = useForm({
    idTorneig: "",
    participants:0,
    min:0,
    max:0,
    idTipus:"",
    ronda:0,
    horaInici:null,



});

//crear Torneig
const abrirModalCreacio = () =>{
    form.idTorneig="";
    form.participants=0;
    form.min=0;
    form.max=0;
    form.idTipus="";
    form.ronda=0;
    form.formhoraInici=null;
    showModalCreacio.value=true;
}

const cerrarModalCreacio = () =>{
    showModalCreacio.value=false;
    showModalCreacioConfirmacio.value=false;
}


</script>

<template>
    <AuthenticatedLayout>
        <div class="d-flex justify-content-center m-3 ">
            <h2>Llistat de Tornejos</h2>
        </div>
        <div class="d-flex justify-content-center m-3 ">
            <table class="table table-striped my-table w-100 ">
                <thead>
                <tr>
                    <th>Participants</th>
                    <th>Mínim</th>
                    <th>Màxim</th>
                    <th>Organitzador</th>
                    <th>Tipus Torneig</th>
                    <th>Rondes</th>
                    <th>Estat</th>
                    <th>Hora Inici</th>
                    <th></th>
                    <th v-if=" $page.props.auth.user.idRol==1 ||$page.props.auth.user.idRol==4 || $page.props.auth.user.idRol==5"></th>
                    <th v-if=" $page.props.auth.user.idRol==1 ||$page.props.auth.user.idRol==4 || $page.props.auth.user.idRol==5"></th>

                </tr>
                </thead>
                <tbody>
                <tr v-for="torneig in tornejos" :key="torneig.id"  >
                    <td>{{torneig.num}}</td>
                    <td>{{ torneig.min }}</td>
                    <td>{{ torneig.max }}</td>
                    <td>{{ torneig.nick }}</td>
                    <td>{{ torneig.descripcio }}</td>
                    <td>{{ torneig.rondes }}</td>
                    <td>{{ torneig.estat }}</td>
                    <td>{{ torneig.inici }}</td>
                    <td>
                        <button  class="btn btn-success rounded-pill"
                                 @click="abrirModalMod(baralla)">Inscripció</button>
                    </td>
                    <td v-if=" $page.props.auth.user.idRol==1 ||$page.props.auth.user.idRol==4 || $page.props.auth.user.idRol==5">
                        <button  class="btn btn-success rounded-pill" v-if="$page.props.auth.user.idRol==1 ||$page.props.auth.user.idUsuari===baralla.idUsuari"
                                 @click="abrirModalMod(baralla)">Modificar</button>
                    </td>
                    <td v-if=" $page.props.auth.user.idRol==1 ||$page.props.auth.user.idRol==4 || $page.props.auth.user.idRol==5">
                        <button  class="btn btn-danger rounded-pill" v-if="$page.props.auth.user.idRol==1 ||$page.props.auth.user.idUsuari===baralla.idUsuari"
                                 @click="abrirModalConfirmacionEliminacio(baralla.idBaralla)">Eliminar</button>
                    </td>
                </tr>
                </tbody>
            </table>
        </div>
        <div class="d-flex justify-content-center m-3 ">
            <b-button class="btn btn-success rounded-pill" style="width: 200px;" @click="abrirModalCreacio"
                      v-if=" $page.props.auth.user.idRol==1 ||$page.props.auth.user.idRol==4 || $page.props.auth.user.idRol==5">Crear Torneig</b-button>
        </div>

        <Modal :show="showModalCreacio" maxWidth="2xl" closeable @close="cerrarModalCreacio" >
            <div class="modal-content w-100">
                <div class="d-flex justify-content-center m-3 ">
                    
                </div>
                <div class="d-flex justify-content-center m-3 ">
                    <button type="button" class="btn btn-success ml-5"
                            @click="crearTorneig">Crear</button>
                    <button type="button" class="btn btn-danger ml-5"
                            @click="cerrarModalCreacio">Cancelar</button>
                </div>
            </div>
        </Modal>

        <Modal :show="showModalCreacioConfirmacio" maxWidth="2xl" closeable @close="cerrarModalCreacio" >
            <div class="modal-content w-100">
                <div class="d-flex justify-content-center m-3 ">
                    <p>Torneig Creat</p>
                </div>
            </div>
        </Modal>
    </AuthenticatedLayout>
</template>

<style scoped>
.my-table td, .my-table th {
    background-color: rgba(0,214,153,0.7) !important;
    text-align: center;
    vertical-align: middle;
}
</style>
