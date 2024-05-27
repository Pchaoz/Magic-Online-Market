<script setup>

import AuthenticatedLayout from "@/Layouts/AuthenticatedLayout.vue";
import InputLabel from "@/Components/InputLabel.vue";
import Modal from "@/Components/Modal.vue";
import {ref} from "vue";
import {useForm} from "@inertiajs/vue3";
import TextInput from "@/Components/TextInput.vue";
import InputError from "@/Components/InputError.vue";


defineProps({
    tipusEnviaments: {
        type: Array(String),
    }
});


const formTipusEnviament= useForm({
    nom: null,
    id:null,
    preu:0,
})

let showModal = ref(false);
let showModalEliminacio = ref(false);
let showModalEliminacioConfirmacio= ref(false);
let showModalCreacio=ref(false);
let showModalCreacioConfirmacio=ref(false);
let showModalModificacio=ref(false);
let showModalModificacioConfirmacio=ref(false);
let showModalQuantitatIncorrecta = ref(false);

//eliminacio
const abrirModalEliminacio =  (tipEnv) => {
    formTipusEnviament.id=tipEnv.idTipusEnviament;
    showModalEliminacio.value=true;
}


const cerrarModalEliminacio = () =>{
    showModalEliminacio.value=false;
    showModalEliminacioConfirmacio.value=false;
}

const eliminarTipusEnviament=()=> {
    formTipusEnviament.delete('/eliminarTipusEnviament');
    confirmacionEliminacio();
}

const confirmacionEliminacio=()=>{
    showModalEliminacio.value=false;
    showModalEliminacioConfirmacio.value=true;
    setTimeout(() => {

        useForm.visit(window.location.pathname);
    }, 500);

}


//creacio
const cerrarModalCreacio = () =>{
    showModalCreacio.value=false;
    showModalCreacioConfirmacio.value=false;
}
const abrirModalCreacio = () =>{
    formTipusEnviament.nom="";
    formTipusEnviament.preu=0;
    showModalCreacio.value=true;
}
const crearTipusEnviament=()=> {
    if(formTipusEnviament.preu <= 0||formTipusEnviament.preu>300 ) {
        showModalCreacio.value = false;
        abrirModalQuantitatIncorrecta();
        return;
    }
    formTipusEnviament.post('/crearTipusEnviament');
    confirmacionCreacio();
}

const confirmacionCreacio=()=>{
    showModalCreacio.value=false;
    showModalCreacioConfirmacio.value=true;
    setTimeout(() => {

        useForm.visit(window.location.pathname);
    }, 500);

}

//modificacio
const cerrarModalModificacio = () =>{
    showModalModificacio.value=false;
    showModalModificacioConfirmacio.value=false;
}

const abrirModalMod=  (tipEnv) =>{
    formTipusEnviament.nom=tipEnv.nom;
    formTipusEnviament.preu=tipEnv.preu;
    formTipusEnviament.id=tipEnv.idTipusEnviament;
    showModalModificacio.value=true;
}

const modTipusEnviament=()=> {
    if(formTipusEnviament.preu <= 0||formTipusEnviament.preu>300 ) {
        showModalModificacio.value = false;
        abrirModalQuantitatIncorrecta();
        return;
    }
    formTipusEnviament.post('/modTipusEnviament');
    confirmacionMod();
}


const confirmacionMod=()=>{
    showModalModificacio.value=false;
    showModalModificacioConfirmacio.value=true;
    setTimeout(() => {

        useForm.visit(window.location.pathname);
    }, 500);

}

