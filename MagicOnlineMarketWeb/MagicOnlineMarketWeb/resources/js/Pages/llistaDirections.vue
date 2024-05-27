<script setup>

import AuthenticatedLayout from "@/Layouts/AuthenticatedLayout.vue";
import {useForm} from "@inertiajs/vue3";
import {ref} from "vue";
import InputLabel from "@/Components/InputLabel.vue";
import Modal from "@/Components/Modal.vue";
import TextInput from "@/Components/TextInput.vue";
import InputError from "@/Components/InputError.vue";

defineProps({
    direccions: {
        type: Array(String),
    },
    ciutats: {
        type: Array(String),
    }

});

const formDireccio= useForm({
    direccio: "",
    codiPostal:"",
    idCiutat:"",
    id:"",
})

let showModalEliminacio = ref(false);
let showModalEliminacioConfirmacio= ref(false);
let showModalCreacio=ref(false);
let showModalCreacioConfirmacio=ref(false);
let showModalModificacio=ref(false);
let showModalModificacioConfirmacio=ref(false);
//creació
const cerrarModalCreacio = () =>{
    showModalCreacio.value=false;
    showModalCreacioConfirmacio.value=false;
}
const abrirModalCreacio = () =>{
    formDireccio.direccio="";
    formDireccio.codiPostal="";
    formDireccio.idCiutat="";
    formDireccio.id="";
    showModalCreacio.value=true;
}
const crearDireccio=()=> {

    formDireccio.post('/crearDireccio');
    confirmacionCreacio();
}

const confirmacionCreacio=()=>{
    showModalCreacio.value=false;
    showModalCreacioConfirmacio.value=true;
    setTimeout(() => {

        useForm.visit(window.location.pathname);
    }, 500);

}
//eliminacio direccions
const cerrarModalEliminacio = () => {
    showModalEliminacio.value=false;
    showModalEliminacioConfirmacio.value=false;
}

const abrirModalEliminacio = (direccio) => {
    showModalEliminacio.value=true;
    formDireccio.id=direccio.idDireccio;
}


const eliminarProducteWishlist =()=> {
    formDireccio.delete('/eliminarDireccio');
    recargaPaginaElim();
}

const recargaPaginaElim = () => {
    showModalEliminacio.value = false;
    showModalEliminacioConfirmacio.value = true;
    setTimeout(() => {
        useForm.visit(window.location.pathname);
    }, 500);
}
//modificar direccions
const cerrarModalModificacio = () =>{
    showModalModificacio.value=false;
    showModalModificacioConfirmacio.value=false;
}

const abrirModalModificacio=  (direccio) =>{
    formDireccio.direccio=direccio.direccio;
    formDireccio.codiPostal=direccio.codiPostal;
    formDireccio.idCiutat=direccio.idCiutat;
    formDireccio.id=direccio.idDireccio;
    showModalModificacio.value=true;
}

const modDireccio=()=> {
    formDireccio.post('/modDireccio');
    confirmacionMod();
}

const confirmacionMod=()=>{
    showModalModificacio.value=false;
    showModalModificacioConfirmacio.value=true;
    setTimeout(() => {

        useForm.visit(window.location.pathname);
    }, 500);

}


</script>

