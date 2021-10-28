<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class UpdateUserTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        //
        Schema::table('items', function (Blueprint $table) {
            // Base model
            $table->text('uuid')->nullable();
            $table->integer('ordering')->nullable();
            $table->integer('ext_created_by_id')->nullable();
            $table->boolean('hidden')->nullable();
            // Base model end
            $table->float('price')->nullable();
            $table->bigInteger('uom_id')->nullable();
            $table->text('description')->nullable();
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        //
    }
}
