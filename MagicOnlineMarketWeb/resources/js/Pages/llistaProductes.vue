<script setup>

import AuthenticatedLayout from "@/Layouts/AuthenticatedLayout.vue";
import 'bootstrap/dist/css/bootstrap.css';
import Modal from "@/Components/Modal.vue";
import {ref} from "vue";
import {useForm} from "@inertiajs/vue3";
import axios from "axios";
import InputLabel from "@/Components/InputLabel.vue";

defineProps({
    productes: {
        type: Array(String),
    },
    expansions:{
        type: Array(String),
    },
    categoriesProducte:{
        type: Array(String),
    }
});

let showModalEliminacio = ref(false);
let showModalEliminacioConfirmacio = ref(false);
let showModalModificacio=ref(false);
let showModalModificacioConfirmacio=ref(false);
let showModalCreacio=ref(false);

const formProducte= useForm({
    idProducte:null,
    nom: "",
    descripcio:"",
    imatge:"",
    idCategoriaProducte:"",
    idExpansio:"",
    idCarta:""
})
//eliminació de producte
const abrirModalEliminacio = (id) =>{
    showModalEliminacio.value=true;
    formProducte.idProducte=id;

}
const cerrarModalEliminacio = () => {
    showModalEliminacio.value=false;
    showModalEliminacioConfirmacio.value=false;
}

const eliminarProducte =()=> {
    formProducte.delete('eliminarProducte');
    showModalEliminacioConfirmacio=true;
    location.reload();

}
//modificació de producte
const abrirModalModificacio = (producte) =>{
    showModalModificacio.value=true;

}
const cerrarModalModificacio = () => {
    showModalEliminacio.value=false;
    showModalEliminacioConfirmacio.value=false;
}

const modificarProducte =()=> {
    formProducte.delete('eliminarProducte');
    showModalEliminacioConfirmacio=true;
    location.reload();

}


</script>

<template>
    <AuthenticatedLayout>
        <div class="d-flex justify-content-center">
            <table class="table table-striped table-dark w-50">
                <thead>
                <tr>
                    <th>Nom Producte</th>
                    <th class="text-center mx-2" style="width: 300px">Descripcio Producte</th>
                    <th>Imatge Producte</th>
                    <th class="text-center mx-2">Categoria Producte</th>
                    <th class="text-center mx-2">Expansio Producte</th>
                    <th v-if="$page.props.auth.user.idRol==1 ||$page.props.auth.user.idRol==2 "></th>
                    <th v-if="$page.props.auth.user.idRol==1 ||$page.props.auth.user.idRol==2 "></th>
                    <th v-if="$page.props.auth.user.idRol==5 ||$page.props.auth.user.idRol==4 "></th>

                </tr>
                </thead>
                <tbody>
                <tr v-for="producte in productes" :key="producte.id">
                    <td>{{producte.nom}}</td>
                    <td class="text-center mx-2" style="width: 300px">{{producte.descripcio}}</td>
                    <td><img :src="'/images/' + producte.imatge" alt="Imatge del producte" width="150" height="200"></td>
                    <td class="text-center"> {{producte.categoriaProducteNom}} </td>
                    <td class="text-center"> {{producte.expansioNom}}</td>
                    <td v-if="$page.props.auth.user.idRol==1 ||$page.props.auth.user.idRol==2 ">
                        <b-button  class="btn btn-success rounded-pill"
                                   @click="abrirModalModificacio(producte)">Modificar</b-button>
                    </td>
                    <td v-if="$page.props.auth.user.idRol==1 ||$page.props.auth.user.idRol==2 ">

                        <b-button  class="btn btn-success rounded-pill"
                                 @click="abrirModalEliminacio(producte.idProducte)">Eliminar</b-button>
                    </td>
                    <td style=" padding-left: 30px" v-if="$page.props.auth.user.idRol==5 ||$page.props.auth.user.idRol==4 ">

                        <b-button  class="btn btn-success rounded-pill"
                                   @click="abrirModalCreacioArticle(producte.idProducte)">Crear Oferta</b-button>

                    </td>
                </tr>

                </tbody>
            </table>

        </div>
        <Modal :show="showModalEliminacio" maxWidth="2xl" closeable @close="cerrarModalEliminacio" >
            <div class="modal-content w-100">
                <span class="close" @click="cerrarModalEliminacio">×</span>
                <div class="d-flex justify-content-center m-3 ">
                    <p>¿Estas segur de que vols eliminar aquest producte?</p>
                </div>
                <div class="d-flex justify-content-center m-3 ">
                    <button type="button" class="btn btn-danger mr-5" @click="cerrarModalEliminacio">No</button>
                    <button type="button" class="btn btn-primary ml-5"
                            @click="eliminarProducte">Sí</button>
                </div>
            </div>
        </Modal>
        <Modal :show="showModalEliminacioConfirmacio" maxWidth="2xl" closeable @close="cerrarModalEliminacio" >
            <div class="modal-content w-100">
                <span class="close" @click="cerrarModalEliminacio">×</span>
                <div class="d-flex justify-content-center m-3 ">
                    <p>Producte Eliminat</p>
                </div>
            </div>
        </Modal>
        <Modal :show="showModalModificacio" maxWidth="2xl" closeable @close="cerrarModalMod" >
            <div class="modal-content w-100">
                <span class="close" @click="cerrarModalMod">×</span>
                <div class="d-flex justify-content-center m-3 ">
                    <InputLabel for="nom" value="Nom nou del rol" class="m-2"  style="font-size: 16px;"/>
                    <input
                        id="nom"
                        type="text"
                        class="mt-1 block w-full"
                        v-model="formProducte.nom"
                        required
                        autofocus
                        style="color: black;">
                    <button type="button" class="btn btn-success ml-5"
                            @click="modificarRol">Modificar</button>
                </div>
            </div>
        </Modal>
        <Modal :show="showModalModificacioConfirmacio" maxWidth="2xl" closeable @close="cerrarModalMod" >
            <div class="modal-content w-100">
                <span class="close" @click="cerrarModalMod">×</span>
                <div class="d-flex justify-content-center m-3 ">
                    <p>Rol Modificat</p>
                </div>
            </div>
        </Modal>

        <div class="d-flex justify-content-center m-3 " v-if="$page.props.auth.user.idRol==1 ||$page.props.auth.user.idRol==2 ">
            <b-button class="btn btn-success rounded-pill" style="width: 200px;" @click="abrirModalConfirmacion(rol.idRol)">Crear Nou producte</b-button>
        </div>

    </AuthenticatedLayout>
</template>

<style scoped>




td,th{
    text-align: center;
    vertical-align: middle;
    padding-left: 10px;
}

</style>
