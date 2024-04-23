<?php

use App\Http\Controllers\AntrianController;
use App\Http\Controllers\PasienController;
use App\Http\Controllers\ProdiController;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;

/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider and all of them will
| be assigned to the "api" middleware group. Make something great!
|
*/

Route::middleware('auth:sanctum')->get('/user', function (Request $request) {
    return $request->user();
});

//PASIEN
Route::get('/pasien', [PasienController::class, 'create'])->name('pasien.index');
Route::post('/pasien', [PasienController::class, 'store'])->name('pasien.store');
Route::get('/pasien/show/{id}', [PasienController::class, 'show'])->name('pasien.show');
Route::put('/pasien/update/{id}', [PasienController::class, 'update'])->name('pasien.update');
Route::delete('/pasien/delete/{id}', [PasienController::class, 'destroy'])->name('pasien.destroy');

// PRODI
Route::get('/prodi', [ProdiController::class, 'create'])->name('prodi.index');
Route::post('/prodi', [ProdiController::class, 'store'])->name('prodi.store');

//ANTRIAN
Route::get('/antrian', [AntrianController::class, 'create'])->name('antrian.index');
Route::post('/antrian', [AntrianController::class, 'store'])->name('antrian.store');
