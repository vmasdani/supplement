<?php

namespace App\Models;

use DateTimeZone;
use Illuminate\Auth\Authenticatable;
use Illuminate\Contracts\Auth\Access\Authorizable as AuthorizableContract;
use Illuminate\Contracts\Auth\Authenticatable as AuthenticatableContract;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Laravel\Lumen\Auth\Authorizable;

class Transaction extends Model
{
    // protected $dateFormat = 'd-m-Y';
    protected $fillable = [
        // base model
        'id', 'ordering', 'ext_created_by_id', 'uuid', 'hidden',
        // base model end
        'name', 'date', 
    ];

    protected $dates = [
        'date', 'timestamp', 'timestamp_non_tz', 'date_non_tz', 'date_real'
    ];

    public function transactionItems()
    {
        return $this->hasMany(TransactionItem::class, 'transaction_id');
    }
}
