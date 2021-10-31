<?php

namespace App\Models;

use Illuminate\Auth\Authenticatable;
use Illuminate\Contracts\Auth\Access\Authorizable as AuthorizableContract;
use Illuminate\Contracts\Auth\Authenticatable as AuthenticatableContract;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Laravel\Lumen\Auth\Authorizable;

class Item extends Model
{

    protected $fillable = [
        // base model
        'id', 'ordering', 'ext_created_by_id', 'uuid', 'hidden',
        // base model end
        'name', 'price', 'uom_id', 'description'
    ];

    public function uom()
    {
        return $this->belongsTo(Uom::class, 'uom_id');
    }
}
