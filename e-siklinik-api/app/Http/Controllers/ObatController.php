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
        try{
            $obatData = DB::table('obats')->join('kategori_obats', 'obats.kategori_id', '=', 'kategori_obats.id')->get();
            if($obatData->isNotEmpty()){
                return response()->json(['status' => 200, 'obats'=> $obatData]);
            }else{
                throw new Exception('Belum ada data');
            }
        }catch(Exception $exception){
            return response()->json(["status" => 500, "messasge" => "Error: " . $exception]);
        }
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
    public function getKategori()
    {
        $kategori = KategoriObat::all();
        if ($kategori->isNotEmpty()) {
            return response()->json(['message' => 'Data berhasil ditampilkan', 'kategori' => $kategori]);
        } else {
            return response()->json(['message' => 'Belum ada data']);
        }
    }
    /**
     * Show data kategori obat
     */
    public function updateKategoriObat(Request $request, int $id)
    {
        try {
            $kategori = KategoriObat::find($id);
            if ($kategori != null) {
                $kategori->nama_kategori = $request->namaKategori;
                $response = $kategori->save();
                if ($response == true) {
                    return response()->json(["status" => 200, "message" => "Berhasil update kategori obat"]);
                }
            } else {
                throw new Exception('Data kategori obat tidak ditemukan.');
            }
        } catch (Exception $exception) {
            return response()->json(["status" => 500, "messasge" => "Error: " . $exception]);
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
