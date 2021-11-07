<?php

namespace App\Dto;

class UserJSON extends BaseModel
{
    public ?string $name;
    public ?string $username;
    public ?string $email;
    public ?string $phone;
    public ?string $address;
    public ?string $password;
}
