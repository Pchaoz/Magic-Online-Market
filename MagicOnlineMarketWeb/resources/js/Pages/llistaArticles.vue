<script setup>
import AuthenticatedLayout from "@/Layouts/AuthenticatedLayout.vue";
import {ref} from "vue";
import {useForm} from "@inertiajs/vue3";
import 'bootstrap/dist/css/bootstrap.css';
import Modal from "@/Components/Modal.vue";
import InputLabel from "@/Components/InputLabel.vue";


defineProps({
    articles:{
        type: Array(String),
    },


});

let showModalOferta=ref(false);
let showModalEliminacio = ref(false);
let showModalEliminacioConfirmacio = ref(false);

const formOferta= useForm({
    idArticle:null,
    quantitatDisponible: 0,
    preuUnitari:0,
})

const abrirModalModArticle =(article)=> {
    formOferta.idArticle = article.idArticle;
    formOferta.quantitatDisponible = article.quantitat;
    formOferta.preuUnitari = article.preu;
    showModalOferta.value = true;
}
    const cerrarModalOferta = () => {
        showModalOferta.value=false;
    }

    const ModOferta =()=> {
        formOferta.get('/modificarArticle');
        cerrarModalOferta();
        recargaPaginaOferta();
    }

    const recargaPaginaOferta = () => {

        location.reload();
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
        location.reload();

    }

let selectedImage = ref(null);
let showModalImage = ref(false);

const openImageModal = (image) => {
    selectedImage.value = image;
    showModalImage.value = true;
}

const closeImageModal = () => {
    selectedImage.value = null;
    showModalImage.value = false;
}
//agregar al carrito

const agregarCarrito = (id) => {
    selectedImage.value = null;
    showModalImage.value = false;
}



</script>

<template>
    <AuthenticatedLayout>
        <div class="d-flex justify-content-center m-3 ">
            <table class="table  table-striped  my-table w-50 ">
                <thead>
                <tr>
                    <th class="col-1">Imatge</th>
                    <th class="col-2">Nom Article</th>
                    <th class="col-1">Venedor</th>
                    <th class="col-1">Quantitat</th>
                    <th class="col-1">Preu</th>
                    <th class="col-1"></th>
                    <th class="col-1"></th>
                    <th class="col-1"></th>
                    <th class="col-1"></th>
                </tr>
                </thead>
                <tbody>
                <tr v-for="article in articles" :key="article.id">
                    <td>
                        <div class="d-flex justify-content-center m-3 ">
                        <img :src="/images/+'camara.png'" alt="Imagen Foto" width="25" height="25" style="filter: brightness(0) invert(1);" @click="openImageModal(article.imatge)">
                        </div>
                    </td>
                    <td>{{article.nom}}</td>
                    <td>{{article.nick}}</td>
                    <td>{{article.quantitat}}</td>
                    <td>{{article.preu}}</td>
                    <td>
                        <input type="number" class="form-control" placeholder="qty" v-model="quantitatComprada">

                    </td>
                    <td>
                        <img :src="/images/+'carrito.png'" alt="Imagen carrito" width="25" height="25" style="filter: brightness(0) invert(1);"  @click="agregarCarrito(article.idArticle)">
                    </td>
                    <td>
                        <button v-if="$page.props.auth.user.idUsuari===article.idVenedor || $page.props.auth.user.idRol==1 "  class="btn btn-success rounded-pill"
                                @click="abrirModalModArticle(article)">Modificar</button>
                    </td>
                    <td>
                        <button v-if="$page.props.auth.user.idUsuari===article.idVenedor||$page.props.auth.user.idRol==1 " class="btn btn-danger rounded-pill"
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
                                    <input
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
                            <div class="d-flex justify-content-center m-3 p-3">
                                <button type="button" class="btn btn-success mr-5" @click="ModOferta">Modificar Oferta</button>
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

        <Modal :show="showModalImage" maxWidth="2xl" closeable @close="closeImageModal" >
            <div class="d-flex justify-content-center p-5">
                <img :src="'/images/' + selectedImage" width="500" height="600">
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
