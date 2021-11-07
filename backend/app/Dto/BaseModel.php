<?php

namespace App\Dto;

class BaseModel
{
    public ?int $id  = null;
    public ?int $ordering = 0;
    public ?int $ext_created_by_id = null;
    public ?string $uuid = null;
    public ?bool $hidden = false;
}
