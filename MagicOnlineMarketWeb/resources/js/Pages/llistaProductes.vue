<script setup>

import AuthenticatedLayout from "@/Layouts/AuthenticatedLayout.vue";
import 'bootstrap/dist/css/bootstrap.css';
import Modal from "@/Components/Modal.vue";
import {ref} from "vue";
import {useForm} from "@inertiajs/vue3";
import InputLabel from "@/Components/InputLabel.vue";
import TextInput from "@/Components/TextInput.vue";
import { required } from '@vee-validate/rules';
import { Form as VForm, Field as VField, defineRule, ErrorMessage } from 'vee-validate';

defineRule('required', required);

defineProps({
    productes: {
        type: Array(String),
    },
    expansions:{
        type: Array(String),
    },
    categoriesProducte:{
        type: Array(String),
    },
    cartes:{
        type: Array(String),
    }
});

let showModalEliminacio = ref(false);
let showModalEliminacioConfirmacio = ref(false);
let showModalModificacio=ref(false);
let showModalModificacioConfirmacio=ref(false);
let showModalImage = ref(false);
let insert=false;
let showModalOferta=ref(false);

const formProducte= useForm({
    idProducte:null,
    nom: "",
    descripcio:"",
    imatge:"",
    idCategoriaProducte:"",
    idExpansio:"",
    idCarta:""
})

