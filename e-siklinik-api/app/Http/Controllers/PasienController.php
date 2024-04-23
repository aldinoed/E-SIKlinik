<?php

namespace App\Http\Controllers;

use App\Models\PasienTable;
use Illuminate\Http\Request;

class PasienController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        $pasien = PasienTable::all();

        return response()->json(['message' => 'Succes tampil Pasien', 'pasien'=> $pasien]);
    }

    /**
     * Show the form for creating a new resource.
     */
    public function create()
    {
        $pasien = PasienTable::all();

        return response()->json(['message' => 'Succes tampil Pasien', 'pasien'=> $pasien]);
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(Request $request)
    {
        $pasien = PasienTable::create([
            'pasien_id'=>$request->pasien_id,
            'nama'=>$request->nama,
            'gender'=>$request->gender,
            'tanggal_lahir'=>$request->tanggal_lahir,
            'alamat'=>$request->alamat,
            'nomor_hp'=>$request->nomor_hp,
            'nomor_wali'=>$request->nomor_wali,
            'prodi_id'=>$request->prodi_id
        ]);

        return response()->json(['message' => 'Succes input Pasien', 'pasien'=> $pasien]);
    }

    /**
     * Display the specified resource.
     */
    public function show(string $pasien_id)
    {
        $pasien = PasienTable::find($pasien_id);


        return response()->json(['message' => 'Success tampil data Pasien', 'pasien' => $pasien]);
    }

    /**
     * Show the form for editing the specified resource.
     */
    public function edit(string $id)
    {
        $pasien = PasienTable::findOrFail($id);

        return response()->json(['message' => 'Success tampil form edit Pasien', 'pasien' => $pasien]);
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(Request $request, string $id)
{
    // Temukan data pasien berdasarkan ID
    $pasien = PasienTable::find($id);

    // Periksa apakah pasien ditemukan
    if (!$pasien) {
        return response()->json(['message' => 'Pasien not found'], 404);
    }

    // Lakukan pembaruan hanya pada atribut yang diberikan dalam request
    if ($request->has('nama')) {
        $pasien->nama = $request->nama;
    }

    // Lakukan pembaruan hanya pada atribut yang diberikan dalam request
    if ($request->has('gender')) {
        $pasien->gender = $request->gender;
    }

    // Lakukan pembaruan hanya pada atribut yang diberikan dalam request
    if ($request->has('tanggal_lahir')) {
        $pasien->tanggal_lahir = $request->tanggal_lahir;
    }

    // Lakukan pembaruan hanya pada atribut yang diberikan dalam request
    if ($request->has('alamat')) {
        $pasien->alamat = $request->alamat;
    }

    // Lakukan pembaruan hanya pada atribut yang diberikan dalam request
    if ($request->has('nomor_hp')) {
        $pasien->nomor_hp = $request->nomor_hp;
    }

    // Lakukan pembaruan hanya pada atribut yang diberikan dalam request
    if ($request->has('nomor_wali')) {
        $pasien->nomor_wali = $request->nomor_wali;
    }

    // Lakukan pembaruan hanya pada atribut yang diberikan dalam request
    if ($request->has('prodi_id')) {
        $pasien->prodi_id = $request->prodi_id;
    }

    // Simpan perubahan
    $pasien->save();

    // Berikan respons JSON yang sesuai
    return response()->json(['message' => 'Success update data Pasien', 'pasien' => $pasien]);
}


    /**
     * Remove the specified resource from storage.
     */
    public function destroy(string $id)
    {
        $pasien = PasienTable::findOrFail($id);
        $pasien->delete();
        return response()->json(['message' => 'Success delete data Pasien']);
    }
}
