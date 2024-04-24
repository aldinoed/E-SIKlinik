<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Dokter extends Model
{
    use HasFactory;

    protected $table = 'dokters';

    public function dokterToAntrianTable()
    {
        return $this->hasMany(CheckUpResult::class);
    }

    public function dokterToJadwal()
    {
        return $this->hasMany(JadwalDokter::class);
    }
}
