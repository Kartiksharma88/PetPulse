import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

void main() {
  runApp(const PetPulseApp());
}

// Change this based on where you run Flutter
// Windows/Chrome => 127.0.0.1
// Android emulator => 10.0.2.2
// Real device => your PC IP (e.g. 192.168.1.7)
const String baseUrl = 'http://127.0.0.1:8000';

class PetPulseApp extends StatelessWidget {
  const PetPulseApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PetPulse',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
        textTheme: GoogleFonts.poppinsTextTheme(),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}

class Pet {
  int? id;
  String name;
  String species;
  int age;
  String ownerName;

  Pet({this.id, required this.name, required this.species, required this.age, required this.ownerName});

  factory Pet.fromJson(Map<String, dynamic> json) => Pet(
        id: json['id'],
        name: json['name'],
        species: json['species'],
        age: json['age'],
        ownerName: json['owner_name'],
      );

  Map<String, dynamic> toJson() => {
        'name': name,
        'species': species,
        'age': age,
        'owner_name': ownerName,
      };
}

class ApiService {
  final String apiBase;
  ApiService({required this.apiBase});

  Future<List<Pet>> fetchPets() async {
    final res = await http.get(Uri.parse('$apiBase/api/pets'));
    if (res.statusCode == 200) {
      final List data = jsonDecode(res.body);
      return data.map((e) => Pet.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load pets');
    }
  }

  Future<Pet> addPet(Pet pet) async {
    final res = await http.post(
      Uri.parse('$apiBase/api/pets'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(pet.toJson()),
    );
    if (res.statusCode == 201) return Pet.fromJson(jsonDecode(res.body));
    throw Exception('Failed to add pet');
  }

  Future<Pet> updatePet(int id, Pet pet) async {
    final res = await http.put(
      Uri.parse('$apiBase/api/pets/$id'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(pet.toJson()),
    );
    if (res.statusCode == 200) return Pet.fromJson(jsonDecode(res.body));
    throw Exception('Failed to update pet');
  }

  Future<void> deletePet(int id) async {
    final res = await http.delete(Uri.parse('$apiBase/api/pets/$id'));
    if (res.statusCode != 204) throw Exception('Failed to delete pet');
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final api = ApiService(apiBase: baseUrl);
  List<Pet> pets = [];
  bool loading = true;

  @override
  void initState() {
    super.initState();
    _loadPets();
  }

  Future<void> _loadPets() async {
    setState(() => loading = true);
    try {
      pets = await api.fetchPets();
    } catch (e) {
      if (mounted) ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: $e')));
    } finally {
      setState(() => loading = false);
    }
  }

  Future<void> _deletePet(int id) async {
    await api.deletePet(id);
    _loadPets();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PetPulse 🐾'),
        centerTitle: true,
        backgroundColor: Colors.teal.shade400,
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          final added = await Navigator.push(context, MaterialPageRoute(builder: (_) => AddEditPetPage(api: api)));
          if (added == true) _loadPets();
        },
        icon: const Icon(Icons.add),
        label: const Text('Add Pet'),
      ),
      body: RefreshIndicator(
        onRefresh: _loadPets,
        child: loading
            ? const Center(child: CircularProgressIndicator())
            : pets.isEmpty
                ? const Center(child: Text('No pets added yet 🐶'))
                : AnimationLimiter(
                    child: ListView.builder(
                      itemCount: pets.length,
                      itemBuilder: (context, i) {
                        final pet = pets[i];
                        return AnimationConfiguration.staggeredList(
                          position: i,
                          duration: const Duration(milliseconds: 300),
                          child: SlideAnimation(
                            verticalOffset: 50,
                            child: FadeInAnimation(
                              child: Card(
                                margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                                elevation: 4,
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                                child: ListTile(
                                  title: Text(pet.name, style: const TextStyle(fontWeight: FontWeight.w600)),
                                  subtitle: Text('${pet.species} • ${pet.age} yrs\nOwner: ${pet.ownerName}'),
                                  isThreeLine: true,
                                  trailing: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      IconButton(
                                          icon: const Icon(Icons.edit, color: Colors.teal),
                                          onPressed: () async {
                                            final updated = await Navigator.push(
                                                context, MaterialPageRoute(builder: (_) => AddEditPetPage(api: api, pet: pet)));
                                            if (updated == true) _loadPets();
                                          }),
                                      IconButton(
                                          icon: const Icon(Icons.delete, color: Colors.red),
                                          onPressed: () => _deletePet(pet.id!)),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
      ),
    );
  }
}

class AddEditPetPage extends StatefulWidget {
  final ApiService api;
  final Pet? pet;
  const AddEditPetPage({super.key, required this.api, this.pet});

  @override
  State<AddEditPetPage> createState() => _AddEditPetPageState();
}

class _AddEditPetPageState extends State<AddEditPetPage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController nameCtrl;
  late TextEditingController speciesCtrl;
  late TextEditingController ageCtrl;
  late TextEditingController ownerCtrl;
  bool saving = false;

  @override
  void initState() {
    super.initState();
    final p = widget.pet;
    nameCtrl = TextEditingController(text: p?.name ?? '');
    speciesCtrl = TextEditingController(text: p?.species ?? '');
    ageCtrl = TextEditingController(text: p?.age.toString() ?? '');
    ownerCtrl = TextEditingController(text: p?.ownerName ?? '');
  }

  Future<void> _savePet() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => saving = true);

    final pet = Pet(
      name: nameCtrl.text.trim(),
      species: speciesCtrl.text.trim(),
      age: int.tryParse(ageCtrl.text.trim()) ?? 0,
      ownerName: ownerCtrl.text.trim(),
    );

    try {
      if (widget.pet == null) {
        await widget.api.addPet(pet);
      } else {
        await widget.api.updatePet(widget.pet!.id!, pet);
      }
      if (mounted) Navigator.pop(context, true);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: $e')));
    } finally {
      setState(() => saving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isEdit = widget.pet != null;
    return Scaffold(
      appBar: AppBar(
        title: Text(isEdit ? 'Edit Pet' : 'Add Pet'),
        backgroundColor: Colors.teal.shade400,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: nameCtrl,
                decoration: const InputDecoration(labelText: 'Pet Name', border: OutlineInputBorder()),
                validator: (v) => v!.isEmpty ? 'Enter name' : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: speciesCtrl,
                decoration: const InputDecoration(labelText: 'Species', border: OutlineInputBorder()),
                validator: (v) => v!.isEmpty ? 'Enter species' : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: ageCtrl,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Age', border: OutlineInputBorder()),
                validator: (v) => v!.isEmpty ? 'Enter age' : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: ownerCtrl,
                decoration: const InputDecoration(labelText: 'Owner Name', border: OutlineInputBorder()),
                validator: (v) => v!.isEmpty ? 'Enter owner name' : null,
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: saving ? null : _savePet,
                  icon: saving
                      ? const SizedBox(width: 18, height: 18, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
                      : const Icon(Icons.save),
                  label: Text(isEdit ? 'Update' : 'Add'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
