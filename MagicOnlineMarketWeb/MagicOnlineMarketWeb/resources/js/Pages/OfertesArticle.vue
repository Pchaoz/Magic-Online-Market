<script setup>
import 'bootstrap/dist/css/bootstrap.css';


import AuthenticatedLayout from "@/Layouts/AuthenticatedLayout.vue";
import InputLabel from "@/Components/InputLabel.vue";
import Modal from "@/Components/Modal.vue";
import TextInput from "@/Components/TextInput.vue";
import {ref} from "vue";
import {useForm} from "@inertiajs/vue3";

defineProps({
    producte: {
        type: Array(String),
    },

    articles:{
        type: Array(String),
    },


});

let showModalOferta=ref(false);
let showModalEliminacio = ref(false);
let showModalEliminacioConfirmacio = ref(false);
let showModalQuantitat = ref(false);
let showModalQuantitatIncorrecta = ref(false);


const formOferta= useForm({
    idArticle:null,
    quantitatDisponible: 0,
    preuUnitari:0,
})

const articleAfegit= useForm({
    idArticle:"",
    idVenedor:"",
    nomArticle:"",
    preuArticle:0,
    quantitatProducte:0,
    quantitatComprada:0,
})

const abrirModalModArticle =(article)=>{
    formOferta.idArticle=article.idArticle;
    formOferta.quantitatDisponible= article.quantitat;
    formOferta.preuUnitari=article.preu;
    showModalOferta.value=true;

}

const cerrarModalOferta = () => {
    showModalOferta.value=false;
}

const ModArticle =()=> {
    if(formOferta.quantitatDisponible<=0|| formOferta.preuUnitari<=0){
        cerrarModalOferta()
        abrirModalQuantitatIncorrecta();
    }else{
        formOferta.get('/modificarArticle');
        recargaPaginaOferta();
    }

}

const recargaPaginaOferta = () => {
    setTimeout(() => {
        useForm.visit(window.location.pathname);
    }, 500);
}


const abrirModalEliminacio = (article) =>{
    showModalEliminacio.value=true;
    formOferta.idArticle=article.idArticle;
    formOferta.quantitatDisponible= null;
    formOferta.preuUnitari=null;

}
const cerrarModalEliminacio = () => {
    showModalEliminacio.value=false;
    showModalEliminacioConfirmacio.value=false;
}

const eliminarArticle =()=> {
    formOferta.get('/eliminarArticle');
    recargaPaginaElim();
}

const recargaPaginaElim = () => {
    showModalEliminacio.value=false;
    showModalEliminacioConfirmacio=true;
    setTimeout(() => {
        showModalEliminacioConfirmacio=false;
        useForm.visit(window.location.pathname);
    }, 500);
}

const cerrarModalQuantitat = () => {
    showModalQuantitat.value=false;
    articleAfegit.idArticle="";
    articleAfegit.idVenedor="";
    articleAfegit.nomArticle="";
    articleAfegit.preuArticle=0;
    articleAfegit.quantitatComprada=0;

}

//agregar al carrito
const agregarCarrito = () => {
    if(articleAfegit.quantitatComprada <= 0 || articleAfegit.quantitatProducte < articleAfegit.quantitatComprada ){
        showModalQuantitat.value=false;
        abrirModalQuantitatIncorrecta();
    }else{
        articleAfegit.post('/agregarArticleComanda');
        cerrarModalQuantitat();
        setTimeout(() => {
            useForm.visit(window.location.pathname);
        }, 500);
    }

}
const abrirModalQuantitat = (article) => {
    articleAfegit.idArticle=article.idArticle;
    articleAfegit.idVenedor=article.idVenedor;
    articleAfegit.quantitatProducte=article.quantitat;
    articleAfegit.nomArticle=article.nom;
    articleAfegit.preuArticle=article.preu;
    articleAfegit.quantitatComprada=1;
    showModalQuantitat.value=true;
}

const cerrarModalQuantitatIncorrecta=()=>{
    showModalQuantitatIncorrecta.value =false;
}

const abrirModalQuantitatIncorrecta = () => {
    showModalQuantitatIncorrecta.value =true;

}
</script>

