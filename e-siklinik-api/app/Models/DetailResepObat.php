<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class DetailResepObat extends Model
{
    use HasFactory;
    protected $table = 'detail_resep_obats';
    protected $fillable =['obat_id', 'waktu_pemakaian', 'jumlah_pemakaian'];

    public function detailResepToCheckUpResult(){
        return $this->belongsTo(CheckUpResult::class);
    }
    public function detailResepToObat(){
        return $this->belongsTo(Obat::class);
    }
}
