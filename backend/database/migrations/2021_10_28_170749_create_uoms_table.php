<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateUomsTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('uoms', function (Blueprint $table) {
            $table->id();
            $table->timestamps();
            // Base model
            $table->text('uuid')->nullable();
            $table->integer('ordering')->nullable();
            $table->integer('ext_created_by_id')->nullable();
            $table->boolean('hidden')->nullable();
            // Base model end
            $table->text('name')->nullable();
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('uoms');
    }
}
