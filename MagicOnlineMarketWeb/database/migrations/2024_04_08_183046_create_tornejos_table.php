<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{

    public function up(): void
    {
        Schema::create('tornejos', function (Blueprint $table) {
            $table->bigIncrements("idTorneig");
            $table->string("nom",40);
            $table->integer("numparticipants")->default(0);
            $table->integer("minParticipants")->default(2);
            $table->integer("maxParticipants")->nullable();
            $table->integer("numeroRondes")->nullable();
            $table->enum("estat",["En creació","En inscripció","Jugant","Acabat","Anulat"])->default("En creació");
            $table->foreignId('idOrganitzador')->constrained('usuaris')->references('idUsuari');
            $table->foreignId('idTipusTorneig')->constrained('tipus_torneig')->references('idTipusTorneig');
            $table->timestamp("diaHoraInici");
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
        Schema::dropIfExists('tornejos');
    }
};
