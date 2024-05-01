<script setup>
import {ref} from "vue";
import 'bootstrap/dist/css/bootstrap.css';
import AuthenticatedLayout from "@/Layouts/AuthenticatedLayout.vue";
import Modal from '@/Components/Modal.vue';
import axios from 'axios';
import {useForm} from "@inertiajs/vue3";
import InputLabel from "@/Components/InputLabel.vue";
import TextInput from "@/Components/TextInput.vue";


defineProps({
    usuaris: {
        type: Array(String),
    },
    rols:{
        type: Array(String),
    }
});

let showModalEliminacio = ref(false);
let showModalEliminacioConfirmacio = ref(false);
let showModalModificacio = ref(false);
let showModalModificacioConfirmacio = ref(false);
let userId =ref(null);

//funcio per eliminar usuari

const abrirModalEliminacion = (id) => {
    showModalEliminacio.value = true;
    userId.value=id;
}

const cerrarModal = () => {
    showModalEliminacio.value = false;
    showModalEliminacioConfirmacio.value=false;
    showModalModificacio.value=false;
    showModalModificacioConfirmacio.value=false;
}

const eliminarUsuari = async () => {
    try {
        const response = await axios.delete(`/deleteUser/${userId.value}`);
        console.log(response.data);
        cerrarModal();
        location.reload();
        showModalEliminacioConfirmacio.value = true;
    } catch (error) {
        console.error(error);
    }
}
//funcio per eliminar modificar usuari

const formUsuari= useForm({
    idUsuari:"",
    nick: "",
    nom:"",
    cognom:"",
    email:"",
    idRol:""
})

const abrirModalModificacio=(user)=>{

    formUsuari.nick=user.nick;
    formUsuari.nom=user.nom;
    formUsuari.cognom=user.cognom;
    formUsuari.email=user.email;
    formUsuari.idRol=user.idRol;
    formUsuari.idUsuari=user.idUsuari;
    showModalModificacio.value=true;
}

const modificarUser = () => {
    formUsuari.post('editarUsuari');
    finModificacio();

}

const finModificacio=()=>{
    showModalModificacio.value=false
    showModalModificacioConfirmacio.value=true;
    location.reload();
}



</script>

<template>
    <AuthenticatedLayout>
        <div class="d-flex justify-content-center m-3 ">
            <table class="table table-striped my-table w-50 ">
                <thead>
                <tr>
                    <th>Nick</th>
                    <th>Nom</th>
                    <th>Cognom</th>
                    <th>Email</th>
                    <th>Rol</th>
                    <th></th>
                    <th></th>
                </tr>
                </thead>
                <tbody>
                <tr v-for="usuari in usuaris" :key="usuari.id">
                    <td>{{usuari.nick}}</td>
                    <td>{{usuari.nom}}</td>
                    <td>{{usuari.cognom}}</td>
                    <td>{{usuari.email}}</td>
                    <td>{{usuari.nomRol}}</td>
                    <td>
                        <button  class="btn btn-success rounded-pill"
                                 @click="abrirModalModificacio(usuari)">Modificar</button>
                    </td>
                    <td>
                        <button  class="btn btn-danger rounded-pill"
                                 @click="abrirModalEliminacion(usuari.idUsuari)">Eliminar</button>

                    </td>
                </tr>
                </tbody>
            </table>
            <Modal :show="showModalEliminacio" maxWidth="2xl" closeable @close="cerrarModal" >
                <div class="modal-content w-100">
                    <div class="d-flex justify-content-center m-3 ">
                        <p>¿Estas segur de que vols eliminar aquest usuari/a?</p>
                    </div>
                    <div class="d-flex justify-content-center m-3 ">
                        <button type="button" class="btn btn-danger mr-5" @click="cerrarModal">No</button>
                        <button type="button" class="btn btn-primary ml-5"
                                @click="eliminarUsuari">Sí</button>
                    </div>
                </div>
            </Modal>
            <Modal :show="showModalEliminacioConfirmacio" maxWidth="2xl" closeable @close="cerrarModal" >
                <div class="modal-content w-100">
                    <div class="d-flex justify-content-center m-3 ">
                        <p>Usuari/a Eliminat/da</p>
                    </div>
                </div>
            </Modal>

            <Modal :show="showModalModificacio" maxWidth="2xl" closeable @close="cerrarModal" >
                <div class="modal-content w-100">
                    <div class="d-flex justify-content-center m-3 ">
                        <form enctype="multipart/form-data" class="w-50 rounded">
                            <div class="m-2">
                                <InputLabel for="nick" value="Nick:" class="m-2"  style="font-size: 16px;"/>
                                <input
                                    id="nick"
                                    type="text"
                                    class="mt-1 block w-full"
                                    v-model="formUsuari.nick"
                                    required
                                    autofocus
                                    style="color: black;">
                            </div>
                            <div class="m-2">
                                <InputLabel for="nom" value="Nom:" />
                                <TextInput
                                    id="nom"
                                    type="text"
                                    class="mt-1 block w-full"
                                    v-model="formUsuari.nom"
                                    required
                                    autofocus
                                    autocomplete="nom"
                                    style="color: black;"
                                />
                            </div>
                            <div class="m-2">
                                <InputLabel for="cognom" value="Cognom:" />
                                <TextInput
                                    id="cognom"
                                    type="text"
                                    class="mt-1 block w-full"
                                    v-model="formUsuari.cognom"
                                    required
                                    autofocus
                                    autocomplete="cognom"
                                    style="color: black;"
                                />
                            </div>
                            <div class="m-2">
                                <InputLabel for="email" value="Email:" />
                                <TextInput
                                    id="email"
                                    type="text"
                                    class="mt-1 block w-full"
                                    v-model="formUsuari.email"
                                    required
                                    autofocus
                                    autocomplete="email"
                                    style="color: black;"
                                />
                            </div>
                            <div class="m-2 text-center font-weight-bold">
                                    <div>Rol Usuari/a</div>
                                    <select id="idRol" v-model="formUsuari.idRol" style="color: black;">
                                        <option v-for="rol in rols"  v-bind:key="rol.idRol" v-bind:value="rol.idRol">
                                            {{ rol.nom }}
                                        </option>
                                    </select>
                            </div>

                            <div class="d-flex justify-content-center m-3 ">
                                <button type="button" class="btn btn-success ml-5"
                                        @click="modificarUser">Modificar</button>
                                <button type="button" class="btn btn-danger ml-5"
                                        @click="cerrarModal">Cancelar</button>

                            </div>
                        </form>
                    </div>
                </div>
            </Modal>
            <Modal :show="showModalModificacioConfirmacio" maxWidth="2xl" closeable @close="cerrarModal" >
                <div class="modal-content w-100">

                    <div class="d-flex justify-content-center m-3 ">
                        <p>Operació realitzada!</p>
                    </div>
                </div>
            </Modal>
        </div>


    </AuthenticatedLayout>
</template>

<style scoped>

.my-table td, .my-table th {
    background-color: rgba(0,214,153,0.5) !important;
    text-align: center;
    vertical-align: middle;
}

</style>
