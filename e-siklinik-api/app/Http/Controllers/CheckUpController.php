<?php

namespace App\Http\Controllers;

use App\Models\CheckupAssesmen;
use App\Models\CheckUpResult;
use App\Models\Obat;
use Exception;
use Illuminate\Http\Request;
use function PHPUnit\Framework\isNull;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Storage;

class CheckUpController extends Controller
{
    /**
     * Display a listing of the resource.
     */

    // $results = CheckUpResult::with('checkUpResulToAssesmen')->with('checkUpResultToDetailResep')->get();

    // if($results->count()==0){
    //     return response()->json(['status' => 400, 'results' => 'Belum ada data']);
    // }
    // return response()->json(['status' => 200, 'results' => $results]);

    public function index()
    {
        $results = DB::table('check_up_results')
            ->select('check_up_results.*')
            ->join('checkup_assesmens', 'check_up_results.assesmen_id', '=', 'checkup_assesmens.id')
            ->addSelect('checkup_assesmens.*')
            ->join('dokter', 'checkup_assesmens.dokter_id', '=', 'dokter.id')
            ->addSelect('dokter.*')
            ->join('antrian', 'checkup_assesmens.antrian_id', '=', 'antrian.id')
            ->addSelect('antrian.*')
            ->join('pasien', 'antrian.pasien_id', '=', 'pasien.id')
            ->addSelect('pasien.*')
            ->join('prodi', 'pasien.prodi_id', '=', 'prodi.id')
            ->addSelect('prodi.*')
            ->join('detail_resep_obats', 'detail_resep_obats.checkup_id', '=', 'check_up_results.id')
            ->addSelect('detail_resep_obats.*')->join('obats', 'detail_resep_obats.obat_id', '=', 'obats.id')->addSelect('obats.*')->join('kategori_obats', 'obats.kategori_id', '=', 'kategori_obats.id')->addSelect('kategori_obats.*')
            ->get();

        if ($results->count() == 0) {
            return response()->json(['status' => 400, 'results' => 'Belum ada data']);
        }
        return response()->json(['status' => 200, 'results' => $results]);
    }
    /**
     * Display a listing of the resource.
     */
    public function indexAssesmens()
    {
        $response = DB::table('dokter')
            ->select('dokter.id as dokter_id',  'dokter.nama as nama_dokter', 'checkup_assesmens.id as checkup_assesmen_id', 'antrian.id as antrian_id', 'antrian.no_antrian')
            ->join('checkup_assesmens', 'dokter.id', '=', 'checkup_assesmens.dokter_id')
            ->addSelect('checkup_assesmens.*')
            ->join('antrian', 'checkup_assesmens.antrian_id', '=', 'antrian.id')
            ->addSelect('antrian.*')
            ->join('pasien', 'antrian.pasien_id', '=', 'pasien.id')
            ->addSelect('pasien.*')
            ->join('prodi', 'pasien.prodi_id', '=', 'prodi.id')
            ->addSelect('prodi.*')
            ->get();
        if ($response->count() == 0) {
            return response()->json(['status' => 400, 'results' => 'Belum ada data']);
        }
        return response()->json(['status' => 200, 'results' => $response]);
    }

    /**
     * Show the form for creating a new resource.
     */
    public function create()
    {
        //
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(Request $request)
    {
        try {
            $file = $request->file('image');
            $path = time() . '_' . $request->nama . '.' . $file->getClientOriginalExtension();

            $uploadRes = Storage::disk('local')->put('public/' . $path, file_get_contents($file));

            if ($uploadRes == false) {
                throw new Exception("Upload gambar gagal", 500);
            } else {
                $response = CheckUpResult::create([
                    'assesmen_id' => $request->assesmenId,
                    'hasil_diagnosa' => $request->diagnosa,
                    'url_file' => $path,
                ]);
                if ($response) {
                    return response()->json(["status" => 200, "message" => "Berhasil input hasil checkup"]);
                } else {
                    throw new Exception();
                }
            }
        } catch (Exception $exception) {
            return response()->json(["status" => 500, "messasge" => "Error: " . $exception]);
        }
    }
    /**
     * Store a CheckUpAssesment.
     */
    public function storeAssesmen(Request $request)
    {
        try {
            $response = CheckupAssesmen::create([
                'antrian_id' => $request->antrian_id,
                'dokter_id' => $request->dokter_id
            ]);
            if (isNull($response)) {
                return response()->json(["status" => 200, "message" => "Berhasil input assesmen"]);
            } else {
                throw new Exception();
            }
        } catch (Exception $exception) {
            return response()->json(['message' => $exception->getMessage()]);
        }
    }

    /**
     * Display the specified resource.
     */
    public function show(string $id)
    {
        $results = DB::table('check_up_results')
            ->select('check_up_results.*')
            ->join('checkup_assesmens', 'check_up_results.assesmen_id', '=', 'checkup_assesmens.id')
            ->addSelect('checkup_assesmens.*')
            ->join('dokter', 'checkup_assesmens.dokter_id', '=', 'dokter.id')
            ->addSelect('dokter.*')
            ->join('antrian', 'checkup_assesmens.antrian_id', '=', 'antrian.id')
            ->addSelect('antrian.*')
            ->join('pasien', 'antrian.pasien_id', '=', 'pasien.id')
            ->addSelect('pasien.*')
            ->join('prodi', 'pasien.prodi_id', '=', 'prodi.id')
            ->addSelect('prodi.*')
            ->join('detail_resep_obats', 'check_up_results.id', '=', 'detail_resep_obats.checkup_id',)
            ->addSelect('detail_resep_obats.*')->join('obats', 'detail_resep_obats.obat_id', '=', 'obats.id')->addSelect('obats.*')->join('kategori_obats', 'obats.kategori_id', '=', 'kategori_obats.id')->addSelect('kategori_obats.*')
            ->where('check_up_results.id', '=', $id)
            ->first();
        if ($results) {
            return response()->json(['status' => 200, 'results' => $results]);
        }
        return response()->json(['status' => 400, 'results' => 'Belum ada data']);
    }
    /**
     * Display the specified assesmen.
     */
    public function showAssesmen(string $id)
    {

        try {
            $response = DB::table('dokter')
                ->select('dokter.id as dokter_id',  'dokter.nama as nama_dokter', 'checkup_assesmens.id as checkup_assesmen_id', 'antrian.id as antrian_id', 'antrian.no_antrian')
                ->join('checkup_assesmens', 'dokter.id', '=', 'checkup_assesmens.dokter_id')
                ->join('antrian', 'checkup_assesmens.antrian_id', '=', 'antrian.id')
                ->join('pasien', 'antrian.pasien_id', '=', 'pasien.id')
                ->addSelect('pasien.*')->where('checkup_assessmens.id', '=', "$id")->first();
                
                return response()->json(['status' => 200, 'results' => $response]);
        } catch (Exception $exception) {
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
}
