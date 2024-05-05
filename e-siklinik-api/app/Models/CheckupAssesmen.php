<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class CheckupAssesmen extends Model
{
    use HasFactory;

    protected $table = 'checkup_assesmens';

    protected $fillable = ['antrian_id', 'dokter_id'];

    public function assesmenToResult(){
        return $this->belongsTo(CheckUpResult::class);
    }
    public function assesmenToAntrian(){
        return $this->hasOne(AntrianTable::class);
    }
    public function assesmenToDokter(){
        return $this->belongTo(Dokter::class);
    }
}
