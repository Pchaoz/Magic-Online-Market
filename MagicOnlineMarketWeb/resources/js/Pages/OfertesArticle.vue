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

const formOferta= useForm({
    idArticle:null,
    quantitatDisponible: 0,
    preuUnitari:0,
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

const ModOferta =()=> {
    formOferta.get('modArticle');
   // cerrarModalOferta();
    //recargaPaginaOferta();
}

const recargaPaginaOferta = () => {

    location.reload();
}


</script>

<template>
    <AuthenticatedLayout>

        <div class="rounded mx-auto" style="background-color: black; padding: 50px; margin: 50px; width: 1000px">
            <b-container class="d-flex bg-gray-500">
                <b-row class="d-flex w-75 m-3">
                    <b-col cols="6">
                        <img :src="'/images/' + producte[0].imatge" alt="Foto del producto"  style="height: 350px; width: 300px " />                    </b-col>
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
                <table class="table table-striped table-dark w-50 ">
                    <thead>
                    <tr>
                        <th>Nick Venedor</th>
                        <th>Quantitat</th>
                        <th>Preu</th>
                        <th></th>
                        <th></th>
                        <th></th>
                    </tr>
                    </thead>
                    <tbody>
                    <tr v-for="article in articles" :key="article.id">
                        <td>{{article.nick}}</td>
                        <td>{{article.quantitat}}</td>
                        <td>{{article.preu}}</td>
                        <td>
                            <img :src="/images/+'carrito.png'" alt="Imagen carrito" width="25" height="25" style="filter: brightness(0) invert(1);">
                        </td>
                        <td>
                            <button v-if="$page.props.auth.user.idUsuari===article.idVenedor" class="btn btn-primary rounded-circle"
                                    @click="abrirModalModArticle(article)">Mod</button>
                        </td>
                        <td>
                            <button v-if="$page.props.auth.user.idUsuari===article.idVenedor" class="btn btn-primary rounded-circle"
                                    @click="">Elim</button>
                        </td>

                    </tr>
                    </tbody>
                </table>
        </div>

        <Modal :show="showModalOferta" maxWidth="2xl" closeable @close="cerrarModalOferta">
            <div class="modal-content w-100">
                <span class="close" @click="cerrarModalOferta">×</span>
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
                                <button type="button" class="btn btn-success ml-5" @click="ModOferta">Modificar Oferta</button>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </Modal>
    </AuthenticatedLayout>
</template>

<style scoped>

</style>
