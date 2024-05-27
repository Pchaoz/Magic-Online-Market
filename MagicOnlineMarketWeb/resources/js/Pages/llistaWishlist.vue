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
let showModalEliminacioConfirmacio = ref(false);
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

//eliminacio wishlist
const abrirModalEliminacio=  (wishlist) =>{
    form.idWishlist=wishlist.idWishlist;
    showModalEliminacio.value=true;
}

const cerrarModalEliminacio = () =>{
    showModalEliminacio.value=false;
    showModalEliminacioConfirmacio.value=false;
}

const eliminarWishlist=()=> {
    form.delete('/eliminarWishlist');
    confirmacionEliminacio();
}

const confirmacionEliminacio=()=>{
    showModalEliminacio.value=false;
    showModalEliminacioConfirmacio.value=true;
    setTimeout(() => {

        useForm.visit(window.location.pathname);
    }, 500);

}

//modificacio wishlist
const cerrarModalModificacio = () =>{
    showModalModificacio.value=false;
    showModalModificacioConfirmacio.value=false;
}

const abrirModalModificacio=  (wishlist) =>{
    form.idWishlist=wishlist.idWishlist;
    form.nom=wishlist.nomWishlist;
    showModalModificacio.value=true;
}

const modWishlist=()=> {
    form.post('/modWishlist');
    confirmacionMod();
}

const confirmacionMod=()=>{
    showModalModificacio.value=false;
    showModalModificacioConfirmacio.value=true;
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
                    <th></th>
                    <th></th>

                </tr>
                </thead>
                <tbody>
                <tr v-for="wishlist in wishlists" :key="wishlist.id"  >
                    <td v-if=" $page.props.auth.user.idRol==1 || $page.props.auth.user.idRol==2">{{wishlist.nickPropietari}}</td>
                    <td>{{wishlist.idWishlist}}</td>
                    <td>
                    <a :href="'/veureWishlist/' + wishlist.idWishlist">{{wishlist.nomWishlist}}</a>
                    </td>
                    <td>
                        <button class="btn btn-success rounded-pill"
                                @click="abrirModalModificacio(wishlist)">Modificar</button>
                    </td>
                    <td>
                        <button class="btn btn-danger rounded-pill"
                                @click="abrirModalEliminacio(wishlist)">Eliminar</button>
                    </td>
                </tr>
                </tbody>
            </table>
        </div>
        <div class="d-flex justify-content-center m-3 ">
            <b-button class="btn btn-success rounded-pill" style="width: 200px;" @click="abrirModalCreacio">Crear Wishlist</b-button>
        </div>
        <Modal :show="showModalCreacio" maxWidth="2xl"    @close="cerrarModalCreacio" >
            <div class="modal-content w-100">
                <form class="w-100 rounded pt-1" @submit="crearWishlist" >

                    <div class="d-flex justify-content-center m-3 ">
                        <InputLabel for="nom" value="Nom Wishlist"/>
                        <TextInput id="nom"  type="text" v-model="form.nom" required autofocus
                                   autocomplete="nom" class="mt-1 block w-full"  maxlength="40" style="color: black;" />
                        <InputError class="mt-2" :message="form.errors.nom" />
                    </div>
                    <div class="d-flex justify-content-center m-3 ">

                        <button  class="btn btn-success ml-5" >Crear</button>
                        <button type="button" class="btn btn-danger ml-5"
                                @click="cerrarModalCreacio">Cancelar</button>
                    </div>
                </form>
            </div>
        </Modal>

        <Modal :show="showModalCreacioConfirmacio" maxWidth="2xl" closeable @close="cerrarModalCreacio" >
            <div class="modal-content w-100">
                <div class="d-flex justify-content-between m-3 align-items-start">
                    <button @click="cerrarModalCreacio" style="border: none; background: none;">
                        <img :src="/images/+'cierre.jpg'" alt="Cerrar" style="width: 10px; height: 10px;" />
                    </button>
                    <p>Wishlist Creat!</p>
                    <div></div>
                </div>
            </div>
        </Modal>

        <Modal :show="showModalEliminacio" maxWidth="2xl" closeable @close="cerrarModalEliminacio" >
            <div class="modal-content w-100">
                <div class="d-flex justify-content-center m-3 ">
                    <p>¿Estas segur de que vols eliminar aquesta wishlist?</p>
                </div>
                <div class="d-flex justify-content-center m-3 ">
                    <button type="button" class="btn btn-success mr-5"
                            @click="eliminarWishlist">Sí</button>
                    <button type="button" class="btn btn-danger ml-5" @click="cerrarModalEliminacio">No</button>
                </div>
            </div>
        </Modal>
        <Modal :show="showModalEliminacioConfirmacio" maxWidth="2xl" closeable @close="cerrarModalEliminacio" >
            <div class="modal-content w-100">
                <div class="d-flex justify-content-between m-3 align-items-start">
                    <button @click="cerrarModalEliminacio" style="border: none; background: none;">
                        <img :src="/images/+'cierre.jpg'" alt="Cerrar" style="width: 10px; height: 10px;" />
                    </button>
                    <div class="d-flex justify-content-center align-items-center m-3 flex-grow-1">
                        <p>Wishlist Eliminada!</p>
                    </div>
                </div>
            </div>
        </Modal>
        <Modal :show="showModalModificacio" maxWidth="2xl"    @close="cerrarModalModificacio" >
            <div class="modal-content w-100">
                <form class="w-100 rounded pt-1" @submit="modWishlist" >

                    <div class="d-flex justify-content-center m-3 ">
                        <InputLabel for="nom" value="Nom Wishlist"/>
                        <TextInput id="nom"  type="text" v-model="form.nom" required autofocus
                                   autocomplete="nom" class="mt-1 block w-full" maxlength="40" style="color: black;" />
                        <InputError class="mt-2" :message="form.errors.nom" />
                    </div>
                    <div class="d-flex justify-content-center m-3 ">
                        <button  class="btn btn-success ml-5" >Modificar</button>
                        <button type="button" class="btn btn-danger ml-5"
                                @click="cerrarModalModificacio">Cancelar</button>
                    </div>
                </form>
            </div>
        </Modal>

        <Modal :show="showModalModificacioConfirmacio" maxWidth="2xl" closeable @close="cerrarModalModificacio" >
            <div class="modal-content w-100">
                <div class="d-flex justify-content-between m-3 align-items-start">
                    <button @click="cerrarModalModificacio" style="border: none; background: none;">
                        <img :src="/images/+'cierre.jpg'" alt="Cerrar" style="width: 10px; height: 10px;" />
                    </button>
                    <p>Wishlist Modificat!</p>
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
