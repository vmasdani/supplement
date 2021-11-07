<?php

namespace App\Dto;

use App\Dto\BaseModel;


class ItemJSON extends BaseModel
{
    public ?string $name = '';
    public ?float $price = 0.0;
    public ?int $uom_id = null;
    public ?string $description = '';
}
