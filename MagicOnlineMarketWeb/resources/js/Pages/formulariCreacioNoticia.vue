<script setup>


import { Form as VForm, Field as VField, defineRule, ErrorMessage } from 'vee-validate';
import {required} from "@vee-validate/rules";
import {useForm} from "@inertiajs/vue3";
import {ref} from "vue";
import AuthenticatedLayout from "@/Layouts/AuthenticatedLayout.vue";
import InputLabel from "@/Components/InputLabel.vue";
import Modal from "@/Components/Modal.vue";
import 'bootstrap/dist/css/bootstrap.css';



defineRule('required', required);


const formNoticia = useForm({
    titol:'',
    subtitol:'',
    imatge:null,
    contingut:'',
    imatgeMiniatura:'',
});


let showModal = ref(false);
let showModalImatgeIncorrecta = ref(false);

const obtenirImatge = (event) => {
    const file = event.target.files[0];
    if (!file.type.match('image.*')) {
        alert('Si us plau només imatges!');
        event.target.value=null;
        return;
    }
    if (file.size > 1000000) {
        alert('La imatge té un tamany massa gran. El tamant màxim permés es de 1000KB.');
        event.target.value=null;
        return;
    }
    formNoticia.imatge = file;
    const reader = new FileReader();
    reader.onload = (e) => {
        formNoticia.imatgeMiniatura = e.target.result;
    };
    reader.readAsDataURL(file);
}

const myfunction = () => {
    if(formNoticia.imatge==null){
        abrirModalImatgeIncorrecta();
    }else{
        formNoticia.post('crearNoticia');
        cerrarForm();
    }

}

const cerrarForm = () => {
    showModal.value = true;
    setTimeout(() => {
        showModal.value = false;
        window.location.href = '/llistaNoticies';
    }, 500);


}
const cerrarModalImatgeIncorrecta=()=>{
    showModalImatgeIncorrecta.value =false;
}

const abrirModalImatgeIncorrecta = () => {
    showModalImatgeIncorrecta.value =true;
}


</script>

<template>
    <AuthenticatedLayout>
        <div class="d-flex justify-content-center pt-10 ">
            <div class="w-50 rounded"  style="background-color: rgba(255,255,255,0.2);padding: 20px; margin: 20px;">
                <VForm v-slot="{ errors }" @submit="myfunction" class="w-100 rounded">
                    <div class="d-flex flex-column align-items-center m-4 p-1">
                        <InputLabel for="titol" value="Titol:" />
                        <VField id="titol" name="titol" type="text" v-model="formNoticia.titol" rules="required" class="mt-1 block w-full" style="color: black;" />
                        <ErrorMessage name="titol" style="color: red; font-weight: bold;" />
                    </div>
                    <div class="d-flex flex-column align-items-center m-4 p-1">
                        <InputLabel for="subtitol" value="Subtitol:" />
                        <VField id="subtitol" name="subtitol" type="text" v-model="formNoticia.subtitol" class="mt-1 block w-full" style="color: black;" />
                        <ErrorMessage name="subtitol" style="color: red; font-weight: bold;"/>
                    </div>
                    <div class="d-flex flex-column align-items-center m-4 p-1">
                        <InputLabel for="contingut" value="Contingut:" />
                        <textarea id="contingut" name="contingut" v-model="formNoticia.contingut" class="mt-1 block w-full" style="color: black;"></textarea>
                    </div>
                    <div class="d-flex flex-column align-items-center m-4 p-1">
                        <InputLabel for="imatge" value="Imatge:" />
                        <div class="d-flex flex-column align-items-center ">
                            <VField id="imatge" name="imatge" type="file" accept="image/png, image/jpg" class="mt-1 block w-full" rules="required" style="color: black" @change="obtenirImatge" />
                        </div>
                        <ErrorMessage name="imatge" style="color: red; font-weight: bold;"/>
                    </div>

                    <div class="d-flex flex-column align-items-center m-4 p-1">
                        <figure>
                            <img width="200" height="200" :src="formNoticia.imatgeMiniatura">
                        </figure>
                    </div>
                    <div class="d-flex flex-column align-items-center m-4 p-1">
                        <button class="btn btn-success" :class="{ 'opacity-25': formNoticia.processing }" :disabled="Object.keys(errors).length > 0">
                            Crear Noticia
                        </button>
                    </div>
                </VForm>
            </div>
            <Modal :show="showModal" maxWidth="2xl" closeable @close="cerrarForm">
                <div class="modal-content w-100">
                    <div class="d-flex justify-content-center m-3 ">
                        <p>Noticia Creada!</p>
                    </div>
                </div>
            </Modal>
        </div>
        <Modal :show="showModalImatgeIncorrecta" maxWidth="2xl" closeable @close="cerrarModalImatgeIncorrecta" >
            <div class="modal-content w-100">
                <div class="d-flex justify-content-between m-3 align-items-start">
                    <button @click="cerrarModalImatgeIncorrecta" style="border: none; background: none;">
                        <img :src="/images/+'cierre.jpg'" alt="Cerrar" style="width: 10px; height: 10px;" />
                    </button>
                    <p>Atributs de la imatge Incorrectes!</p>
                    <div></div>
                </div>
            </div>
        </Modal>


    </AuthenticatedLayout>
</template>

<style scoped>
form {
    background-color:rgba(0,214,153,0.8) !important;

}


</style>
