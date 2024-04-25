<?php

use App\Http\Controllers\AntrianController;
use App\Http\Controllers\DokterController;
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
Route::post('/pasien/create', [PasienController::class, 'store'])->name('pasien.store');
Route::get('/pasien/show/{id}', [PasienController::class, 'show'])->name('pasien.show');
Route::post('/pasien/update/{id}', [PasienController::class, 'update'])->name('pasien.update');
Route::delete('/pasien/delete/{id}', [PasienController::class, 'destroy'])->name('pasien.destroy');

// PRODI
Route::get('/prodi', [ProdiController::class, 'create'])->name('prodi.create');
Route::post('/prodi/create', [ProdiController::class, 'store'])->name('prodi.store');
Route::get('/prodi/show/{id}', [ProdiController::class, 'show'])->name('prodi.show');
Route::post('/prodi/update/{id}', [ProdiController::class, 'update'])->name('prodi.update');
Route::delete('/prodi/delete/{id}', [ProdiController::class, 'destroy'])->name('prodi.destroy');

//ANTRIAN
Route::get('/antrian', [AntrianController::class, 'create'])->name('antrian.index');
Route::post('/antrian/create', [AntrianController::class, 'store'])->name('antrian.store');
//Route::post('/antrian', [AntrianController::class, 'upadte'])->name('antrian.upadte');

//DOKTER
Route::get('/dokter', [DokterController::class, 'create'])->name('dokter.index');
Route::post('/dokter', [DokterController::class, 'store'])->name('dokter.store');
Route::get('/dokter/show/{id}', [DokterController::class, 'show'])->name('dokter.show');
Route::put('/dokter/update/{id}', [DokterController::class, 'update'])->name('dokter.update');
Route::delete('/dokter/delete/{id}', [DokterController::class, 'destroy'])->name('dokter.destroy');
