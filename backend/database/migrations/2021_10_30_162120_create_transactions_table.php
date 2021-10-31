<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateTransactionsTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('transactions', function (Blueprint $table) {
            $table->id();
            // Base model
            $table->text('uuid')->nullable();
            $table->integer('ordering')->nullable();
            $table->integer('ext_created_by_id')->nullable();
            $table->boolean('hidden')->nullable();
            // Base model end
            $table->text('name')->nullable();
            $table->dateTimeTz('date')->nullable();
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
        Schema::dropIfExists('transactions');
    }
}
