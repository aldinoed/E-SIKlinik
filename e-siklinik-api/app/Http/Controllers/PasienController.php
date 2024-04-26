<?php

namespace App\Http\Controllers;

use App\Models\PasienTable;
use App\Models\ProdiTable;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Storage;

class PasienController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        $pasien = PasienTable::with('pasienToProdi')->get();


        //return view ('pasien_index')->with('pasien', $pasien);
       return response()->json(['message' => 'Success tampil Pasien', 'pasien'=> $pasien]);
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
        $file = $request->file('image');
        $path = time() . '_' . $request->name . '.' . $file->getClientOriginalExtension();

        Storage::disk('local')->put('public/' . $path, file_get_contents($file));


        $pasien = PasienTable::create([
            'nrp'=>$request->nrp,
            'nama'=>$request->nama,
            'gender'=>$request->gender,
            'tanggal_lahir'=>$request->tanggal_lahir,
            'alamat'=>$request->alamat,
            'nomor_hp'=>$request->nomor_hp,
            'nomor_wali'=>$request->nomor_wali,
            'prodi_id'=>$request->prodi_id,
            'image' => $path
        ]);


        return response()->json(['message' => 'Succes input Pasien', 'pasien'=> $pasien]);
    }

    /**
     * Display the specified resource.
     */
    public function show( $id)
    {
        $pasien = PasienTable::with('pasienToProdi')->find($id);


        return response()->json(['message' => 'Success tampil data Pasien', 'pasien' => $pasien]);
    }

    /**
     * Show the form for editing the specified resource.
     */
    public function edit( $id)
    {
        $pasien = PasienTable::findOrFail($id);

        return response()->json(['message' => 'Success tampil form edit Pasien', 'pasien' => $pasien]);
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(Request $request, $id)
{
    $pasien = PasienTable::find($id);

    if ($request->hasFile('image')) {
        $file = $request->file('image');
        $path = time() . '_' . $request->name . '.' . $file->getClientOriginalExtension();


        $file->storeAs('public', $path);


        if ($pasien->image) {
            Storage::disk('local')->delete('public/' . $pasien->image);
        }

        
        $pasien->image = $path;
    }

    if (!$pasien) {
        return response()->json(['message' => 'Pasien not found'], 404);
    }

    if ($request->has('nrp')) {
        $pasien->nrp = $request->nrp;
    }

    if ($request->has('nama')) {
        $pasien->nama = $request->nama;
    }
    if ($request->has('gender')) {
        $pasien->gender = $request->gender;
    }
    if ($request->has('tanggal_lahir')) {
        $pasien->tanggal_lahir = $request->tanggal_lahir;
    }
    if ($request->has('alamat')) {
        $pasien->alamat = $request->alamat;
    }
    if ($request->has('nomor_hp')) {
        $pasien->nomor_hp = $request->nomor_hp;
    }
    if ($request->has('nomor_wali')) {
        $pasien->nomor_wali = $request->nomor_wali;
    }
    if ($request->has('prodi_id')) {
        $pasien->prodi_id = $request->prodi_id;
    }


    $pasien->save();

    return response()->json(['message' => 'Success update data Pasien', 'pasien' => $pasien]);
}




    /**
     * Remove the specified resource from storage.
     */
    public function destroy( $id)
    {
        $pasien = PasienTable::findOrFail($id);
        $pasien->delete();
        return response()->json(['message' => 'Success delete data Pasien']);
    }
}
