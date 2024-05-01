<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class CheckUpResult extends Model
{
    use HasFactory;

    protected $table = 'check_up_results';

    protected $fillable = ['dokter_id', 'pasien_id','antrian_id', 'hasil_diagnosa', 'url_file'];

    public function checkUpResultToDokter(){
        return $this->belongsTo(Dokter::class);
    }
    public function checkUpResultToPasien(){
        return $this->belongsTo(PasienTable::class);
    }
    public function checkUpResulToAntrian(){
        return $this->hasOne(AntrianTable::class);
    }
    public function checkUpResultToDetailResep(){
        return $this->hasMany(DetailResepObat::class);
    }
}
