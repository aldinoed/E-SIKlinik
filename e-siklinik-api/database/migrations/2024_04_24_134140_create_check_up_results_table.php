<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        Schema::create('check_up_results', function (Blueprint $table) {
            $table->id();
            $table->foreignId('dokter_id')->constrained('dokter')->cascadeOnUpdate();
            $table->foreignId('pasien_id')->constrained('pasien')->cascadeOnUpdate();
            $table->foreignId('antrian_id')->constrained('antrian')->cascadeOnUpdate();
            $table->text('hasil_diagnosa');
            $table->string('url_file');
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('check_up_results');
    }
};
