<script setup>
import {ref} from "vue";
import 'bootstrap/dist/css/bootstrap.css';
import AuthenticatedLayout from "@/Layouts/AuthenticatedLayout.vue";
import Modal from '@/Components/Modal.vue';
import {useForm} from "@inertiajs/vue3";
import InputLabel from "@/Components/InputLabel.vue";
import { required } from '@vee-validate/rules';
import { Form as VForm, Field as VField, defineRule, ErrorMessage } from 'vee-validate';



defineRule('required', required);

const props = defineProps({
    usuaris: {
        type: Array(String),
    },
    rols:{
        type: Array(String),
    },
    nicks:{
        type: Array,
        default: () => ([]),
    }
});

let showModalEliminacio = ref(false);
let showModalEliminacioConfirmacio = ref(false);
let showModalModificacio = ref(false);
let showModalModificacioConfirmacio = ref(false);
let obj = ref(props.nicks);
let targetArray = [];
let showModalNickIncorrecte = ref(false);
if (obj.value) {
    targetArray = obj.value.map(user => user.nick);
}

//funcio per eliminar usuari

const abrirModalEliminacion = (id) => {
    showModalEliminacio.value = true;
    formUsuari.idUsuari =id;
}

const cerrarModal = () => {
    showModalEliminacio.value = false;
    showModalEliminacioConfirmacio.value=false;
    showModalModificacio.value=false;
    showModalModificacioConfirmacio.value=false;
}

const eliminarUsuari =  () => {

    formUsuari.delete(`deleteUser`);
        cerrarModal();
        showModalEliminacioConfirmacio.value = true;
        setTimeout(() => {
            showModalEliminacioConfirmacio.value = false;
            formUsuari.idUsuari="";
            useForm.visit(window.location.pathname);
        }, 500);

}
//funcio per eliminar modificar usuari

const formUsuari= useForm({
    idUsuari:"",
    nick: "",
    nickAntic:"",
    nom:"",
    cognom:"",
    idRol:""
})

const abrirModalModificacio=(user)=>{

    formUsuari.nick=user.nick;
    formUsuari.nickAntic=formUsuari.nick;
    formUsuari.nom=user.nom;
    formUsuari.cognom=user.cognom;
    formUsuari.idRol=user.idRol;
    formUsuari.idUsuari=user.idUsuari;
    showModalModificacio.value=true;
}

const modificarUser = () => {
    if (targetArray.includes(formUsuari.nick) &&  formUsuari.nickAntic!=formUsuari.nick) {
        showModalModificacio.value=false
        abrirModalNickIncorrecte();
        return;
    }
    formUsuari.post('editarUsuari');
    finModificacio();

}

const finModificacio=()=>{
    showModalModificacio.value=false
    showModalModificacioConfirmacio.value=true;
    setTimeout(() => {
        showModalModificacioConfirmacio.value = false;
        useForm.visit(window.location.pathname);
    }, 500);

}

const abrirModalNickIncorrecte = () => {
    showModalNickIncorrecte.value =true;
}

const cerrarModalNickIncorrecte=()=>{
    showModalNickIncorrecte.value =false;
}

</script>

<template>
    <AuthenticatedLayout>
        <div class="d-flex justify-content-center m-3 ">
            <h2>Administrar Usuaris</h2>
        </div>
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

                        <button type="button" class="btn btn-success mr-5"
                                @click="eliminarUsuari">Sí</button>
                        <button type="button" class="btn btn-danger ml-5" @click="cerrarModal">No</button>
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
                        <VForm v-slot="{ errors }" @submit="modificarUser" class="w-50 rounded">
                            <div class="m-2">
                                <InputLabel for="nick" value="Nick:" class="m-2"  style="font-size: 16px;"/>
                                <VField
                                    id="nick"
                                    name="nick"
                                    type="text"
                                    class="mt-1 block w-full"
                                    v-model="formUsuari.nick"
                                    rules="required"
                                    maxlength="15"
                                    style="color: black;"/>
                                <ErrorMessage name="nick" />
                            </div>
                            <div class="m-2">
                                <InputLabel for="nom" value="Nom:" />
                                <VField
                                    id="nom"
                                    name="nom"
                                    type="text"
                                    class="mt-1 block w-full"
                                    v-model="formUsuari.nom"
                                    rules="required"
                                    maxlength="20"
                                    style="color: black;"
                                />
                                <ErrorMessage name="nom" />
                            </div>
                            <div class="m-2">
                                <InputLabel for="cognom" value="Cognom:" />
                                <VField
                                    id="cognom"
                                    name="cognom"
                                    type="text"
                                    class="mt-1 block w-full"
                                    v-model="formUsuari.cognom"
                                    autocomplete="cognom"
                                    maxlength="20"
                                    style="color: black;"
                                />
                            </div>
                            <div class="m-2 text-center font-weight-bold">
                                    <div style="color: black">Rol Usuari/a</div>
                                    <select id="idRol" v-model="formUsuari.idRol" style="color: black;">
                                        <option v-for="rol in rols"  v-bind:key="rol.idRol" v-bind:value="rol.idRol">
                                            {{ rol.nom }}
                                        </option>
                                    </select>
                            </div>

                            <div class="d-flex justify-content-center m-3 ">
                                <button class="btn btn-success mr-5" :class="{ 'opacity-25': formUsuari.processing }" :disabled="Object.keys(errors).length > 0">Modificar</button>
                                <button type="button" class="btn btn-danger ml-5"
                                        @click="cerrarModal">Cancelar</button>

                            </div>
                        </VForm>
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
        <Modal :show="showModalNickIncorrecte" maxWidth="2xl" closeable @close="cerrarModalNickIncorrecte" >
            <div class="modal-content w-100">
                <div class="d-flex justify-content-between m-3 align-items-start">
                    <button @click="cerrarModalNickIncorrecte" style="border: none; background: none;">
                        <img :src="/images/+'cierre.jpg'" alt="Cerrar" style="width: 10px; height: 10px;" />
                    </button>
                    <p>Aquest nick ja existeix!</p>
                    <div></div>
                </div>
            </div>
        </Modal>

    </AuthenticatedLayout>
</template>

<style scoped>

.my-table td, .my-table th {
    background-color: rgba(0,214,153,0.5) !important;
    text-align: center;
    vertical-align: middle;
}

form {
    background-color:rgba(0,214,153,0.8) !important;

}



</style>
