<?php

namespace App\Http\Controllers;

use App\Models\AntrianTable;
use Illuminate\Http\Request;

class AntrianController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        $antrian = AntrianTable::all();
        return response()->json(['message' => 'Succes input antrian', 'antrian'=> $antrian]);
    }

    /**
     * Show the form for creating a new resource.
     */
    public function create()
    {
        $antrian = AntrianTable::all();
        return response()->json(['message' => 'Succes input antrian', 'antrian'=> $antrian]);
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(Request $request)
    {
        $antrian = AntrianTable::create([
            'pasien_id'=> $request->pasien_id,
            'waktu_masuk'=> $request->waktu_masuk,
            'no_antrian'=> $request->no_antrian
        ]);
        
        return response()->json(['message' => 'Succes input antrian', 'antrian'=> $antrian]);
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
