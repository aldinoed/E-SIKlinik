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
        $antrian = AntrianTable::all();
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
        $antrianNumberChecker = $this->nomorAntrianChecker($request);

        try {
            AntrianTable::create([
                'pasien_id' => $request->pasien_id,
                'waktu_masuk' => $request->waktu_masuk,
                'no_antrian' => $antrianNumberChecker,
            ]);
            return response()->json(["status" => 200, "messasge" => "Nomor antrian $antrianNumberChecker"]);
        } catch (Exception $exception) {
            return response()->json(["status" => 500, "messasge" => "Error: " . $exception]);
        }
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

    private function nomorAntrianChecker(Request $currentAntrian): int
    {
        $latestAntrian = AntrianTable::latest()->first();
        $latestAntrianDate = date("Y-m-d", strtotime($latestAntrian->waktu_masuk));
        $currentAntrianDate = date("Y-m-d", strtotime($currentAntrian->waktu_masuk));

        if ($latestAntrian === null || $currentAntrianDate > $latestAntrianDate) {
            $nomorAntrian = 1;
            return 1;
        } else {
            $nomorAntrian = $latestAntrian->no_antrian + 1;
            return $nomorAntrian;
        }
    }
}
