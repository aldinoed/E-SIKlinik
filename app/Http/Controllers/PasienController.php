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
    public function show(string $id)
    {
        //
    }

    /**
     * Show the form for editing the specified resource.
     */
    public function edit(string $id)
    {
        //
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(Request $request, string $id)
    {
        //
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(string $id)
    {
        //
    }
}
