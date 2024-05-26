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
            Schema::create('checkup_assesmens', function (Blueprint $table) {
                  $table->id();
                  $table->foreignId('antrian_id')->constrained('antrian')->cascadeOnUpdate()->cascadeOnDelete();
                  $table->foreignId('dokter_id')->constrained('dokter')->cascadeOnUpdate()->cascadeOnDelete();
                  $table->timestamps();
            });
      }

      /**
       * Reverse the migrations.
       */
      public function down(): void
      {
            Schema::dropIfExists('checkup_assesmens');
      }
};
