<script setup>

import AuthenticatedLayout from "@/Layouts/AuthenticatedLayout.vue";
import 'bootstrap/dist/css/bootstrap.css';
import Modal from "@/Components/Modal.vue";
import {useForm} from "@inertiajs/vue3";
import InputLabel from "@/Components/InputLabel.vue";
import TextInput from "@/Components/TextInput.vue";
import { ref, reactive, onMounted } from 'vue';


const props = defineProps({
    productes: {
        type: Array,
        default: () => ([]),
    },
    expansions:{
        type: Array,
        default: () => ([]),
    },
    categoriesProducte:{
        type: Array,
        default: () => ([]),
    },
    wishlists:{
        type: Array,
        default: () => ([]),
    },
});

let obj = ref(props.wishlists);
let targetArray = obj._value;
let firstObjectInArray = targetArray[0];


let showModalEliminacio = ref(false);
let showModalEliminacioConfirmacio = ref(false);
let showModalConfirmacioArticle= ref(false);
let showModalImage = ref(false);
let showModalOferta=ref(false);
let showModalWishlist = ref(false);
let showModalWishlistResult = ref(false);
let showModalSenseWishlist =ref(false);
let showModalQuantitatIncorrecta = ref(false);

const formProducte= useForm({
    idProducte:null,
})
const auxformInsert= useForm({

});


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
    formProducte.get('eliminarProducte');
    recargaPaginaElim();
}

const recargaPaginaElim = () => {
    showModalEliminacio.value=false;
    showModalEliminacioConfirmacio=true;
    setTimeout(() => {
        showModalEliminacioConfirmacio.value = false;
        useForm.visit(window.location.pathname);
    }, 500);

}

//modificació i inserció de productes

const crearProducte=()=> {
    auxformInsert.get('/formCrearProducte');
}

const modProducte =(id)=> {
    formProducte.idProducte=id;
    formProducte.get('/formModificarProducte');

}

//creacio d'oferta
const formOferta= useForm({
    idProducte:null,
    nomProducte:"",
    quantitatDisponible: 0,
    preuUnitari:0,
})

const formWishlist= useForm({
    idProducte:null,
    nomProducte:"",
    idWishlist:null,

})

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
    if(formOferta.quantitatDisponible<=0||formOferta.preuUnitari<=0){
        cerrarModalOferta();
        abrirModalQuantitatIncorrecta();
    }else{
        formOferta.get('/crearArticle');
        recargaPaginaOferta();
    }

}

const recargaPaginaOferta = () => {
    showModalConfirmacioArticle.value=true;
    setTimeout(() => {
        showModalConfirmacioArticle.value = false;
        useForm.visit(window.location.pathname);
    }, 500);
}
//maximizar imagen
let selectedImage = ref(null);

const openImageModal = (image) => {
    selectedImage.value = image;
    showModalImage.value = true;
}

const closeImageModal = () => {
    selectedImage.value = null;
    showModalImage.value = false;
}

//funcions per agregar productes a la wishlist

const abrirModalAgregarWishlist = (idProducte, nomProducte) => {
    if(firstObjectInArray===undefined){
        AvisoWishlist()
    }else{
        formWishlist.idProducte=idProducte;
        formWishlist.nomProducte=nomProducte;
        formWishlist.idWishlist= firstObjectInArray.idWishlist;
        showModalWishlist.value=true;
    }
}
const closeWishlist = () => {
    showModalWishlist.value = false;
    showModalWishlistResult.value = false;
    showModalSenseWishlist.value = false;
    formWishlist.idWishlist="";
}
const AvisoWishlist = () => {
    showModalSenseWishlist.value = true;

}

const afegirProducteWishlist=  () => {
    formWishlist.post("afegirProducteWishlist");
    recargaWishlist()
}

const recargaWishlist = () => {
    showModalWishlist.value=false;
    showModalWishlistResult.value=true;
    setTimeout(() => {
        useForm.visit(window.location.pathname);
    }, 500);
}

onMounted(() => {
    setTimeout(() => {
        visit(window.location.pathname);
    }, 500);
});

const cerrarModalQuantitatIncorrecta=()=>{
    showModalQuantitatIncorrecta.value =false;
}

const abrirModalQuantitatIncorrecta = () => {
    showModalQuantitatIncorrecta.value =true;
}

</script>

