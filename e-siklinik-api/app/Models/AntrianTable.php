<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class AntrianTable extends Model
{
    use HasFactory;

    protected $table = 'antrian';

    protected $fillable = [
        'pasien_id',
        'no_antrian',
        'waktu_masuk'
    ];

    public function antrian() {
        return $this->hasMany(PasienTable::class);
    }
}
