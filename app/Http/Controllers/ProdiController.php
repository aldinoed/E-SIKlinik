<?php

namespace App\Http\Controllers;

use App\Models\ProdiTable;
use Illuminate\Http\Request;

class ProdiController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        $prodi = ProdiTable::all();

        return response()->json(['message' => 'Succes tampil Prodi', 'prodi'=> $prodi]);
    }

    /**
     * Show the form for creating a new resource.
     */
    public function create()
    {
        $prodi = ProdiTable::all();

        return response()->json(['message' => 'Succes tampil Prodi', 'prodi'=> $prodi]);
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(Request $request)
    {
        $prodi = ProdiTable::create([
            'nama' => $request->nama
        ]);

        $prodi = ProdiTable::all();

        return response()->json(['message' => 'Succes tampil Prodi', 'prodi'=> $prodi]);
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
