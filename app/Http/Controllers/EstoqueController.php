<?php

namespace App\Http\Controllers;

use App\Models\Estoque;
use App\Http\Controllers\Controller;
use Illuminate\Http\Request;

class EstoqueController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        return Estoque::all();
    }

    /**
     * Show the form for creating a new resource.
     */
    public function create()
    {
        //
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(Request $request)
    {
        $data = $request->all();

        if ($request->hasFile('image')) {
            $data['image'] = $request->file('image')->store('estoques', 'public');
        }

        $estoque = Estoque::create($data);

        return response()->json($estoque, 201);
    }

    /**
     * Display the specified resource.
     */
    public function show($id)
    {
        $product = Estoque::findOrFail($id);
        return response()->json($product);
    }

    /**
     * Show the form for editing the specified resource.
     */
    public function edit(Estoque $estoque)
    {
        //
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(Request $request, $id)
    {
        $produto = Estoque::findOrFail($id);
        $produto->update($request->all());
        return response()->json($produto, 200);
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy($id){
    $estoque = Estoque::findOrFail($id);
    $estoque->delete();

    return response()->json(null, 204);
}

}
