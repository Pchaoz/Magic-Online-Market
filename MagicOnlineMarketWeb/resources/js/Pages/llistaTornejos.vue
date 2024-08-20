<script setup>

import AuthenticatedLayout from "@/Layouts/AuthenticatedLayout.vue";
import {ref} from "vue";
import InputLabel from "@/Components/InputLabel.vue";
import Modal from "@/Components/Modal.vue";
import { Form as VForm, Field as VField, defineRule, ErrorMessage } from 'vee-validate';
import {required} from "@vee-validate/rules";
import {useForm} from "@inertiajs/vue3";

defineRule('required', required);

defineProps({
    tornejos: {
        type: Array(String),
    },
    tipusTornejos:{
        type: Array(String),
    },
});
let showModal = ref(false);
let showModalCreacio = ref(false);
let showModalCreacioConfirmacio=ref(false);
let showModalModificacio = ref(false);
let showModalModificacioConfirmacio=ref(false);
let showModalQuantitatIncorrecta=ref(false);
let showModalEliminacio = ref(false);
let showModalEliminacioConfirmacio = ref(false);

const form = useForm({
    idTorneig: "",
    nom:"",
    participants:0,
    min:0,
    max:0,
    idTipus:"",
    ronda:0,
    dataHoraInici:null,
});

//crear Torneig
const abrirModalCreacio = () =>{
    form.idTorneig="";
    form.nom="";
    form.participants=0;
    form.min=2;
    form.max=2;
    form.idTipus="";
    form.ronda=0;
    form.dataHoraInici=null;
    showModalCreacio.value=true;
}

const cerrarModalCreacio = () =>{
    showModalCreacio.value=false;
    showModalCreacioConfirmacio.value=false;
}


const crearTorneig = () =>{
    if(form.max <2||form.min <2||form.max<form.min){
        cerrarModalCreacio();
        abrirModalQuantitatIncorrecta();
    }else {
        form.post('crearTorneig');
        confirmarCreacio();
    }
}

const confirmarCreacio = () =>{
    showModalCreacio.value=false;
    showModalCreacioConfirmacio.value=true;
}

//Modificació de tornejos
const cerrarModalModificacio = () =>{
    showModalModificacio.value=false;
    showModalModificacioConfirmacio.value=false;
}

const abrirModalModificacio = (torneig) =>{
    form.idTorneig=torneig.idTorneig;
    form.nom=torneig.nomTorneig;
    form.participants=torneig.num;
    form.min=torneig.min;
    form.max=torneig.max;
    form.idTipus=torneig.idTipusTorneig;
    form.dataHoraInici=torneig.inici;
    showModalModificacio.value=true;
}

const modificarTorneig = () =>{
    if(form.max <2||form.min <2||form.max<form.min){
        cerrarModalModificacio();
        abrirModalQuantitatIncorrecta();
    }else {
        form.post('modificarTorneig');
        confirmarModificacio();
    }
}

const confirmarModificacio = () =>{
    showModalModificacio.value=false;
    showModalModificacioConfirmacio.value=true;
}

//Eliminació de tornejos
const cerrarModalEliminacio= () =>{
    showModalEliminacioConfirmacio.value=false;
    showModalEliminacio.value=false;
}

const abrirModalConfirmacionEliminacio = (id) =>{
    form.idTorneig=id;
    showModalEliminacio.value=true;
}

const eliminarTorneig = () =>{
        form.post('eliminarTorneig');
        confirmarEliminacio();
}

const confirmarEliminacio = () =>{
    showModalEliminacio.value=false;
    showModalEliminacioConfirmacio.value=true;
}



const abrirModalQuantitatIncorrecta = () => {
    showModalQuantitatIncorrecta.value =true;
}

