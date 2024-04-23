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
        Schema::create('antrian', function (Blueprint $table) {
            $table->id('antrian_id');
            $table->string('pasien_id');
            $table->foreign('pasien_id')->references('pasien_id')->on('pasien')->onUpdate('cascade');
            $table->integer('no_antrian');
            $table->timestamp('waktu_masuk');
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('antrian');
    }
};
