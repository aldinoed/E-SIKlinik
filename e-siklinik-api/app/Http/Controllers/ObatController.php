<?php

namespace App\Http\Controllers;

// use App\Models\Obat;

use App\Models\KategoriObat;
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
        return response()->json(['message' => 'Data berhasil ditampilkan', 'obat' => $obatData]);
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
        $obatData = DB::table('obats')->join('kategori_obats', 'obats.kategori_id', '=', 'kategori_obats.id')->where('obats.id', '=', $id)->first();

        return response()->json(['message' => 'Data berhasil ditampilkan', 'dataObat' => $obatData]);
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
        $obat = Obat::findOrFail($id);
        try {
            $response = $obat->delete();
            if ($response == true) {
                return response()->json(["status" => 200, "message" => "Berhasil hapus obat"]);
            } else {
                throw new Exception("Data tidak ditemukan", 500);
            }
        } catch (Exception $exception) {
            return response()->json(["status" => 500, "messasge" => "Error: " . $exception]);
        }
    }

    /**
     * Show data kategori obat
     */
    public function getKategori(){
        $kategori = KategoriObat::all();
        if($kategori->isNotEmpty()){
            return response()->json(['message' => 'Data berhasil ditampilkan', 'kategori' => $kategori]);
        }else{
            return response()->json(['message' => 'Belum ada data']);
        }
    }
    /**
     * Delete data kategori obat
     */
    public function destroyKategoriObat(string $id)
    {
        $kategoriObat = KategoriObat::findOrFail($id);
        try {
            $response = $kategoriObat->delete();
            if ($response == true) {
                return response()->json(["status" => 200, "message" => "Berhasil hapus kategori"]);
            } else {
                throw new Exception("Data tidak ditemukan", 500);
            }
        } catch (Exception $exception) {
            return response()->json(["status" => 500, "messasge" => "Error: " . $exception]);
        }
    }
}