const cerrarModalQuantitatIncorrecta=()=>{
    showModalQuantitatIncorrecta.value =false;
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
                    <th>Nom Torneig</th>
                    <th>Participants</th>
                    <th>Mínim</th>
                    <th>Màxim</th>
                    <th>Organitzador</th>
                    <th>Tipus Torneig</th>
                    <th>Estat</th>
                    <th>Hora Inici</th>
                    <th></th>
                    <th v-if=" $page.props.auth.user.idRol==1 ||$page.props.auth.user.idRol==4 || $page.props.auth.user.idRol==5"></th>
                    <th v-if=" $page.props.auth.user.idRol==1 ||$page.props.auth.user.idRol==4 || $page.props.auth.user.idRol==5"></th>

                </tr>
                </thead>
                <tbody>
                <tr v-for="torneig in tornejos" :key="torneig.id"  >
                    <td>{{torneig.nomTorneig}}</td>
                    <td>{{torneig.num}}</td>
                    <td>{{ torneig.min }}</td>
                    <td>{{ torneig.max }}</td>
                    <td>{{ torneig.nick }}</td>
                    <td>{{ torneig.descripcio }}</td>
                    <td>{{ torneig.estat }}</td>
                    <td>{{ torneig.inici }}</td>
                    <td>
                        <button v-if="torneig.estat=='En inscripció'" class="btn btn-success rounded-pill"
                                 @click="abrirModalMod(baralla)">Inscripció</button>
                    </td>
                    <td >
                        <button v-if=" ($page.props.auth.user.idRol==1 ||$page.props.auth.user.idRol==4 || $page.props.auth.user.idRol==5)&&
                                (torneig.estat=='En inscripció'||torneig.estat=='En creació')" class="btn btn-success rounded-pill"
                                 @click="abrirModalModificacio(torneig)">Modificar</button>
                    </td>
                    <td>
                        <button  class="btn btn-danger rounded-pill" v-if=" ($page.props.auth.user.idRol==1 ||$page.props.auth.user.idRol==4 || $page.props.auth.user.idRol==5) &&
                                 (torneig.estat=='En creació'||torneig.estat=='En inscripció')"
                                 @click="abrirModalConfirmacionEliminacio(torneig.idTorneig)">Eliminar</button>
                    </td>
                </tr>
                </tbody>
            </table>
        </div>
        <div class="d-flex justify-content-center m-3 ">
            <b-button class="btn btn-success rounded-pill" style="width: 200px;" @click="abrirModalCreacio"
                      v-if=" $page.props.auth.user.idRol==1 ||$page.props.auth.user.idRol==4 || $page.props.auth.user.idRol==5">Crear Torneig</b-button>
        </div>

        <Modal :show="showModalCreacio" maxWidth="2xl" closeable @close="cerrarModalCreacio">
            <VForm v-slot="{ errors, invalid }" @submit="crearTorneig" class="w-100 rounded">
                <!-- Nombre del Torneig -->
                <div class="d-flex flex-column justify-content-center m-3">
                    <InputLabel for="nom" value="Nom Torneig" />
                    <VField
                        id="nom"
                        name="nom"
                        type="text"
                        v-model="form.nom"
                        rules="required"
                        autofocus
                        autocomplete="nom"
                        class="mt-1 block w-full"
                        maxlength="40"
                        style="color: black;"
                    />
                    <ErrorMessage name="nom" class="text-danger mt-1" />
                </div>

                <!-- Màxim jugadors -->
                <div class="d-flex flex-column justify-content-center m-3">
                    <InputLabel for="max" value="Màxim jugadors:" />
                    <VField
                        id="max"
                        name="max"
                        type="number"
                        v-model="form.max"
                        :min="2"
                        step="1"
                        class="mt-1 block w-full"
                        style="color: black;"
                    />
                    <ErrorMessage name="max" class="text-danger mt-1" />
                </div>

                <!-- Mínim jugadors -->
                <div class="d-flex flex-column justify-content-center m-3">
                    <InputLabel for="min" value="Mínim jugadors (per defecte 2):" />
                    <VField
                        id="min"
                        name="min"
                        type="number"
                        :min="2"
                        step="1"
                        v-model="form.min"
                        style="color: black;"
                    />
                    <ErrorMessage name="min" class="text-danger mt-1" />
                </div>

                <!-- Tipus Torneig -->
                <div class="d-flex flex-column justify-content-center m-3">
                    <InputLabel for="idTipus" value="Tipus Torneig" />
                    <VField
                        id="idTipus"
                        name="idTipus"
                        as="select"
                        v-model="form.idTipus"
                        rules="required"
                        class="mt-1 block w-full"
                        style="color: black;"
                    >
                        <option v-for="tipusTorneig in tipusTornejos" :key="tipusTorneig.idTipus" :value="tipusTorneig.idTipus">
                            {{ tipusTorneig.descripcio }}
                        </option>
                    </VField>
                    <ErrorMessage name="idTipus" class="text-danger mt-1" />
                </div>

                <!-- Data i Hora d'Inici -->
                <div class="d-flex flex-column justify-content-center m-3">
                    <InputLabel for="dataHoraInici" value="Data i Hora d'Inici:" />
                    <VField
                        id="dataHoraInici"
                        name="dataHoraInici"
                        type="datetime-local"
                        v-model="form.dataHoraInici"
                        rules="required"
                        class="mt-1 block w-full"
                        style="color: black;"
                    />
                    <ErrorMessage name="dataHoraInici" class="text-danger mt-1" />
                </div>

                <!-- Botones Crear y Cancelar -->
                <div class="d-flex justify-content-center m-3">
                    <button
                        type="submit"
                        class="btn btn-success ml-5"
                        @click="validate()"
                        :disabled="invalid"
                    >
                        Crear
                    </button>
                    <button type="button" class="btn btn-danger ml-5" @click="cerrarModalCreacio">
                        Cancelar
                    </button>
                </div>
            </VForm>
        </Modal>
        <Modal :show="showModalCreacioConfirmacio" maxWidth="2xl" closeable @close="cerrarModalCreacio" >
            <div class="modal-content w-100">
                <div class="d-flex justify-content-center m-3 ">
                    <p>Torneig Creat</p>
                </div>
            </div>
        </Modal>

        <Modal :show="showModalModificacio" maxWidth="2xl" closeable @close="cerrarModalModificacio">
            <VForm v-slot="{ errors, invalid }" @submit="modificarTorneig" class="w-100 rounded">
                <!-- Nombre del Torneig -->
                <div class="d-flex flex-column justify-content-center m-3">
                    <InputLabel for="nom" value="Nom Torneig" />
                    <VField
                        id="nom"
                        name="nom"
                        type="text"
                        v-model="form.nom"
                        rules="required"
                        autofocus
                        autocomplete="nom"
                        class="mt-1 block w-full"
                        maxlength="40"
                        style="color: black;"
                    />
                    <ErrorMessage name="nom" class="text-danger mt-1" />
                </div>

                <!-- Màxim jugadors -->
                <div class="d-flex flex-column justify-content-center m-3">
                    <InputLabel for="max" value="Màxim jugadors:" />
                    <VField
                        id="max"
                        name="max"
                        type="number"
                        v-model="form.max"
                        :min="2"
                        step="1"
                        class="mt-1 block w-full"
                        style="color: black;"
                    />
                    <ErrorMessage name="max" class="text-danger mt-1" />
                </div>

                <!-- Mínim jugadors -->
                <div class="d-flex flex-column justify-content-center m-3">
                    <InputLabel for="min" value="Mínim jugadors (per defecte 2):" />
                    <VField
                        id="min"
                        name="min"
                        type="number"
                        :min="2"
                        step="1"
                        v-model="form.min"
                        style="color: black;"
                    />
                    <ErrorMessage name="min" class="text-danger mt-1" />
                </div>

                <!-- Tipus Torneig -->
                <div class="d-flex flex-column justify-content-center m-3">
                    <InputLabel for="idTipus" value="Tipus Torneig" />
                    <VField
                        id="idTipus"
                        name="idTipus"
                        as="select"
                        v-model="form.idTipus"
                        rules="required"
                        class="mt-1 block w-full"
                        style="color: black;"
                    >
                        <option v-for="tipusTorneig in tipusTornejos" :key="tipusTorneig.idTipus" :value="tipusTorneig.idTipus">
                            {{ tipusTorneig.descripcio }}
                        </option>
                    </VField>
                    <ErrorMessage name="idTipus" class="text-danger mt-1" />
                </div>

                <!-- Data i Hora d'Inici -->
                <div class="d-flex flex-column justify-content-center m-3">
                    <InputLabel for="dataHoraInici" value="Data i Hora d'Inici:" />
                    <VField
                        id="dataHoraInici"
                        name="dataHoraInici"
                        type="datetime-local"
                        v-model="form.dataHoraInici"
                        rules="required"
                        class="mt-1 block w-full"
                        style="color: black;"
                    />
                    <ErrorMessage name="dataHoraInici" class="text-danger mt-1" />
                </div>

                <!-- Botones Crear y Cancelar -->
                <div class="d-flex justify-content-center m-3">
                    <button
                        type="submit"
                        class="btn btn-success ml-5"
                        @click="validate()"
                        :disabled="invalid"
                    >
                        Modificar
                    </button>
                    <button type="button" class="btn btn-danger ml-5" @click="cerrarModalModificacio">
                        Cancelar
                    </button>
                </div>
            </VForm>
        </Modal>
        <Modal :show="showModalModificacioConfirmacio" maxWidth="2xl" closeable @close="cerrarModalModificacio" >
            <div class="modal-content w-100">
                <div class="d-flex flex-column justify-content-center align-items-center m-3 position-relative">
                    <!-- Botón de cerrar -->
                    <button @click="cerrarModalModificacio" style="border: none; background: none; position: absolute; top: 10px; right: 10px;">
                        <img :src="`/images/cierre.jpg`" alt="Cerrar" style="width: 10px; height: 10px;" />
                    </button>

                    <!-- Contenido del mensaje -->
                    <div class="text-center">
                        <p>Torneig modificat!</p>
                    </div>
                </div>
            </div>
        </Modal>

        <Modal :show="showModalQuantitatIncorrecta" maxWidth="2xl" closeable @close="cerrarModalQuantitatIncorrecta">
            <div class="modal-content w-100">
                <div class="d-flex flex-column justify-content-center align-items-center m-3 position-relative">
                    <!-- Botón de cerrar -->
                    <button @click="cerrarModalQuantitatIncorrecta" style="border: none; background: none; position: absolute; top: 10px; right: 10px;">
                        <img :src="`/images/cierre.jpg`" alt="Cerrar" style="width: 10px; height: 10px;" />
                    </button>

                    <!-- Contenido del mensaje -->
                    <div class="text-center">
                        <p>Quantitat Màxima o Mínima Incorrecta!</p>
                        <p>Mínim no pot ser menor a Màxim! I No poden ser menors de 2!</p>
                    </div>
                </div>
            </div>
        </Modal>
        <Modal :show="showModalEliminacio" maxWidth="2xl" closeable @close="cerrarModalEliminacio" >
            <div class="modal-content w-100">
                <div class="d-flex justify-content-center m-3 ">
                    <p>¿Estas segur de que vols eliminar aquesta torneig?</p>
                </div>
                <div class="d-flex justify-content-center m-3 ">
                    <button type="button" class="btn btn-success mr-5"
                            @click="eliminarTorneig">Sí</button>
                    <button type="button" class="btn btn-danger ml-5" @click="cerrarModalEliminacio">No</button>
                </div>
            </div>
        </Modal>
        <Modal :show="showModalEliminacioConfirmacio" maxWidth="2xl" closeable @close="cerrarModalEliminacio" >
            <div class="modal-content w-100">
                <div class="d-flex flex-column justify-content-center align-items-center m-3 position-relative">
                    <!-- Botón de cerrar -->
                    <button @click="cerrarModalEliminacio" style="border: none; background: none; position: absolute; top: 10px; right: 10px;">
                        <img :src="`/images/cierre.jpg`" alt="Cerrar" style="width: 10px; height: 10px;" />
                    </button>
                    <!-- Contenido del mensaje -->
                    <div class="text-center">
                        <p>Torneig eliminat!</p>
                    </div>
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

.text-danger {
    color: red;
    font-weight: bold;
}
</style>
