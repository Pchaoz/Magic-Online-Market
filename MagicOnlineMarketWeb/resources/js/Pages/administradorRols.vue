<script setup>
import {ref} from "vue";
import 'bootstrap/dist/css/bootstrap.css';
import AuthenticatedLayout from "@/Layouts/AuthenticatedLayout.vue";
import Modal from '@/Components/Modal.vue';
import axios from 'axios';
import {useForm} from "@inertiajs/vue3";
import InputLabel from "@/Components/InputLabel.vue";


defineProps({
    rols: {
        type: Array(String),
    }
});


let showModal = ref(false);
let showModalEliminacio = ref(false);
let showModalCreacio=ref(false);
let showModalCreacioConfirmacio=ref(false);
let showModalModificacio=ref(false);
let showModalModificacioConfirmacio=ref(false);
let rolId =ref(null);

const abrirModalCreacio = () =>{
    cerrarModal();
    formRol.nom="";
    showModalCreacio.value=true;
}

const cerrarModalCreacio = () =>{
    showModalCreacio.value=false;
}

const abrirModalConfirmacion = (id) => {
    showModal.value = true;
    rolId.value=id;
}


const cerrarModal = () => {
    showModal.value = false;
    showModalEliminacio.value=false;
}

const abrirModalMod = (nom,id) =>{
    cerrarModal();
    showModalModificacio.value=true;
    formRol.nom=nom;
    formRol.id=id;

}

const modificarRol = () => {
    formRol.post('editarRol');
    finModificacio();

}

const finModificacio=()=>{
    showModalModificacio.value=false;
    showModalModificacioConfirmacio.value=true;
    setTimeout(() => {
        showModalModificacioConfirmacio.value = false;
    }, 2000);
    useForm.visit(window.location.pathname);
}

const cerrarModalMod=()=>{
    showModalModificacio.value=false;
}



const eliminarRol = async () => {
    try {
        const response = await axios.get(`/eliminarRol/${rolId.value}`);
        console.log(response.data);
        finEliminacio();

    } catch (error) {
        console.error(error);
    }
}

const finEliminacio=()=>{
    showModal.value=false;
    showModalEliminacio.value=true;
    setTimeout(() => {
        showModalEliminacio.value = false;
        window.location.reload();
    }, 2000);

}



const formRol= useForm({
    nom: null,
    id:null,
})
const crearRol=()=> {

    formRol.post('crearRol');
    confirmacionCreacio();
}

const confirmacionCreacio=()=>{
    showModalCreacio.value=false;
    showModalCreacioConfirmacio.value=true;
    setTimeout(() => {
        showModalCreacioConfirmacio.value = false;
    }, 2000);
    useForm.visit(window.location.pathname);
}


</script>

<template>
    <AuthenticatedLayout>
        <div class="d-flex justify-content-center m-3 ">
            <h2>Administrar Rols</h2>
        </div>
        <div class="d-flex justify-content-center m-3 ">
            <table class="table table-striped my-table w-25 ">
                <thead>
                <tr>
                    <th>Nom</th>
                    <th></th>
                    <th></th>
                </tr>
                </thead>
                <tbody>
                <tr v-for="rol in rols" :key="rol.id">
                    <td>{{rol.nom}}</td>
                    <td>
                        <button  class="btn btn-success rounded-pill"
                                 @click="abrirModalMod(rol.nom,rol.idRol)">Modificar</button>

                    </td>
                    <td>
                        <button  class="btn btn-danger rounded-pill"
                        @click="abrirModalConfirmacion(rol.idRol)">Eliminar</button>

                    </td>
                </tr>
                </tbody>
            </table>

            <Modal :show="showModal" maxWidth="2xl" closeable @close="cerrarModal" >
                <div class="modal-content w-100">
                    <div class="d-flex justify-content-center m-3 ">
                        <p>¿Estas segur de que vols eliminar aquest rol?</p>
                    </div>
                    <div class="d-flex justify-content-center m-3 ">
                        <button type="button" class="btn btn-success mr-5"
                                @click="eliminarRol">Sí</button>
                        <button type="button" class="btn btn-danger ml-5" @click="cerrarModal">No</button>

                    </div>
                </div>
            </Modal>
            <Modal :show="showModalEliminacio" maxWidth="2xl" closeable @close="cerrarModal" >
                <div class="modal-content w-100">
                    <div class="d-flex justify-content-center m-3 ">
                        <p>Rol Eliminat</p>
                    </div>
                </div>
            </Modal>

            <Modal :show="showModalCreacio" maxWidth="2xl" closeable @close="cerrarModalCreacio" >
                <div class="modal-content w-100">

                    <div class="d-flex justify-content-center m-3 ">
                        <InputLabel for="nom" value="Nom del nou rol" class="m-2"  style="font-size: 16px;"/>
                        <input
                            id="nom"
                            type="text"
                            class="mt-1 block w-full"
                            v-model="formRol.nom"
                            required
                            autofocus
                            style="color: black;">

                    </div>
                        <div class="d-flex justify-content-center m-3 ">
                        <button type="button" class="btn btn-success ml-5"
                            @click="crearRol">Crear</button>
                        <button type="button" class="btn btn-danger ml-5"
                                @click="cerrarModalCreacio">Cancelar</button>
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
                            v-model="formRol.nom"
                            required
                            autofocus
                            style="color: black;">
                    </div>
                        <div class="d-flex justify-content-center m-3 ">
                            <button type="button" class="btn btn-success ml-5"
                                    @click="modificarRol">Modificar</button>
                            <button type="button" class="btn btn-danger ml-5"
                                    @click="cerrarModalMod">Cancelar</button>

                    </div>
                </div>
            </Modal>
            <Modal :show="showModalModificacioConfirmacio" maxWidth="2xl" closeable @close="cerrarModalMod" >
                <div class="modal-content w-100">
                    <div class="d-flex justify-content-center m-3 ">
                        <p>Rol Modificat</p>
                    </div>
                </div>
            </Modal>

            <Modal :show="showModalCreacioConfirmacio" maxWidth="2xl" closeable @close="cerrarModalMod" >
                <div class="modal-content w-100">
                    <div class="d-flex justify-content-center m-3 ">
                        <p>Rol Creat</p>
                    </div>
                </div>
            </Modal>
        </div>
        <div class="d-flex justify-content-center m-3 ">
            <button  class="btn btn-success"
                     @click="abrirModalCreacio()">Crear Rol</button>
        </div>
    </AuthenticatedLayout>
</template>

<style>

.my-table td, .my-table th {
    background-color: rgba(0,214,153,0.7) !important;
    text-align: center;
    vertical-align: middle;
}
</style>
