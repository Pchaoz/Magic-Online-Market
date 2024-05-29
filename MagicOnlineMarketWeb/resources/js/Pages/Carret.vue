<script setup>
import 'bootstrap/dist/css/bootstrap.min.css';
import Modal from "@/Components/Modal.vue";
import {ref} from "vue";
import axios from 'axios';
import {useForm} from "@inertiajs/vue3";
import { computed } from 'vue';

let comandes = ref([]);
let showModalCarret = ref(false);
let showModalconfirmarCompra = ref(false)
let showModalBuidarCarret = ref(false)
let showModalEliminacio  = ref(false)
let showModalEliminacioConfirmacio = ref(false)

const auxform= useForm({
    idLinia:"",
    quantitatLinia:0,
    preuLinia:0,
    idComanda:"",

})
function cerrarModals() {
    showModalCarret.value=false;
    showModalconfirmarCompra.value=false;
    showModalBuidarCarret.value=false;
}


async function abrirModalCarret() {
    try {
        const response = await axios.get('/listComandesCompraUser');
        comandes.value = response.data;
        showModalCarret.value = true;
    } catch (error) {
        console.error(error);
    }
}

function confirmarCompra () {
    auxform.post('/confirmarCompra');
    setTimeout(() => {
        window.location.href = '/listComandesCompres';
    }, 500);
}

 function cancelarCompra () {
       auxform.delete('/buidarCompra');
       showModalBuidarCarret.value = true;
     setTimeout(() => {
         cerrarModals();
     }, 500);
}

const abrirModalEliminacio = (linia) =>{
    showModalEliminacio.value=true;
    auxform.idLinia=linia.idLinia;
    auxform.quantitatLinia= linia.qtyComprada;
    auxform.preuLinia=linia.preuArticleComprat ;
    auxform.idComanda=linia.idComanda ;

}

const eliminarLinia =()=> {
    auxform.delete('/eliminarLiniaCarret');
    recargaPaginaElim();
}

const recargaPaginaElim = () => {
    showModalEliminacio.value=false;
    showModalEliminacioConfirmacio.value=true;
    setTimeout(() => {
        showModalEliminacioConfirmacio.value=false;
        abrirModalCarret();
    }, 500);
}
const cerrarModalEliminacio = () => {
    showModalEliminacio.value=false;
    showModalEliminacioConfirmacio.value=false;
}

const total = computed(() => {
    return comandes.value.reduce((sum, comanda) => sum + comanda.qtyComprada * comanda.preuArticleComprat, 0);
});

</script>

<template>


    <div class="ms-3 relative">

        <button
            class="inline-flex items-center px-3 py-2 border border-transparent text-sm leading-4 font-medium rounded-md text-gray-500 bg-white hover:text-gray-700 focus:outline-none transition ease-in-out duration-150"
            @click="abrirModalCarret()">
            Carret
        </button>

    </div> <Modal :show="showModalCarret" maxWidth="2xl" closeable @close="cerrarModals">
    <div class="modal-content w-100">
        <div class="d-flex justify-content-center m-3">
            <div class="modal-content">
                <div class="d-flex justify-content-center p-2">
                    <h5 class="modal-title" id="exampleModalLabel">Carret de compra</h5>
                </div>
                <div class="modal-body">
                    <table class="table my-table">
                        <thead>
                        <tr>
                            <th>Nom Article</th>
                            <th>Nom Venedor</th>
                            <th>Preu</th>
                            <th>Quantitat</th>
                            <th>Total</th>
                            <th></th>
                        </tr>
                        </thead>
                        <tbody>
                        <tr v-for="comanda in comandes" :key="comanda.id">
                            <td>{{comanda.nomArticleComprat}}</td>
                            <td>{{comanda.nickVenedor}}</td>
                            <td>{{comanda.preuArticleComprat}}</td>
                            <td>{{comanda.qtyComprada}}</td>
                            <td>{{(comanda.qtyComprada * comanda.preuArticleComprat).toFixed(2)}}</td>
                            <td>
                                <img :src="/images/+'paperera.png'" alt="Imatge paperera" width="25" height="25" style="filter: brightness(0) invert(1);"  @click="abrirModalEliminacio(comanda)">
                            </td>
                        </tr>
                        </tbody>
                        <tfoot>
                            <tr>
                                <td colspan="3"></td>
                                <td> <b>Total: </b></td>
                                <td>{{ total.toFixed(2) }}</td>
                                <td></td>
                            </tr>
                        </tfoot>
                    </table>
                </div>
                <div class="d-flex justify-content-center m-3 ">
                    <button class="btn btn-success rounded-pill mr-5"  @click="confirmarCompra">Confirmar comandes</button>
                    <button class="btn btn-danger rounded-pill mrl-5"  @click="cancelarCompra">Buidar Carret</button>
                </div >
            </div>
        </div>
    </div>
</Modal>

    <Modal :show="showModalconfirmarCompra" maxWidth="2xl" @close="cerrarModals">
        <div class="modal-content w-100">
            <div class="d-flex justify-content-center m-3 ">
                <p>Comandes realitzades!</p>
            </div>
        </div>
    </Modal>
    <Modal :show="showModalBuidarCarret" maxWidth="2xl" @close="cerrarModals">
        <div class="modal-content w-100">
            <div class="d-flex justify-content-center m-3 ">
                <p>Carret buidat!</p>
            </div>
        </div>
    </Modal>
    <Modal :show="showModalEliminacio" maxWidth="2xl" closeable @close="cerrarModalEliminacio" >
        <div class="modal-content w-100">

            <div class="d-flex justify-content-center m-3 ">
                <p>¿Estas segur de que vols eliminar aquesta linia?</p>
            </div>
            <div class="d-flex justify-content-center m-3 ">
                <button type="button" class="btn btn-success mr-5"
                        @click="eliminarLinia">Sí</button>
                <button type="button" class="btn btn-danger ml-5" @click="cerrarModalEliminacio">No</button>

            </div>
        </div>
    </Modal>

    <Modal :show="showModalEliminacioConfirmacio" maxWidth="2xl" closeable @close="cerrarModalEliminacio" >
        <div class="modal-content w-100">

            <div class="d-flex justify-content-center m-3 ">
                <p>Linia Eliminada</p>
            </div>
        </div>
    </Modal>
</template>



<style scoped>
.my-table td, .my-table th {
    background-color: rgba(0,214,153,0.5) !important;
    text-align: center;
    vertical-align: middle;
}
</style>