<template>
    <AuthenticatedLayout>
        <div class="rounded mx-auto" style="background-color: rgba(0,214,153,0.6); padding: 50px; margin-top: 50px; margin-bottom: 20px; width: 1000px">
            <b-container class="d-flex" style="background-color: rgba(128,128,128,0.6)" >
                <b-row class="d-flex w-75 m-3">
                    <b-col cols="6">
                        <img :src="'/images/' + producte[0].imatge" alt="Foto del producto"  style="height: 350px; width: 300px " />
                    </b-col>
                    <b-col cols="6" class="text-white m-3">
                    <h2>{{ producte[0].nom }}</h2>
                        <p>Categoria de producte: {{ producte[0].categoriaProducteNom }}</p>
                        <p>Expansió del producte: {{ producte[0].expansioNom }}</p>
                    </b-col>
                </b-row>
            </b-container>
        </div>
        <h2 class="text-center">Ofertes del producte</h2>

            <div class="d-flex justify-content-center m-3 ">
                <table class="table  table-striped  my-table w-50 ">
                    <thead>
                    <tr>
                        <th class="col-2">Venedor</th>
                        <th class="col-2">Quantitat</th>
                        <th class="col-2">Preu Unitari</th>
                        <th class="col-1"></th>
                        <th class="col-1" v-if="$page.props.auth.user.idRol=='1' || $page.props.auth.user.idRol=='5' ||$page.props.auth.user.idRol=='4'" ></th>
                        <th class="col-1" v-if="$page.props.auth.user.idRol=='1' || $page.props.auth.user.idRol=='5' ||$page.props.auth.user.idRol=='4'" ></th>

                    </tr>
                    </thead>
                    <tbody>
                    <tr v-for="article in articles" :key="article.id">
                        <td>{{article.nick}}</td>
                        <td>{{article.quantitat}}</td>
                        <td>{{article.preu}}</td>
                        <td>
                            <img :src="/images/+'carrito.png'" alt="Imagen carrito" width="25" height="25" style="filter: brightness(0) invert(1);"  @click="abrirModalQuantitat(article)">
                        </td>
                        <td v-if="$page.props.auth.user.idRol=='1' || $page.props.auth.user.idRol=='5' ||$page.props.auth.user.idRol=='4'">
                            <button v-if="$page.props.auth.user.idUsuari===article.idVenedor || $page.props.auth.user.idRol=='1' "  class="btn btn-success rounded-pill"
                                    @click="abrirModalModArticle(article)">Modificar</button>
                        </td>
                        <td v-if="$page.props.auth.user.idRol=='1' || $page.props.auth.user.idRol=='5' ||$page.props.auth.user.idRol=='4'">
                            <button v-if="$page.props.auth.user.idUsuari===article.idVenedor||$page.props.auth.user.idRol=='1' " class="btn btn-danger rounded-pill"
                                    @click="abrirModalEliminacio(article)">Eliminar</button>
                        </td>


                    </tr>
                    </tbody>
                </table>
        </div>

        <Modal :show="showModalOferta" maxWidth="2xl" closeable @close="cerrarModalOferta">
            <div class="modal-content w-100">
                <div class="d-flex justify-content-center m-3">
                    <form class="w-100 rounded">
                        <div class="m-2 text-center font-weight-bold">
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
                            <div class="d-flex justify-content-center m-3 p-3">
                                <button type="button" class="btn btn-success mr-5" @click="ModArticle">Modificar Oferta</button>
                                <button type="button" class="btn btn-danger ml-5" @click="cerrarModalOferta">Cancelar</button>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </Modal>
        <Modal :show="showModalEliminacio" maxWidth="2xl" closeable @close="cerrarModalEliminacio" >
            <div class="modal-content w-100">

                <div class="d-flex justify-content-center m-3 ">
                    <p>¿Estas segur de que vols eliminar aquest article?</p>
                </div>
                <div class="d-flex justify-content-center m-3 ">
                    <button type="button" class="btn btn-success mr-5"
                            @click="eliminarArticle">Sí</button>
                    <button type="button" class="btn btn-danger ml-5" @click="cerrarModalEliminacio">No</button>

                </div>
            </div>
        </Modal>
        <Modal :show="showModalEliminacioConfirmacio" maxWidth="2xl" closeable @close="cerrarModalEliminacio" >
            <div class="modal-content w-100">

                <div class="d-flex justify-content-center m-3 ">
                    <p>Article Eliminat</p>
                </div>
            </div>
        </Modal>
        <Modal :show="showModalQuantitat" maxWidth="2xl" closeable @close="cerrarModalQuantitat" >
            <div class="modal-content w-100">

                <div class="d-flex justify-content-center m-3 ">
                    <p>Quants articles desitges comprar?</p>
                </div>
                <div class="d-flex justify-content-center">
                    <input
                        id="quantitatComprada"
                        type="number"
                        placeholder="qty"
                        class="mt-1 block w-full"
                        v-model="articleAfegit.quantitatComprada"
                        :min="1"
                        :max="articleAfegit.quantitatProducte"
                        step="1"
                        required
                        style="color: black; width: 100px;"
                    />
                </div>
                <div class="d-flex justify-content-center m-3 ">
                    <button type="button" class="btn btn-success mr-5"
                            @click="agregarCarrito">Aceptar</button>
                    <button type="button" class="btn btn-danger ml-5" @click="cerrarModalQuantitat">Cancelar</button>

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
    </AuthenticatedLayout>
</template>

<style scoped>

.my-table td, .my-table th {
    background-color: rgba(0,214,153,0.8) !important;
    text-align: center;
    vertical-align: middle;
}

form {
    background-color:rgba(0,214,153,0.8) !important;

}


</style>
