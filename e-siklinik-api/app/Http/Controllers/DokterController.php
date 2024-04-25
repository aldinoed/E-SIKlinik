<?php

namespace App\Http\Controllers;

use App\Models\Dokter;
use App\Models\JadwalDokter;
use Illuminate\Http\Request;

class DokterController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        $dokter = Dokter::all();

        return response()->json(['message' => 'Succes tampil dokter', 'pasien'=> $dokter]);
    }

    /**
     * Show the form for creating a new resource.
     */
    public function create()
    {
        $dokter = Dokter::all();

        return response()->json(['message' => 'Succes tampil dokter', 'dokter'=> $dokter]);
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(Request $request)
    {
        $dokter = Dokter::create([
            'nama'=> $request->nama,
            'gender'=> $request->gender,
            'tanggal_lahir'=> $request->tanggal_lahir,
            'alamat'=> $request->alamat,
            'nomor_hp' => $request->nomor_hp

        ]);

        return response()->json(['message' => 'Succes inpurt dokter', 'dokter'=> $dokter]);
    }

    /**
     * Display the specified resource.
     */
    public function show(string $id)
    {
        $dokter = Dokter::find($id);

        return response()->json(['message' => 'Success tampil data dokter', 'dokter' => $dokter]);
    }

    /**
     * Show the form for editing the specified resource.
     */
    public function edit(string $id)
    {
        $dokter = Dokter::find($id);

        return response()->json(['message' => 'Success tampil data dokter', 'dokter' => $dokter]);
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(Request $request, $id)
    {

    $dokter = Dokter::find($id);

    if (!$dokter) {
        return response()->json(['message' => 'Dokter not found'], 404);
    }

    if ($request->has('nama')) {
        $dokter->nama = $request->nama;
    }

    if ($request->has('gender')) {
        $dokter->gender = $request->gender;
    }

    if ($request->has('tanggal_lahir')) {
        $dokter->tanggal_lahir = $request->tanggal_lahir;
    }

    if ($request->has('alamat')) {
        $dokter->alamat = $request->alamat;
    }

    if ($request->has('nomor_hp')) {
        $dokter->nomor_hp = $request->nomor_hp;
    }

    $dokter->save();

    return response()->json(['message' => 'Success update data Dokter', 'dokter' => $dokter]);

    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(string $id)
    {
        $dokter = Dokter::findOrFail($id);
        $dokter->delete();
        return response()->json(['message' => 'Success delete data dokter']);
    }



    // Jadwal Dokter

    public function indexJadwal()
{
    $jadwal_dokter = JadwalDokter::with('jadwalToDokter')->get();

    return response()->json(['message' => 'Success tampil jadwal dokter', 'jadwal_dokter'=> $jadwal_dokter]);
}


    public function storeJadwal(Request $request){

        $jadwal_dokter = JadwalDokter::create([
            'dokter_id' => $request->dokter_id,
            'hari'=> $request->hari,
            'jadwal_mulai_tugas' => $request->jadwal_mulai_tugas,
            'jadwal_selesai_tugas' => $request->jadwal_selesai_tugas
        ]);

        return response()->json(['message' => 'Succes input jadwal dokter', 'jadwal_dokter'=> $jadwal_dokter]);
    }

    public function deleteJadwal($id){
        $jadwal_dokter = JadwalDokter::find($id);
        $jadwal_dokter->delete();
        return response()->json(['message' => 'Success delete data jadwal dokter']);
    }
}
