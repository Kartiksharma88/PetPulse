<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\Pet;

class PetController extends Controller
{
    // Get all pets
    public function index()
    {
        $pets = Pet::all();
        return response()->json($pets);
    }

    // Create a new pet
    public function store(Request $request)
    {
        $data = $request->validate([
            'name' => 'required|string|max:255',
            'species' => 'required|string|max:255',
            'age' => 'required|integer',
            'owner_name' => 'required|string|max:255',
        ]);

        $pet = Pet::create($data);
        return response()->json($pet, 201);
    }

    // Show one pet
    public function show($id)
    {
        $pet = Pet::find($id);
        if (!$pet) {
            return response()->json(['message' => 'Pet not found'], 404);
        }
        return response()->json($pet);
    }

    // Update pet
    public function update(Request $request, $id)
    {
        $pet = Pet::find($id);
        if (!$pet) {
            return response()->json(['message' => 'Pet not found'], 404);
        }

        $data = $request->validate([
            'name' => 'sometimes|required|string|max:255',
            'species' => 'sometimes|required|string|max:255',
            'age' => 'sometimes|required|integer',
            'owner_name' => 'sometimes|required|string|max:255',
        ]);

        $pet->update($data);
        return response()->json($pet);
    }

    // Delete pet
    public function destroy($id)
    {
        $pet = Pet::find($id);
        if (!$pet) {
            return response()->json(['message' => 'Pet not found'], 404);
        }

        $pet->delete();
        return response()->json(null, 204);
    }
}
