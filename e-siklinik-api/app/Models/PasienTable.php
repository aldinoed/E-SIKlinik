<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class PasienTable extends Model
{
    use HasFactory;

    protected $table = 'pasien';
    protected $primaryKey = 'pasien_id';
    protected $fillable =[
        'pasien_id',
        'nama',
        'gender',
        'tanggal_lahir',
        'alamat',
        'nomor_hp',
        'nomor_wali',
        'prodi_id'
    ];

    public function pasienToProdi() {
        return $this->belongsTo(ProdiTable::class);
    }

    public function pasienToAntrian(){
        return $this->belongsTo(AntrianTable::class);
    }
}
