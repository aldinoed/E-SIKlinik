<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class JadwalDokter extends Model
{
    use HasFactory;

    protected $fillable = ['dokter_id', 'jadwal_tugas'];

    public function jadwalToDokter()
    {
        return $this->belongsTo(Dokter::class);
    }
}