<template>
    <AuthenticatedLayout>
        <div class="d-flex justify-content-center m-3 ">
            <h2>Llista de productes</h2>
        </div>
        <div class="d-flex justify-content-center m-3 " >
            <table class="table table-striped my-table w-75" >
                <thead>
                <tr>
                    <th class="col-1"></th>
                    <th class="col-2">Nom Producte</th>
                    <th class="col-3">Descripcio Producte</th>
                    <th class="col-2">Categoria Producte</th>
                    <th class="col-2">Expansio Producte</th>
                    <th class="col-1" v-if="$page.props.auth.user.idRol==1 ||$page.props.auth.user.idRol==2 "></th>
                    <th class="col-1" v-if="$page.props.auth.user.idRol==1 ||$page.props.auth.user.idRol==2 "></th>
                    <th class="col-1" v-if="$page.props.auth.user.idRol==1 || $page.props.auth.user.idRol==5 ||$page.props.auth.user.idRol==4 "></th>
                    <th class="col-1" ></th>

                </tr>
                </thead>
                <tbody>
                <tr v-for="producte in productes" :key="producte.id">
                    <td>
                        <div class="d-flex justify-content-center m-3 ">
                            <img :src="/images/+'camara.png'" alt="Imagen Foto" width="25" height="25" style="filter: brightness(0) invert(1);" @click="openImageModal(producte.imatge)">
                        </div>
                    </td>
                    <td>
                        <a :href="'/veureArticlesProducte/' + producte.idProducte">{{ producte.nom }}</a>
                    </td>
                    <td>{{producte.descripcio}}</td>
                    <td> {{producte.categoriaProducteNom}} </td>
                    <td> {{producte.expansioNom}}</td>
                    <td v-if="$page.props.auth.user.idRol==1 ||$page.props.auth.user.idRol==2 ">
                        <b-button  class="btn btn-success rounded-pill"
                                   @click="modProducte(producte.idProducte)">Modificar</b-button>
                    </td>
                    <td v-if="$page.props.auth.user.idRol==1 ||$page.props.auth.user.idRol==2 ">

                        <b-button  class="btn btn-danger rounded-pill"
                                 @click="abrirModalEliminacio(producte.idProducte)">Eliminar</b-button>
                    </td>
                    <td  v-if="$page.props.auth.user.idRol==5 ||$page.props.auth.user.idRol==4 || $page.props.auth.user.idRol==1">

                        <b-button  class="btn btn-success rounded-pill"
                                   @click="abrirModalCreacioArticle(producte.idProducte,producte.nom)">Vendre</b-button>

                    </td>
                    <td >
                        <b-button  class="btn btn-success rounded-pill"
                                   @click="abrirModalAgregarWishlist(producte.idProducte,producte.nom)">Agregar Wishlist</b-button>
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
                                    :min="1"
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
                                    :min="0.01"
                                    required
                                    step="0.01"
                                    style="color: black; width: 100px;"
                                />
                            </div  >
                            </div>
                            <div class="d-flex justify-content-center m-3">
                                <button type="button" class="btn btn-success mr-5" @click="crearOferta">Crear Article</button>
                                <button type="button" class="btn btn-danger ml-5" @click="cerrarModalOferta">Cancelar</button>
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

        <Modal :show="showModalConfirmacioArticle" maxWidth="2xl"  >
            <div class="modal-content w-100">
                <div class="d-flex justify-content-center m-3 ">
                    <p>Article creat!</p>
                </div>
            </div>
        </Modal>
        <Modal :show="showModalWishlist" maxWidth="2xl" @close="closeWishlist" >
            <div class="modal-content w-100">
                <div class="d-flex justify-content-center m-3">
                    <form class="w-100 rounded">
                        <div class="m-2 text-center font-weight-bold">
                            <div class="m-2 text-center font-weight-bold">
                                <div class="p-4">
                                    Producte seleccionat: {{ formWishlist.nomProducte }}
                                </div>
                                <InputLabel for="wishlistNom" value="Afegir a Wishlist: " class="m-2" style="font-size: 16px;" />
                                <div class="d-flex justify-content-center">
                                    <select id="idCarta" v-model="formWishlist.idWishlist" style="color: black;">
                                        <option v-for="wishlist in wishlists" v-bind:key="wishlist.idWishlist" v-bind:value="wishlist.idWishlist">
                                            {{ wishlist.nom }}
                                        </option>
                                    </select>
                                </div>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
            <div class="d-flex justify-content-center m-3 ">
                <button class="btn btn-success col-2" @click="afegirProducteWishlist">Guardar</button>
                <div class="col-1"></div>
                <button class="btn btn-danger col-2 " @click="closeWishlist">Cancelar</button>
            </div>
        </Modal>
        <Modal :show="showModalWishlistResult" maxWidth="2xl" closeable @close="closeWishlist" >
            <div class="modal-content w-100">
                <button class="p-2" @click="closeWishlist" style="border: none; background: none;">
                    <img :src="/images/+'cierre.jpg'" alt="Cerrar" style="width: 10px; height: 10px;" />
                </button>
                <div class="d-flex justify-content-center m-3 ">
                    <p>Wishlist Actualitzada amb el producte!</p>
                </div>
            </div>
        </Modal>
        <Modal :show="showModalSenseWishlist" maxWidth="2xl" closeable @close="closeWishlist" >
            <div class="modal-content w-100">
                <button class="p-2" @click="closeWishlist" style="border: none; background: none;">
                    <img :src="/images/+'cierre.jpg'" alt="Cerrar" style="width: 10px; height: 10px;" />
                </button>
                <div class="d-flex justify-content-center m-3 ">
                    <p>Primer has de crear una Wishlist!</p>
                </div>
            </div>
        </Modal>
        <Modal :show="showModalQuantitatIncorrecta" maxWidth="2xl" closeable @close="cerrarModalQuantitatIncorrecta" >
            <div class="modal-content w-100">
                <div class="d-flex justify-content-between m-3 align-items-start">
                    <button @click="cerrarModalQuantitatIncorrecta" style="border: none; background: none;">
                        <img :src="/images/+'cierre.jpg'" alt="Cerrar" style="width: 10px; height: 10px;" />
                    </button>
                    <p>Quantitat Incorrecta!</p>
                    <div></div>
                </div>
            </div>
        </Modal>

        <div class="d-flex justify-content-center m-3 " v-if="$page.props.auth.user.idRol==1 ||$page.props.auth.user.idRol==2 ">
            <b-button class="btn btn-success rounded-pill" style="width: 200px;" @click="crearProducte">Crear Nou producte</b-button>
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

}

</style>
