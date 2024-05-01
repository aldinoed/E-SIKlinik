<?php

namespace App\Http\Controllers;

// use App\Models\Obat;

use App\Models\KategoriObat;
use App\Models\Obat;
use App\Models\Dokter;
use Illuminate\Support\Facades\Storage;
use Exception;
use Illuminate\Support\Facades\DB;
use Illuminate\Http\Request;

use function PHPUnit\Framework\isNull;

class ObatController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        try {
            $obatData = DB::table('obats')->join('kategori_obats', 'obats.kategori_id', '=', 'kategori_obats.id')->get();
            if ($obatData->isNotEmpty()) {
                return response()->json(['status' => 200, 'obats' => $obatData]);
            } else {
                throw new Exception('Belum ada data');
            }
        } catch (Exception $exception) {
            return response()->json(["status" => 500, "messasge" => "Error: " . $exception]);
        }
    }
    /**
     * Store a newly created resource in storage.
     */
    public function store(Request $request)
    {
        try {
            $file = $request->file('image');
            $path = time() . '_' . $request->nama . '.' . $file->getClientOriginalExtension();
            var_dump($path);

            $uploadRes = Storage::disk('local')->put('public/' . $path, file_get_contents($file));

            if ($uploadRes == false) {
                throw new Exception("Upload gambar gagal", 500);
            } else {
                $response = Obat::create([
                    'nama_obat' => $request->nama,
                    'tanggal_kadaluarsa' => $request->kadaluarsa,
                    'stock' => $request->stock,
                    'harga' => $request->harga,
                    'kategori_id' => $request->kategoriId,
                    'image' => $path,
                ]);
                if (isNull($response)) {
                    return response()->json(["status" => 200, "message" => "Berhasil input obat"]);
                } else {
                    throw new Exception();
                }
            }
        } catch (Exception $exception) {
            return response()->json(["status" => 500, "messasge" => "Error: " . $exception]);
        }
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
        var_dump($id);
        var_dump($request);
        $obat = Obat::find($id);

        if (!$obat) {
            return response()->json(['message' => 'Obat not found'], 404);
        }

        if ($request->hasFile('image')) {
            $file = $request->file('image');
            $path = time() . '_' . $request->nama . '.' . $file->getClientOriginalExtension();


            $file->storeAs('public', $path);


            if ($obat->image) {
                Storage::disk('local')->delete('public/' . $obat->image);
            }


            $obat->image = $path;
        }

        if ($request->has('nama')) {
            $obat->nama_obat = $request->nama;
        }

        if ($request->has('kadaluarsa')) {
            $obat->tanggal_kadaluarsa = $request->kadaluarsa;
        }

        if ($request->has('stock')) {
            $obat->stock = $request->stock;
        }

        if ($request->has('harga')) {
            $obat->harga = $request->harga;
        }
        if($request->has('kategoriId')){
            $obat->kategori_id = $request->kategoriId;
        }

        $obat->save();
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
