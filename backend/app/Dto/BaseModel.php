<?php

namespace App\Dto;

 class BaseModel {
    public ?int $id;
    public ?int $ordering;
    public ?int $ext_created_by_id;
    public ?string $uuid;
    public ?bool $hidden;
}