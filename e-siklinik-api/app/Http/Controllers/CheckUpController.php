<?php

namespace App\Http\Controllers;

use App\Models\CheckUpResult;
use Illuminate\Http\Request;

class CheckUpController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        $results = CheckUpResult::with('checkUpResulToAssesmen')->with('checkUpResultToDetailResep')->get();

        if($results->count()==0){
            return response()->json(['status' => 400, 'results' => 'Belum ada data']);
        }
        return response()->json(['status' => 200, 'results' => $results]);
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
        //
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
