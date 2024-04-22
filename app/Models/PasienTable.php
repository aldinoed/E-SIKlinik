<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class PasienTable extends Model
{
    use HasFactory;

    protected $table = 'pasien';

    protected $fillable =[
        'nama',
        'gender',
        'tanggal_lahir',
        'alamat',
        'nomor_hp',
        'nomor_wali',
        'prodi_id'
    ];

    public function pasien() {
        return $this->belongsTo(ProdiTable::class);
    }
}
