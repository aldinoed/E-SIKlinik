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
            $table->unsignedBigInteger('dokter_id');
            $table->foreign('dokter_id')->references('id')->on('dokters')->onUpdate('cascade');
            $table->string('pasien_id');
            $table->foreign('pasien_id')->references('pasien_id')->on('pasien')->onUpdate('cascade');
            $table->unsignedBigInteger('antrian_id');
            $table->foreign('antrian_id')->references('id')->on('antrian')->onUpdate('cascade');
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