const formOferta= useForm({
    idProducte:null,
    nomProducte:"",
    quantitatDisponible: 0,
    preuUnitari:0,
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

    recargaPaginaElim();
}

const recargaPaginaElim = () => {
    showModalEliminacio.value=false;
    showModalEliminacioConfirmacio=true;
    location.reload();

}

//modificació i inserció de productes
const abrirModalModificacio = (producte) =>{
    insert=false;
    showModalModificacio.value=true;
    formProducte.nom=producte.nom;
    formProducte.descripcio=producte.descripcio;
    formProducte.idProducte=producte.idProducte;
    formProducte.imatge='/images/'+producte.imatge;
    imatgeUrl='/images/'+producte.imatge;
    producte.idCategoriaProducte==null?  formProducte.idCategoriaProducte=null: formProducte.idCategoriaProducte=producte.idCategoriaProducte;
    producte.idExpansio==null?  formProducte.idExpansio=null: formProducte.idExpansio=producte.idExpansio;
    producte.idCarta==null?  formProducte.idCarta=null: formProducte.idCarta=producte.idCarta;
}
const cerrarModalModificacio = () => {
    showModalModificacio.value=false;
    showModalModificacioConfirmacio.value=false;
}

const modProducte =()=> {
    if(!insert){
        formProducte.get('modificarProducte');
    }else{
        formProducte.get('crearProducte');
    }
    //recargaPagina();
}
let imatgeUrl=null;


const obtenirImatge = (e) => {
    let file = e.target.files[0];
    formProducte.imatge = file;
    mostrarImatge(file);
}


const mostrarImatge = (file) => {
    let reader = new FileReader()
    reader.onload = (e) => {
        imatgeUrl = e.target.result
    }
    reader.readAsDataURL(file)
}

const recargaPagina = () => {
    showModalModificacioConfirmacio.value=true;
    location.reload();
}

const abrirModalInsert =()=>{
    insert=true;
    showModalModificacio.value=true;
    formProducte.nom="";
    formProducte.descripcio="";
    formProducte.idProducte="";
    formProducte.imatge="";
    imatgeUrl="";
    formProducte.idCategoriaProducte=null;
    formProducte.idExpansio=null;
    formProducte.idCarta=null;
}

//creacio d'oferta

const abrirModalCreacioArticle =(id,nom)=>{
    showModalOferta.value=true;
    formOferta.idProducte=id;
    formOferta.nomProducte=nom;
    formOferta.quantitatDisponible= 0;
    formOferta.preuUnitari=0;
}

const cerrarModalOferta = () => {
    showModalOferta.value=false;
}

const crearOferta =()=> {
    formOferta.get('/crearArticle');
    cerrarModalOferta();
    recargaPaginaOferta();
}

const recargaPaginaOferta = () => {
    showModalModificacioConfirmacio.value=true;
    location.reload();
}

let selectedImage = ref(null);

const openImageModal = (image) => {
    selectedImage.value = image;
    showModalImage.value = true;
}

const closeImageModal = () => {
    selectedImage.value = null;
    showModalImage.value = false;
}

</script>

<template>
    <AuthenticatedLayout>
        <div class="d-flex justify-content-center m-3 " >
            <table class="table table-striped my-table w-75" >
                <thead>
                <tr>
                    <th class="col-2">Nom Producte</th>
                    <th class="col-3">Descripcio Producte</th>
                    <th class="col-2">Imatge Producte</th>
                    <th class="col-2">Categoria Producte</th>
                    <th class="col-2">Expansio Producte</th>
                    <th class="col-1" v-if="$page.props.auth.user.idRol==1 ||$page.props.auth.user.idRol==2 "></th>
                    <th class="col-1"v-if="$page.props.auth.user.idRol==1 ||$page.props.auth.user.idRol==2 "></th>
                    <th class="col-1" v-if="$page.props.auth.user.idRol==1 || $page.props.auth.user.idRol==5 ||$page.props.auth.user.idRol==4 "></th>

                </tr>
                </thead>
                <tbody>
                <tr v-for="producte in productes" :key="producte.id">
                    <td>
                        <a :href="'/ver-ofertas/' + producte.idProducte">{{ producte.nom }}</a>
                    </td>
                    <td>{{producte.descripcio}}</td>
                    <td>
                        <img :src="'/images/' + producte.imatge" alt="Imatge del producte" width="300" height="350" @click="openImageModal(producte.imatge)">
                    </td>
                    <td> {{producte.categoriaProducteNom}} </td>
                    <td> {{producte.expansioNom}}</td>
                    <td v-if="$page.props.auth.user.idRol==1 ||$page.props.auth.user.idRol==2 ">
                        <b-button  class="btn btn-success rounded-pill"
                                   @click="abrirModalModificacio(producte)">Modificar</b-button>
                    </td>
                    <td v-if="$page.props.auth.user.idRol==1 ||$page.props.auth.user.idRol==2 ">

                        <b-button  class="btn btn-danger rounded-pill"
                                 @click="abrirModalEliminacio(producte.idProducte)">Eliminar</b-button>
                    </td>
                    <td  v-if="$page.props.auth.user.idRol==5 ||$page.props.auth.user.idRol==4 || $page.props.auth.user.idRol==1">

                        <b-button  class="btn btn-success rounded-pill"
                                   @click="abrirModalCreacioArticle(producte.idProducte,producte.nom)">Vendre</b-button>

                    </td>
                </tr>

                </tbody>
            </table>

        </div>
        <Modal :show="showModalEliminacio" maxWidth="2xl" closeable @close="cerrarModalEliminacio" >
            <div class="modal-content w-100">
                <div class="d-flex justify-content-center m-3 ">
                    <p>¿Estas segur de que vols eliminar aquest producte?</p>
                </div>
                <div class="d-flex justify-content-center m-3 ">
                    <button type="button" class="btn btn-success mr-5"
                            @click="eliminarProducte">Sí</button>
                    <button type="button" class="btn btn-danger ml-5" @click="cerrarModalEliminacio">No</button>

                </div>
            </div>
        </Modal>
        <Modal :show="showModalEliminacioConfirmacio" maxWidth="2xl" closeable @close="cerrarModalEliminacio" >
            <div class="modal-content w-100">
                <div class="d-flex justify-content-center m-3 ">
                    <p>Producte Eliminat</p>
                </div>
            </div>
        </Modal>
        <Modal :show="showModalModificacio" maxWidth="2xl" closeable @close="cerrarModalModificacio" >

                    <VForm  class="w-100 rounded">
                        <div class="d-flex flex-column align-items-center m-4 ">
                            <InputLabel for="nom" value="Nom:" />
                             <VField
                                id="nom"
                                name="nom"
                                type="text"
                                v-model="formProducte.nom"
                                rules="required"
                                class="mt-1 block w-full"
                                style="color: black;"/>
                        <ErrorMessage name="Nom" />
                        </div>
                        <div class="d-flex flex-column align-items-center m-4">
                            <InputLabel for="descripcio" value="Descripcio:" />
                            <VField
                                id="descripcio"
                                name="descripcio"
                                type="text"
                                v-model="formProducte.descripcio"
                                rules="required"
                                class="mt-1 block w-full"
                                style="color: black;"
                            />
                            <ErrorMessage name="Descripcio" />
                        </div>
                        <div class="d-flex flex-column align-items-center m-4 ">
                            <InputLabel for="imatge" value="Imatge:"  v-model="formProducte.imatge"/>
                            <VField
                                id="imatge"
                                name="imatge"
                                type="file"
                                rules="required"
                                class="mt-1 block w-full"
                                @change="obtenirImatge"
                                />
                            </div>
                        <div class="d-flex flex-column align-items-center m-4">
                                <div>Categoria de Producte</div>
                                <select id="idCategoriaProducte" v-model="formProducte.idCategoriaProducte" style="color: black;">
                                    <option v-for="categoria in categoriesProducte"  v-bind:key="categoria.idCategoriaProductes" v-bind:value="categoria.idCategoriaProductes">
                                        {{ categoria.nom }}
                                    </option>
                                    <option >
                                        {{ "Sense Categoria" }}
                                    </option>
                                </select>
                            </div>
                        <div class="d-flex flex-column align-items-center m-4">
                                <div>Expansió</div>
                                <select  id="idExpansio" v-model="formProducte.idExpansio" style="color: black;">
                                    <option v-for="expansio in expansions" v-bind:key="expansio.idExpansio" v-bind:value="expansio.idExpansio">
                                        {{ expansio.nom }}
                                    </option>
                                    <option >
                                        {{ "Sense Expansio" }}
                                    </option>
                                </select>
                            </div>
                        <div class="d-flex flex-column align-items-center m-4 ">
                                <div>Carta a la que fa referencia</div>
                                <select  id="idCarta" v-model="formProducte.idCarta" style="color: black;">
                                    <option v-for="carta in cartes" v-bind:key="carta.idCarta" v-bind:value="carta.idCarta">
                                        {{ carta.nom }}
                                    </option>
                                    <option >
                                        {{ "No Carta" }}
                                    </option>
                                </select>
                            </div>
                        <div class="d-flex flex-column align-items-center m-4">
                            <figure>
                                <img width="200" height="200" :src="imatgeUrl">
                            </figure>
                        </div>
                        <div class="d-flex justify-content-center m-3 ">
                             <button type="button" class="btn btn-success mr-5"  @click="modProducte">Guardar</button>
                            <button type="button" class="btn btn-danger ml-5"
                                    @click="cerrarModalModificacio">Cancelar</button>
                        </div>
                    </VForm>
        </Modal>
        <Modal :show="showModalModificacioConfirmacio" maxWidth="2xl" closeable @close="cerrarModalModificacio" >
            <div class="modal-content w-100">
                <div class="d-flex justify-content-center m-3 ">
                    <p>Operació realitzada!</p>
                </div>
            </div>
        </Modal>
        <Modal :show="showModalOferta" maxWidth="2xl" closeable @close="cerrarModalOferta">
            <div class="modal-content w-100">
                <div class="d-flex justify-content-center m-3">
                    <form class="w-100 rounded">
                        <div class="m-2 text-center font-weight-bold">
                            Producte seleccionat: {{ formOferta.nomProducte }}
                            <div class="m-2 text-center font-weight-bold">
                                <InputLabel for="quantitat" value="Quantitat" class="m-2" style="font-size: 16px;" />
                                <div class="d-flex justify-content-center">
                                <input
                                    id="quantitat"
                                    type="number"
                                    class="mt-1 block w-full"
                                    v-model="formOferta.quantitatDisponible"
                                    min="1"
                                    step="1"
                                    required
                                    style="color: black; width: 100px;"
                                />
                                </div>
                            </div>
                            <div class="m-2 text-center font-weight-bold">
                                <InputLabel for="preuUnitari" value="Preu Unitari" />
                            <div class="d-flex justify-content-center">
                                <TextInput
                                    id="preuUnitari"
                                    type="number"
                                    class="mt-1 block w-full"
                                    v-model="formOferta.preuUnitari"
                                    min="0"
                                    required
                                    step="0.01"
                                    style="color: black; width: 100px;"
                                />
                            </div  >
                            </div>
                            <div class="d-flex justify-content-center m-3">
                                <button type="button" class="btn btn-success ml-5" @click="crearOferta">Crear Oferta</button>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </Modal>

        <Modal :show="showModalImage" maxWidth="2xl" closeable @close="closeImageModal" >
            <div class="d-flex justify-content-center p-5">
                <img :src="'/images/' + selectedImage" width="500" height="600">
            </div>
        </Modal>
        <div class="d-flex justify-content-center m-3 " v-if="$page.props.auth.user.idRol==1 ||$page.props.auth.user.idRol==2 ">
            <b-button class="btn btn-success rounded-pill" style="width: 200px;" @click="abrirModalInsert">Crear Nou producte</b-button>
        </div>

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
    color: black;
}


</style>
