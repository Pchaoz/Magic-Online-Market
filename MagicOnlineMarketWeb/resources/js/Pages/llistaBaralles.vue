<script setup>


import AuthenticatedLayout from "@/Layouts/AuthenticatedLayout.vue";
import 'bootstrap/dist/css/bootstrap.css';
import {useForm} from "@inertiajs/vue3";
import {ref} from "vue";
import Modal from "@/Components/Modal.vue";
import InputLabel from "@/Components/InputLabel.vue";

defineProps({
    baralles: {
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
    idBaralla: null,
    nom:"",

});

const abrirModalConfirmacionEliminacio = (id) => {
    showModal.value = true;
    form.idBaralla=id;
}

const cerrarModalCancelar = () =>{
    showModal.value = false;
}
const cerrarModalConfirmacionElimincion = () =>{
    showModalEliminacio.value = false;
}

const eliminarBaralla =() => {
    form.delete('/deleteBaralla');
    cerrarModal();
}

const cerrarModal = () => {
    showModal.value = false;
    showModalEliminacio.value = true;

    setTimeout(() => {
        showModalEliminacio.value = false;
        useForm.visit(window.location.pathname);
    }, 500);
}

//creacio de baralles
const cerrarModalCreacio = () =>{
    showModalCreacio.value=false;
    showModalCreacioConfirmacio.value=false;
}


const abrirModalCreacio = () =>{
    form.nom="";
    showModalCreacio.value=true;
}
const crearBaralla=()=> {

    form.post('/crearBaralla');
    confirmacionCreacio();
}


const confirmacionCreacio=()=>{
    showModalCreacio.value=false;
    showModalCreacioConfirmacio.value=true;
    setTimeout(() => {
        showModalCreacioConfirmacio.value = false;
        useForm.visit(window.location.pathname);
    }, 500);

}

//modificacio

const abrirModalMod = (baralla) =>{
    form.nom=baralla.nomBaralla;
    form.idBaralla=baralla.idBaralla;
    showModalModificacio.value=true;

}

const cerrarModalMod=()=>{
    showModalModificacio.value=false;
}
const modificarBaralla = () => {
    form.post('/editarBaralla');
    finModificacio();

}

const finModificacio=()=>{
    showModalModificacio.value=false;
    showModalModificacioConfirmacio.value=true;
    setTimeout(() => {
        showModalModificacioConfirmacio.value = false;
        useForm.visit(window.location.pathname);
    }, 500);

}


</script>

<template>

    <AuthenticatedLayout>
        <div class="d-flex justify-content-center m-3 ">
            <h2>Llistat de Baralles</h2>
        </div>
        <div class="d-flex justify-content-center m-3 ">
            <table class="table table-striped my-table w-50 ">
                <thead>
                <tr>
                    <th>Nom Baralla</th>
                    <th>Creador Baralla</th>
                    <th></th>
                    <th></th>
                </tr>
                </thead>
                <tbody>
                <tr v-for="baralla in baralles" :key="baralla.id"  >
                    <td v-if=" $page.props.auth.user.idRol==1 ||$page.props.auth.user.idUsuari===baralla.idUsuari || baralla.isPublic===1">
                        <a :href="'/veureBaralla/' + baralla.idBaralla"> {{baralla.nomBaralla}}</a>
                    </td>
                    <td v-if=" $page.props.auth.user.idRol==1 ||$page.props.auth.user.idUsuari===baralla.idUsuari || baralla.isPublic===1">{{baralla.nickCreador}}</td>
                    <td v-if="$page.props.auth.user.idRol==1||$page.props.auth.user.idUsuari===baralla.idUsuari">
                        <button  class="btn btn-success rounded-pill" v-if="$page.props.auth.user.idRol==1 ||$page.props.auth.user.idRol==2 "
                                 @click="abrirModalMod(baralla)">Modificar</button>
                    </td>
                    <td v-if="$page.props.auth.user.idRol==1||$page.props.auth.user.idUsuari===baralla.idUsuari">
                    <button  class="btn btn-danger rounded-pill" v-if="$page.props.auth.user.idRol==1 ||$page.props.auth.user.idRol==2 "
                             @click="abrirModalConfirmacionEliminacio(baralla.idBaralla)">Eliminar</button>
                </td>
                </tr>
                </tbody>
            </table>
        </div>

        <Modal :show="showModal" maxWidth="2xl" closeable @close="cerrarModalCancelar" >
            <div class="modal-content w-100">
                <div class="d-flex justify-content-center m-3 ">
                    <p>¿Estas segur de que vols eliminar aquesta Baralla?</p>
                </div>
                <div class="d-flex justify-content-center m-3 ">
                    <button type="button" class="btn btn-success mr-5"
                            @click="eliminarBaralla">Sí</button>
                    <button type="button" class="btn btn-danger ml-5" @click="cerrarModalCancelar">No</button>

                </div>
            </div>
        </Modal>
        <Modal :show="showModalEliminacio" maxWidth="2xl" closeable @close="cerrarModalConfirmacionElimincion" >
            <div class="modal-content w-100">
                <div class="d-flex justify-content-center m-3 ">
                    <p>Baralla Eliminada</p>
                </div>
            </div>
        </Modal>
        <Modal :show="showModalCreacio" maxWidth="2xl" closeable @close="cerrarModalCreacio" >
            <div class="modal-content w-100">

                <div class="d-flex justify-content-center m-3 ">
                    <InputLabel for="nom" value="Nom Baralla" class="m-2"  style="font-size: 16px;"/>
                    <input
                        id="nom"
                        type="text"
                        class="mt-1 block w-full"
                        v-model="form.nom"
                        required
                        autofocus
                        style="color: black;">

                </div>
                <div class="d-flex justify-content-center m-3 ">
                    <button type="button" class="btn btn-success ml-5"
                            @click="crearBaralla">Crear</button>
                    <button type="button" class="btn btn-danger ml-5"
                            @click="cerrarModalCreacio">Cancelar</button>
                </div>
            </div>
        </Modal>

        <Modal :show="showModalCreacioConfirmacio" maxWidth="2xl" closeable @close="cerrarModalCreacio" >
            <div class="modal-content w-100">
                <div class="d-flex justify-content-center m-3 ">
                    <p>Barralla Creada</p>
                </div>
            </div>
        </Modal>
        <Modal :show="showModalModificacio" maxWidth="2xl" closeable @close="cerrarModalMod" >
            <div class="modal-content w-100">

                <div class="d-flex justify-content-center m-3 ">
                    <InputLabel for="nom" value="Nom nou del rol" class="m-2"  style="font-size: 16px;"/>
                    <input
                        id="nom"
                        type="text"
                        class="mt-1 block w-full"
                        v-model="form.nom"
                        required
                        autofocus
                        style="color: black;">
                </div>
                <div class="d-flex justify-content-center m-3 ">
                    <button type="button" class="btn btn-success ml-5"
                            @click="modificarBaralla">Modificar</button>
                    <button type="button" class="btn btn-danger ml-5"
                            @click="cerrarModalMod">Cancelar</button>

                </div>
            </div>
        </Modal>
        <Modal :show="showModalModificacioConfirmacio" maxWidth="2xl" closeable @close="cerrarModalMod" >
            <div class="modal-content w-100">
                <div class="d-flex justify-content-center m-3 ">
                    <p>Baralla Modificada</p>
                </div>
            </div>
        </Modal>



        <div class="d-flex justify-content-center m-3 ">
            <b-button class="btn btn-success rounded-pill" style="width: 200px;" @click="abrirModalCreacio">Crear Baralla</b-button>
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
