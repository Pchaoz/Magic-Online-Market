<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{

    public function up(): void
    {
        Schema::create('comandes', function (Blueprint $table) {
            $table->bigIncrements("idComanda");
            $table->double("preuTotal");
            $table->boolean("isEnviament")->default(false);
            $table->enum("EstatComanda",["En compra","Pendent pagament","Pagada","Pendent recollida","Pendent enviament","Enviada","Complerta","Anulada","Incidencia"])->nullable();
            $table->foreignId("idEnviament")->nullable()->constrained('enviaments')->references('idEnviament');
            $table->foreignId("idComprador")->nullable()->constrained('usuaris')->references('idUsuari');
            $table->foreignId("idVenedor")->nullable()->constrained('usuaris')->references('idUsuari');
            $table->foreignId('updated_by')->default(1)->constrained('usuaris')->references('idUsuari');
            $table->foreignId('created_by')->default(1)->constrained('usuaris')->references('idUsuari');
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('comandes');
    }

};
