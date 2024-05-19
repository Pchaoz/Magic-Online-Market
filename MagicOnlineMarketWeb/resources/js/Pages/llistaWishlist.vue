<script setup>



import AuthenticatedLayout from "@/Layouts/AuthenticatedLayout.vue";
import {useForm} from "@inertiajs/vue3";
import {ref} from "vue";
import Modal from "@/Components/Modal.vue";
import 'bootstrap/dist/css/bootstrap.css';
import InputLabel from "@/Components/InputLabel.vue";
import TextInput from "@/Components/TextInput.vue";
import InputError from "@/Components/InputError.vue";

defineProps({
    wishlists: {
        type: Array(String),
    }
});

let showModal = ref(false);
let showModalEliminacio = ref(false);
let showModalCreacio = ref(false);
let showModalCreacioConfirmacio=ref(false);
let showModalModificacio = ref(false);
let showModalModificacioConfirmacio=ref(false);


const form = useForm({
    idWishlist: null,
    nom:"",


});
//creacio wishlist
const cerrarModalCreacio = () =>{
    showModalCreacio.value=false;
    showModalCreacioConfirmacio.value=false;
}
const abrirModalCreacio = () =>{
    form.nom="";
    showModalCreacio.value=true;
}


const crearWishlist=()=> {

    form.post('/crearWishlist');
    confirmacionCreacio();
}


const confirmacionCreacio=()=>{
    showModalCreacio.value=false;
    showModalCreacioConfirmacio.value=true;
    setTimeout(() => {

        useForm.visit(window.location.pathname);
    }, 500);

}
</script>

<template>
    <AuthenticatedLayout>
        <div class="d-flex justify-content-center m-3 ">
            <h2>Llistat de Wishlist</h2>
        </div>
        <div class="d-flex justify-content-center m-3 ">
            <table class="table table-striped my-table w-50 ">
                <thead>
                <tr>
                    <th v-if=" $page.props.auth.user.idRol==1 || $page.props.auth.user.idRol==2">Propietari</th>
                    <th>Id Wishlist</th>
                    <th>Nom Wishlist</th>

                </tr>
                </thead>
                <tbody>
                <tr v-for="wishlist in wishlists" :key="wishlist.id"  >
                    <td v-if=" $page.props.auth.user.idRol==1 || $page.props.auth.user.idRol==2">{{wishlist.nickPropietari}}</td>
                    <td>{{wishlist.idWishlist}}</td>
                    <td>{{wishlist.nomWishlist}}</td>
                </tr>
                </tbody>
            </table>
        </div>
        <div class="d-flex justify-content-center m-3 ">
            <b-button class="btn btn-success rounded-pill" style="width: 200px;" @click="abrirModalCreacio">Crear Wishlist</b-button>
        </div>
        <Modal :show="showModalCreacio" maxWidth="2xl"  @submit="crearWishlist" closeable @close="cerrarModalCreacio" >
            <div class="modal-content w-100">
                <form class="w-100 rounded pt-1">
                    <div class="d-flex justify-content-center m-3 ">
                        <InputLabel for="nom" value="Nom Wishlist" class="m-2"  style="font-size: 16px;"/>
                        <TextInput id="nom" name="nom" type="text" v-model="form.nom" required class="mt-1 block w-full" style="color: black;" />
                        <InputError :message="form.errors.nom"  style="color: red; font-weight: bold;" />

                    </div>


                    <div class="d-flex justify-content-center m-3 ">
                        <button type="button" class="btn btn-success ml-5"
                                @click="crearWishlist">Crear</button>
                        <button type="button" class="btn btn-danger ml-5"
                                @click="cerrarModalCreacio">Cancelar</button>
                    </div>
                </form>
            </div>
        </Modal>

        <Modal :show="showModalCreacioConfirmacio" maxWidth="2xl" closeable @close="cerrarModalCreacio" >
            <div class="modal-content w-100">
                <div class="d-flex justify-content-between m-3 ">
                    <button @click="cerrarModalCreacio" style="border: none; background: none;">
                        <img :src="/images/+'cierre.jpg'" alt="Cerrar" />
                    </button>
                    <p>Wishlist Creat</p>
                    <div></div>
                </div>
            </div>
        </Modal>
        </AuthenticatedLayout>
</template>

<style scoped>
.my-table td, .my-table th {
    background-color: rgba(0,214,153,0.7) !important;
    text-align: center;
    vertical-align: middle;
}
</style>
