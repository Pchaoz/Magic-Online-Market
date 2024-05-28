<script setup>

import AuthenticatedLayout from "@/Layouts/AuthenticatedLayout.vue";
import {ref} from "vue";
import {useForm} from "@inertiajs/vue3";
import InputLabel from "@/Components/InputLabel.vue";
import Modal from "@/Components/Modal.vue";
import TextInput from "@/Components/TextInput.vue";
import InputError from "@/Components/InputError.vue";

defineProps({
    tornejos: {
        type: Array(String),
    },
    tipusTornejos:{
        type: Array(String),
    },
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
    dataHoraInici:null,
});

//crear Torneig
const abrirModalCreacio = () =>{
    form.idTorneig="";
    form.participants=0;
    form.min=0;
    form.max=0;
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
                                 @click="abrirModalMod(baralla)">Modificar</button>
                    </td>
                    <td>
                        <button  class="btn btn-danger rounded-pill" v-if=" ($page.props.auth.user.idRol==1 ||$page.props.auth.user.idRol==4 || $page.props.auth.user.idRol==5) &&
                                 torneig.estat=='En creació'"
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
                    <InputLabel for="nom" value="Nom Wishlist"/>
                    <TextInput id="nom"  type="text" v-model="form.nom" required autofocus
                               autocomplete="nom" class="mt-1 block w-full" maxlength="40" style="color: black;" />
                    <InputError class="mt-2" :message="form.errors.nom" />
                </div>
                <div class="d-flex justify-content-center m-3 ">
                    <InputLabel for="max" value="Màxim jugadors:"/>
                    <Input id="max"  type="number" v-model="form.max" required autofocus
                                class="mt-1 block w-full"  :min="2" step="1"  style="color: black;" />
                    <InputError class="mt-2" :message="form.errors.max" />
                </div>
                <div class="d-flex justify-content-center m-3 ">
                    <InputLabel for="min" value="Mínim jugadors(per defecte 2): "/>
                    <Input id="min"  type="number" v-model="form.min" required autofocus
                               class="mt-1 block w-full" :min="2" step="1" style="color: black;" />
                    <InputError class="mt-2" :message="form.errors.min" />
                </div>
                <div class="d-flex justify-content-center m-3 ">
                    <InputLabel for="nom" value="Tipus Torenig"/>
                    <select id="idTipus" v-model="form.idTipus"   style="color: black;">
                        <option v-for="tipusTorneig in tipusTornejos" v-bind:key="tipusTorneig.idTipus" v-bind:value="tipusTorneig.idTipus">
                            {{tipusTorneig.descripcio}}
                        </option>
                    </select>
                </div>
                <div class="d-flex justify-content-center m-3 ">
                    <InputLabel for="dataHora" value="Data i Hora d'Inici:"/>
                    <Input id="dataHora"  type="datetime-local" v-model="form.dataHoraInici" required
                           class="mt-1 block w-full"  style="color: black;" />
                    <InputError class="mt-2" :message="form.errors.dataHoraInici" />
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
