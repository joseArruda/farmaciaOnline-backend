<?php

use App\Http\Controllers\EstoqueController;

Route::get('/estoque', [EstoqueController::class, 'index']);
Route::get('/estoque/{id}', [EstoqueController::class, 'show']);
Route::post('/estoque', [EstoqueController::class, 'store']);
Route::put('/estoque/{id}', [EstoqueController::class, 'update']);
Route::delete('/estoque/{id}', [EstoqueController::class, 'destroy']);