//quantitat incorrecta
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
            <h2>Administrar Tipus Enviaments</h2>
        </div>
        <div class="d-flex justify-content-center m-3 ">
            <table class="table table-striped my-table w-25 ">
                <thead>
                <tr>
                    <th>Nom</th>
                    <th>Preu</th>
                    <th></th>
                    <th></th>
                </tr>
                </thead>
                <tbody>
                <tr v-for="tipusEnviament in tipusEnviaments" :key="tipusEnviament.id">
                    <td>{{tipusEnviament.nom}}</td>
                    <td>{{tipusEnviament.preu}}</td>
                    <td>
                        <button  class="btn btn-success rounded-pill"
                                 @click="abrirModalMod(tipusEnviament)">Modificar</button>

                    </td>
                    <td>
                        <button  class="btn btn-danger rounded-pill"
                                 @click="abrirModalEliminacio(tipusEnviament)">Eliminar</button>

                    </td>
                </tr>
                </tbody>
            </table>


        </div>
        <div class="d-flex justify-content-center m-3 ">
            <button  class="btn btn-success"
                     @click="abrirModalCreacio()">Crear Tipus Enviament</button>
        </div>
        <Modal :show="showModalCreacio" maxWidth="2xl"    @close="cerrarModalCreacio" >
            <div class="d-flex justify-content-center">
                <form class="w-75 rounded pt-1" @submit="crearTipusEnviament" >

                    <div class="d-flex flex-column align-items-center m-3 p-1 ">
                        <InputLabel for="nom" value="Nom tipus enviament:"/>
                        <TextInput id="nom"  type="text" v-model="formTipusEnviament.nom" required autofocus
                                   autocomplete="nom" class="mt-1 block w-full"  maxlength="30" style="color: black;" />
                        <InputError class="mt-2" :message="formTipusEnviament.errors.nom" />
                    </div>
                    <div class="d-flex flex-column align-items-center m-3 p-1 ">
                        <InputLabel for="preu" value="Preu tipus enviament: "/>
                        <TextInput id="preu"  type="number" v-model="formTipusEnviament.preu" required autofocus
                                   autocomplete="preu" :min="0.01"  step="0.01" class="mt-1 block w-full"   style="color: black;" />
                        <InputError class="mt-2" :message="formTipusEnviament.errors.preu" />
                    </div>
                    <div class="d-flex justify-content-center m-3 ">
                        <button type="button" class="btn btn-danger ml-5"
                                @click="cerrarModalCreacio">Cancelar</button>
                        <button  class="btn btn-success ml-5" >Crear</button>
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
                    <p>Tipus de enviament Creat!</p>
                    <div></div>
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
        <Modal :show="showModalEliminacio" maxWidth="2xl" closeable @close="cerrarModalEliminacio" >
            <div class="modal-content w-100">
                <div class="d-flex justify-content-center m-3 ">
                    <p>¿Estas segur de que vols eliminar aquest tipus d'enviament?</p>
                </div>
                <div class="d-flex justify-content-center m-3 ">
                    <button type="button" class="btn btn-success mr-5"
                            @click="eliminarTipusEnviament">Sí</button>
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
                        <p>Tipus d'enviament Eliminat!</p>
                    </div>
                </div>
            </div>
        </Modal>
        <Modal :show="showModalModificacio" maxWidth="2xl"    @close="cerrarModalModificacio" >
            <div class="d-flex justify-content-center">
                <form class="w-75 rounded pt-1" @submit="modTipusEnviament" >

                    <div class="d-flex flex-column align-items-center m-3 p-1 ">
                        <InputLabel for="nom" value="Nom tipus enviament:"/>
                        <TextInput id="nom"  type="text" v-model="formTipusEnviament.nom" required autofocus
                                   autocomplete="nom" class="mt-1 block w-full"  maxlength="30" style="color: black;" />
                        <InputError class="mt-2" :message="formTipusEnviament.errors.nom" />
                    </div>
                    <div class="d-flex flex-column align-items-center m-3 p-1 ">
                        <InputLabel for="preu" value="Preu tipus enviament: "/>
                        <TextInput id="preu"  type="number" v-model="formTipusEnviament.preu" required autofocus
                                   autocomplete="preu" :min="0.01"  step="0.01" class="mt-1 block w-full"   style="color: black;" />
                        <InputError class="mt-2" :message="formTipusEnviament.errors.preu" />
                    </div>
                    <div class="d-flex justify-content-center m-3 ">
                        <button type="button" class="btn btn-danger ml-5"
                                @click="cerrarModalModificacio">Cancelar</button>
                        <button  class="btn btn-success ml-5" >Modificar</button>
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
                    <p>Tipus d'enviament Modificat!</p>
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