<template>
    <AuthenticatedLayout>
        <div class="d-flex justify-content-center m-3 ">
            <h2>Llistat de Direccions</h2>
        </div>
        <div class="d-flex justify-content-center m-3 ">
            <table class="table table-striped my-table w-50 ">
                <thead>
                <tr>
                    <th v-if="$page.props.auth.user.idRol==1 || $page.props.auth.user.idRol==2">Nick Usuari</th>
                    <th>Direcció</th>
                    <th>Codi Postal</th>
                    <th>Ciutat</th>
                    <th>País</th>
                    <th></th>
                    <th></th>
                </tr>
                </thead>
                <tbody>
                <tr v-for="direccio in direccions" :key="direccio.id"  >
                    <td v-if="$page.props.auth.user.idRol==1 || $page.props.auth.user.idRol==2">{{direccio.nick}}</td>
                    <td>{{direccio.direccio}}</td>
                    <td>{{direccio.codiPostal}}</td>
                    <td>{{direccio.nomCiutat}}</td>
                    <td>{{direccio.nomPais}}</td>
                    <td>
                        <button  class="btn btn-success rounded-pill"
                                 @click="abrirModalModificacio(direccio)">Modificar</button>
                    </td>
                    <td>
                        <button  class="btn btn-danger rounded-pill"
                        @click="abrirModalEliminacio(direccio)">Eliminar</button>

                    </td>
                </tr>
                </tbody>
            </table>
        </div>
        <div class="d-flex justify-content-center m-3 ">
            <b-button class="btn btn-success rounded-pill" style="width: 200px;" @click="abrirModalCreacio">Crear Direcció</b-button>
        </div>
        <Modal :show="showModalCreacio" maxWidth="2xl"    @close="cerrarModalCreacio" >
            <div class="d-flex justify-content-center">
                <form class="w-75 rounded pt-1" @submit="crearDireccio" >

                    <div class="d-flex flex-column align-items-center m-3 p-1 ">
                        <InputLabel for="direccio" value="Direcció:"/>
                        <TextInput id="direccio"  type="text" v-model="formDireccio.direccio" required autofocus
                                   autocomplete="direccio" class="mt-1 block w-full"  maxlength="50" style="color: black;" />
                        <InputError class="mt-2" :message="formDireccio.errors.direccio" />
                    </div>
                    <div class="d-flex flex-column align-items-center m-3 p-1 ">
                        <InputLabel for="codiPostal" value="Codi Postal:"/>
                        <TextInput id="codiPostal"  type="text" v-model="formDireccio.codiPostal" required autofocus
                                   autocomplete="direccio" class="mt-1 block w-full"  maxlength="20" style="color: black;" />
                        <InputError class="mt-2" :message="formDireccio.errors.codiPostal" />
                    </div>
                    <div class="d-flex flex-column align-items-center m-4">
                        <div>Ciutat: </div>
                        <select id="idCiutat" v-model="formDireccio.idCiutat" required style="color: black;">
                            <option v-for="ciutat in ciutats"  v-bind:key="ciutat.idCiutat" v-bind:value="ciutat.idCiutat">
                                {{ ciutat.nom }}
                            </option>
                        </select>
                        <InputError class="mt-2" :message="formDireccio.errors.idCiutat" />
                    </div>
                    <div class="d-flex justify-content-center m-3 ">
                        <button type="button" class="btn btn-danger ml-5"
                                @click="cerrarModalCreacio">Cancelar</button>
                        <button  class="btn btn-success ml-5" >Crear</button>
                    </div>
                </form>
            </div>
        </Modal>
        <Modal :show="showModalCreacioConfirmacio" maxWidth="2xl" closeable @close="cerrarModalCreacio" >
            <div class="modal-content w-100">
                <div class="d-flex justify-content-between m-3 align-items-start">
                    <button @click="cerrarModalCreacio" style="border: none; background: none;">
                        <img :src="/images/+'cierre.jpg'" alt="Cerrar" style="width: 10px; height: 10px;" />
                    </button>
                    <p>Direcció Creada!</p>
                    <div></div>
                </div>
            </div>
        </Modal>
        <Modal :show="showModalEliminacio" maxWidth="2xl" closeable @close="cerrarModalEliminacio" >
            <div class="modal-content w-100">
                <div class="d-flex justify-content-center m-3 ">
                    <p>¿Estas segur de que vols eliminar aquesta Direcció?</p>
                </div>
                <div class="d-flex justify-content-center m-3 ">
                    <button type="button" class="btn btn-success mr-5"
                            @click="eliminarProducteWishlist">Sí</button>
                    <button type="button" class="btn btn-danger ml-5" @click="cerrarModalEliminacio">No</button>

                </div>
            </div>
        </Modal>
        <Modal :show="showModalEliminacioConfirmacio" maxWidth="2xl" closeable @close="cerrarModalEliminacio" >
            <div class="modal-content w-100">
                <button class="p-2" @click="cerrarModalEliminacio" style="border: none; background: none;">
                    <img :src="/images/+'cierre.jpg'" alt="Cerrar" style="width: 10px; height: 10px;" />
                </button>
                <div class="d-flex justify-content-center m-3 ">
                    <p>Direcció Eliminada!</p>
                </div>
            </div>
        </Modal>
        <Modal :show="showModalModificacio" maxWidth="2xl"    @close="cerrarModalModificacio" >
            <div class="d-flex justify-content-center">
                <form class="w-75 rounded pt-1" @submit="modDireccio" >

                    <div class="d-flex flex-column align-items-center m-3 p-1 ">
                        <InputLabel for="direccio" value="Direcció:"/>
                        <TextInput id="direccio"  type="text" v-model="formDireccio.direccio" required autofocus
                                   autocomplete="direccio" class="mt-1 block w-full"  maxlength="50" style="color: black;" />
                        <InputError class="mt-2" :message="formDireccio.errors.direccio" />
                    </div>
                    <div class="d-flex flex-column align-items-center m-3 p-1 ">
                        <InputLabel for="codiPostal" value="Codi Postal:"/>
                        <TextInput id="codiPostal"  type="text" v-model="formDireccio.codiPostal" required autofocus
                                   autocomplete="direccio" class="mt-1 block w-full"  maxlength="20" style="color: black;" />
                        <InputError class="mt-2" :message="formDireccio.errors.codiPostal" />
                    </div>
                    <div class="d-flex flex-column align-items-center m-4">
                        <div>Ciutat: </div>
                        <select id="idCiutat" v-model="formDireccio.idCiutat" required style="color: black;">
                            <option v-for="ciutat in ciutats"  v-bind:key="ciutat.idCiutat" v-bind:value="ciutat.idCiutat">
                                {{ ciutat.nom }}
                            </option>
                        </select>
                        <InputError class="mt-2" :message="formDireccio.errors.idCiutat" />
                    </div>
                    <div class="d-flex justify-content-center m-3 ">
                        <button type="button" class="btn btn-danger ml-5"
                                @click="cerrarModalCreacio">Cancelar</button>
                        <button  class="btn btn-success ml-5" >Crear</button>
                    </div>
                </form>
            </div>
        </Modal>

        <Modal :show="showModalModificacioConfirmacio" maxWidth="2xl" closeable @close="cerrarModalModificacio" >
            <div class="modal-content w-100">
                <div class="d-flex justify-content-between m-3 align-items-start">
                    <button @click="cerrarModalModificacio" style="border: none; background: none;">
                        <img :src="/images/+'cierre.jpg'" alt="Cerrar" style="width: 10px; height: 10px;" />
                    </button>
                    <p>Direcció Modificada!</p>
                    <div></div>
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
