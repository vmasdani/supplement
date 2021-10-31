<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateUsersTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('users', function (Blueprint $table) {
            $table->id();
            // Base model
            $table->text('uuid')->nullable();
            $table->integer('ordering')->nullable();
            $table->integer('ext_created_by_id')->nullable();
            $table->boolean('hidden')->nullable();
            // Base model end
            $table->text('username')->nullable();
            $table->text('name')->nullable();
            $table->text('phone')->nullable();
            $table->text('email')->nullable();
            $table->text('address')->nullable();
            $table->text('password')->nullable();

            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('users');
    }
}
