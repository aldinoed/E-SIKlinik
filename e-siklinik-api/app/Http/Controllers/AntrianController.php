<?php

namespace App\Http\Controllers;

use App\Models\AntrianTable;
use Illuminate\Support\Facades\DB;
use Exception;
use Illuminate\Http\Request;

class AntrianController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        $antrian = AntrianTable::with('antrianToPasien')->get();
        return response()->json(['message' => 'Succes tampil antrian', 'antrian' => $antrian]);
    }

    /**
     * Show the form for creating a new resource.
     */
    public function create()
    {
        $antrian = AntrianTable::all();
        return response()->json(['message' => 'Succes input antrian', 'antrian' => $antrian]);
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(Request $request)
    {


        try {
            AntrianTable::create([
                'pasien_id' => $request->pasien_id,
                'no_antrian' => $request->no_antrian,
            ]);
            return response()->json(["status" => 200, "messasge" => "Nomor antrian "]);
        } catch (Exception $exception) {
            return response()->json(["status" => 500, "messasge" => "Error: " . $exception]);
        }
    }

    /**
     * Display the specified resource.
     */
    public function show(string $id)
    {
        try{
            $response = DB::table('antrian')->join('pasien', 'antrian.pasien_id', '=', 'pasien.id' )->where('antrian.id', '=', $id)->get();
            return response()->json(["status" => 200, "antrian" => $response]);
        }catch(Exception $exception){
            return response()->json(["status" => 500, "messasge" => "Error: " . $exception]);
        }
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

    private function nomorAntrianChecker(): int
    {
        $latestAntrian = AntrianTable::latest()->first();
        $latestAntrianDate = '';
        if ($latestAntrian !== null) {
            $latestAntrianDate = date("Y-m-d", strtotime($latestAntrian->created_at));
        }

        if ($latestAntrian === null || date('Y-m-d') > $latestAntrianDate) {
            $nomorAntrian = 1;
            return $nomorAntrian;
        } else if ($latestAntrian === null || date('Y-m-d') < $latestAntrianDate) {
            return 0;
        } else {
            $nomorAntrian = $latestAntrian->no_antrian + 1;
            return $nomorAntrian;
        }
    }
}
