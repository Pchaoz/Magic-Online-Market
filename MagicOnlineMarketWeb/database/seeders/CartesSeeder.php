<?php

namespace Database\Seeders;

use Carbon\Carbon;
use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Schema;

class CartesSeeder extends Seeder
{

    public function run(): void
    {
        Schema::disableForeignKeyConstraints();
        DB::table('cartes')->insert([
            'nom' => 'Ulamog, El Hambre que no Cesa',
            'descripcio' =>  'Cuando lances a Ulamog, el Hambre Que No Cesa, exilia dos permanentes objetivo.Indestructible.Siempre que Ulamog ataque, el jugador defensor exilia las veinte primeras cartas de su biblioteca.',
            'raresa'=> 'mitica',
            'imatge' => 'cartes/ulamogHambre.jpg',
            'created_at' => Carbon::now()->format('Y-m-d H:i:s'),
            'updated_at' => Carbon::now()->format('Y-m-d H:i:s'),
        ]);

        DB::table('cartes')->insert([
            'nom' => 'Choque',
            'descripcio' =>  'El Choque hace 2 puntos de daño a cualquier objetivo.',
            'imatge' => 'cartes/choque.jpg',
            'created_at' => Carbon::now()->format('Y-m-d H:i:s'),
            'updated_at' => Carbon::now()->format('Y-m-d H:i:s'),
        ]);
        DB::table('cartes')->insert([
            'nom' => 'Tejedora de armonía',
            'descripcio' =>  'Las otras criaturas encantamiento que controlas obtienen +1/+1. {G}, {T}: Copia la habilidad activada o disparada objetivo que controlas de una fuente encantamiento. Puedes elegir nuevos objetivos para la copia.',
            'raresa'=> 'rara',
            'imatge' => 'cartes/tejedoraArmonia.jpg',
            'created_at' => Carbon::now()->format('Y-m-d H:i:s'),
            'updated_at' => Carbon::now()->format('Y-m-d H:i:s'),
        ]);
        DB::table('cartes')->insert([
            'nom' => 'Coacción',
            'descripcio' =>  'El oponente objetivo muestra su mano. Tú eliges de ahí una carta que no sea tierra ni criatura. Ese jugador descarta esa carta.',
            'imatge' => 'cartes/coaccion.jpg',
            'created_at' => Carbon::now()->format('Y-m-d H:i:s'),
            'updated_at' => Carbon::now()->format('Y-m-d H:i:s'),
        ]);
        DB::table('cartes')->insert([
            'nom' => 'Optar',
            'descripcio' =>  'Adivina 1. Roba una carta.',
            'imatge' => 'cartes/optar.jpg',
            'created_at' => Carbon::now()->format('Y-m-d H:i:s'),
            'updated_at' => Carbon::now()->format('Y-m-d H:i:s'),
        ]);
        DB::table('cartes')->insert([
            'nom' => 'Mago zaheridor de almas',
            'descripcio' =>  'Si una fuente que controlas fuera a hacer daño que no sea de combate a una criatura que controla un oponente, en vez de eso, pon esa misma cantidad de contadores -1/-1 sobre esa criatura.',
            'raresa'=> 'rara',
            'imatge' => 'cartes/magoZaheridorAlmas.jpg',
            'created_at' => Carbon::now()->format('Y-m-d H:i:s'),
            'updated_at' => Carbon::now()->format('Y-m-d H:i:s'),
        ]);
        DB::table('cartes')->insert([
            'nom' => 'Llanura',
            'descripcio' =>  '({T}: Add {W}.)',
            'imatge' => 'cartes/llanura.jpg',
            'created_at' => Carbon::now()->format('Y-m-d H:i:s'),
            'updated_at' => Carbon::now()->format('Y-m-d H:i:s'),
        ]);
        DB::table('cartes')->insert([
            'nom' => 'Isla',
            'descripcio' =>  '({T}: Add {U}.)',
            'imatge' => 'cartes/isla.jpg',
            'created_at' => Carbon::now()->format('Y-m-d H:i:s'),
            'updated_at' => Carbon::now()->format('Y-m-d H:i:s'),
        ]);
        DB::table('cartes')->insert([
            'nom' => 'Montaña',
            'descripcio' =>  '({T}: Add {R}.)',
            'imatge' => 'cartes/montaña.jpg',
            'created_at' => Carbon::now()->format('Y-m-d H:i:s'),
            'updated_at' => Carbon::now()->format('Y-m-d H:i:s'),
        ]);
        DB::table('cartes')->insert([
            'nom' => 'Pantano',
            'descripcio' =>  '({T}: Add {B}.)',
            'imatge' => 'cartes/pantano.jpg',
            'created_at' => Carbon::now()->format('Y-m-d H:i:s'),
            'updated_at' => Carbon::now()->format('Y-m-d H:i:s'),
        ]);
        DB::table('cartes')->insert([
            'nom' => 'Bosque',
            'descripcio' =>  '({T}: Add {G}.)',
            'imatge' => 'cartes/bosque.jpg',
            'created_at' => Carbon::now()->format('Y-m-d H:i:s'),
            'updated_at' => Carbon::now()->format('Y-m-d H:i:s'),
        ]);
        DB::table('cartes')->insert([
            'nom' => 'Degollador de Zulaport',
            'descripcio' =>  'Siempre que el Degollador de Zulaport u otra criatura que controlas muera, cada oponente pierde 1 vida y tú ganas 1 vida.',
            'raresa'=> 'infrecuente',
            'imatge' => 'cartes/degolladorZulaport.jpg',
            'created_at' => Carbon::now()->format('Y-m-d H:i:s'),
            'updated_at' => Carbon::now()->format('Y-m-d H:i:s'),
        ]);
        DB::table('cartes')->insert([
            'nom' => 'Adivinación silvana',
            'descripcio' =>  'Busca en tu biblioteca una carta de tierra, muéstrala y ponla en tu mano. Luego baraja tu biblioteca.',
            'raresa'=> 'infrecuente',
            'imatge' => 'cartes/adivinacionSilvana.jpg',
            'created_at' => Carbon::now()->format('Y-m-d H:i:s'),
            'updated_at' => Carbon::now()->format('Y-m-d H:i:s'),
        ]);
        DB::table('cartes')->insert([
            'nom' => 'Reencuentro amargo',
            'descripcio' =>  'Cuando el Reencuentro amargo entre al campo de batalla, puedes descartar una carta. Si lo haces, roba dos cartas.
{1}, sacrificar el Reencuentro amargo: Las criaturas que controlas ganan la habilidad de prisa hasta el final del turno.',
            'imatge' => 'cartes/reencuentroAmargo.jpg',
            'created_at' => Carbon::now()->format('Y-m-d H:i:s'),
            'updated_at' => Carbon::now()->format('Y-m-d H:i:s'),
        ]);
        DB::table('cartes')->insert([
            'nom' => 'Golpe a la garganta',
            'descripcio' =>  'Destruye la criatura objetivo que no sea artefacto.',
            'raresa'=> 'infrecuente',
            'imatge' => 'cartes/golpeGarganta.jpg',
            'created_at' => Carbon::now()->format('Y-m-d H:i:s'),
            'updated_at' => Carbon::now()->format('Y-m-d H:i:s'),
        ]);
        DB::table('cartes')->insert([
            'nom' => 'Intención Diabólica',
            'imatge' => 'cartes/intervencionDiavolica.jpg',
            'descripcio' =>  'Como coste adicional para lanzar este hechizo, sacrifica una criatura.
Busca en tu biblioteca una carta, pon esa carta en tu mano y luego baraja.',
            'raresa'=> 'rara',
            'created_at' => Carbon::now()->format('Y-m-d H:i:s'),
            'updated_at' => Carbon::now()->format('Y-m-d H:i:s'),
        ]);
        DB::table('cartes')->insert([
            'nom' => 'Cuevas de Koilos',
            'descripcio'=> '{T}: Agrega {C}.
{T}: Agrega {W} o {B}. Las Cuevas de Koilos te hacen 1 punto de daño.',
            'imatge' => 'cartes/cuevasKoilos.jpg',
            'raresa'=> 'rara',
            'created_at' => Carbon::now()->format('Y-m-d H:i:s'),
            'updated_at' => Carbon::now()->format('Y-m-d H:i:s'),
        ]);
        DB::table('cartes')->insert([
            'nom' => 'Confinamiento temporal',
            'descripcio' =>  'Cuando el Confinamiento temporal entre al campo de batalla, exilia cada permanente que no sea tierra con valor de maná de 2 o menos hasta que el Confinamiento temporal deje el campo de batalla.',
            'raresa'=> 'infrecuente',
            'imatge' => 'cartes/confinamientoTemporal.jpg',
            'created_at' => Carbon::now()->format('Y-m-d H:i:s'),
            'updated_at' => Carbon::now()->format('Y-m-d H:i:s'),
        ]);
        DB::table('cartes')->insert([
            'nom' => 'Trenzas, pesadilla resurgida',
            'descripcio' =>  'Al comienzo de tu paso final, puedes sacrificar un artefacto, criatura, encantamiento, tierra o planeswalker. Si lo haces, cada oponente puede sacrificar un permanente que comparta un tipo de carta con el permanente que sacrificaste. Por cada oponente que no lo haga, ese jugador pierde 2 vidas y tú robas una carta.',
            'raresa'=> 'rara',
            'imatge' => 'cartes/trenzasPesadillaResurgida.jpg',
            'created_at' => Carbon::now()->format('Y-m-d H:i:s'),
            'updated_at' => Carbon::now()->format('Y-m-d H:i:s'),
        ]);
        DB::table('cartes')->insert([
            'nom' => 'Profanador del vigor',
            'descripcio' =>  'Como coste adicional para lanzar hechizos de permanente verdes, puedes pagar 2 vidas. Te cuesta {G} menos lanzar esos hechizos si pagaste vidas de esta manera. Este efecto reduce solo la cantidad de maná verde que pagas.
Siempre que lances un hechizo de permanente verde, pon un contador +1/+1 sobre cada criatura que controlas.',
            'raresa'=> 'rara',
            'imatge' => 'cartes/profanadorVigor.jpg',
            'created_at' => Carbon::now()->format('Y-m-d H:i:s'),
            'updated_at' => Carbon::now()->format('Y-m-d H:i:s'),
        ]);



        Schema::enableForeignKeyConstraints();
    }
}
