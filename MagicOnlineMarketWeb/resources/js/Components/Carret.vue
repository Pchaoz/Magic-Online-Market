<script setup>
import 'bootstrap/dist/css/bootstrap.min.css';
import Modal from "@/Components/Modal.vue";
import {ref} from "vue";
import {useForm} from "@inertiajs/vue3";


const  articlesCarrito= JSON.parse(localStorage.getItem("articlesCarrito"))|| [];

let showModalCarret =ref(false);
let showModal =ref(false);
const abrirModalCarret =()=> {
    showModalCarret.value = true;
}
const cerrarModalCarret =()=> {
    showModalCarret.value = false;
}



const limpiarLocalStorage = () => {
    localStorage.clear();
    location.reload();
}

const confirmarCompra = (articles) => {

    const comandas = [];
    articles.forEach((articulo) => {


        let comandaExistente = comandas.find(comanda => comanda.idVenedor === articulo.idVenedorArticles);
        let totalLinia= articulo.qtyComprada*articulo.preuArticleComprat;

        if (comandaExistente) {
            comandaExistente.linias.push({
                idArticle: articulo.idArticleComprat,
                qty: articulo.qtyComprada,

            });
            comandaExistente.totalComanda +=totalLinia;
        } else {

            comandas.push({
                idVenedor: articulo.idVenedorArticles,
                totalComanda:totalLinia,
                linias: [{
                    idArticle: articulo.idArticleComprat,
                    qty: articulo.qtyComprada,
                }]
            });
        }
    })

    const formComanda= useForm({
        idVenedor:"",
        totalComanda:0,
        linies:[],
    })
    const formLinia= useForm({
        idArticle:"",
        idComanda:"",
        qtyLinia:0,

    })


    comandas.forEach((comanda) => {
        formComanda.idVenedor = comanda.idVenedor;
        formComanda.totalComanda = comanda.totalComanda;
        formComanda.linies = comanda.linias.map(linia => ({
            idArticle: linia.idArticle,
            qtyLinia: linia.qty,
        }));

        formComanda.post('/crearComanda');
    });
   
}





</script>

<template>


    <div class="ms-3 relative">

        <button
            class="inline-flex items-center px-3 py-2 border border-transparent text-sm leading-4 font-medium rounded-md text-gray-500 bg-white hover:text-gray-700 focus:outline-none transition ease-in-out duration-150"
            @click="abrirModalCarret()">
            Carret
        </button>

    </div> <Modal :show="showModalCarret" maxWidth="2xl" closeable @close="cerrarModalCarret">
    <div class="modal-content w-100">
        <div class="d-flex justify-content-center m-3">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="exampleModalLabel">Carret de compra</h5>
                </div>
                <div class="modal-body">
                    <table class="table my-table">
                        <thead>
                        <tr>
                            <th>Nom Article</th>
                            <th>Preu</th>
                            <th>Quantitat</th>
                            <th>Total</th>
                        </tr>
                        </thead>
                        <tbody>
                        <tr v-for="article in articlesCarrito" :key="article.id">
                            <td>{{article.nomArticleComprat}}</td>
                            <td>{{article.preuArticleComprat}}</td>
                            <td>{{article.qtyComprada}}</td>
                            <td>{{(article.qtyComprada * article.preuArticleComprat).toFixed(2)}}</td>
                        </tr>
                        </tbody>
                    </table>
                </div>
                <div class="d-flex justify-content-center m-3 ">
                <button class="btn btn-success rounded-pill ml-5"  @click="confirmarCompra(articlesCarrito)">Confirmar compra</button>
                </div >
                <div class="modal-footer">
                    <button class="btn btn-danger rounded-pill ml-5"  @click="limpiarLocalStorage">Buidar Carret</button>
                </div>
            </div>
        </div>
    </div>
</Modal>

    <Modal :show="showModal" maxWidth="2xl" >
        <div class="modal-content w-100">
            <div class="d-flex justify-content-center m-3 ">
                <p>Comandes realitzades!</p>
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
