<?php

namespace App\Http\Controllers;

// use App\Models\Obat;

use App\Models\Obat;
use Exception;
use Illuminate\Support\Facades\DB;
use Illuminate\Http\Request;

class ObatController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        // $obatData = [];
        // try {
        // $obatData = DB::table('obats')->select('*')->join('kategori_obats', 'kategori_obats.id', 'obats.id')->get();
        // $obatData = Obat::with('obatToKategoriObat')->get();
        $obatData = Obat::all();

        // if ($obatData->isNotEmpty()) {
        // ddd($obatData);
        return response()->json(['message' => 'Data berhasil ditampilkan', 'dataObat' => $obatData]);
        // } else {
        //     return response()->json(['code' => 403, 'message' => 'Tidak ada data']);
        // }
        // } catch (Exception $err) {
        //     return response()->json(['code' => 500, 'message' => $err]);
        // }
    }

    /**
     * Show the form for creating a new resource.
     */
    public function create()
    {
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(Request $request)
    {
        $storeBuilder = DB::table('obats')->insert([
            'nama_obat' => $request->nama_obat,
        ]);
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
