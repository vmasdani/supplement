<?php

namespace App\Models;

use Illuminate\Auth\Authenticatable;
use Illuminate\Contracts\Auth\Access\Authorizable as AuthorizableContract;
use Illuminate\Contracts\Auth\Authenticatable as AuthenticatableContract;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Laravel\Lumen\Auth\Authorizable;

class TransactionItem extends Model
{

    protected $fillable = [
        // base model
        'id', 'ordering', 'ext_created_by_id', 'uuid', 'hidden',
        // base model end
        'type',  // i/o
        
        'remark', 'qty', 'transaction_id', 'item_id', 'discount_price'
    ];

    public function transaction()
    {
        return $this->belongsTo(Transaction::class, 'transaction_id');
    }

    public function item()
    {
        return $this->belongsTo(Item::class, 'item_id');
    }
}
