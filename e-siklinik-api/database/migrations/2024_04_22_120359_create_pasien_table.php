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
        Schema::create('pasien', function (Blueprint $table) {
            $table->string('pasien_id')->primary();
            $table->string('nama');
            $table->string('gender');
            $table->date('tanggal_lahir');
            $table->string('alamat');
            $table->string('nomor_hp');
            $table->string('nomor_wali');
            $table->unsignedBigInteger('prodi_id'); // Tambahkan kolom 'prodi_id' di sini
            $table->foreign('prodi_id')->references('prodi_id')->on('prodi')->constraint('fk_pasien_antrian')->onUpdate('cascade');
            //Prod
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('pasien');
    }
};
