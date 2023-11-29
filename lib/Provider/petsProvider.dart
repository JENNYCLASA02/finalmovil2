import 'dart:convert';

import 'package:http/http.dart' as http;

import '../model/Animal.dart';

class PetsProvider {
  final url = Uri.parse('http://jeyliss05.pythonanywhere.com/api/animales');

  Future<List<Pets>> fetchPets() async {
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      List<Pets> pets = [];
      for (var item in jsonData) {
        pets.add(Pets(
          description: item['descripcion'],
          age: item['edad'],
          id: item['id'],
          image_url: item['imagen_url'],
          location: item['ubicacion'],
          name: item['nombre'],
          state: item['estado'],
        ));
      }
      return pets;
    } else {
      throw Exception('Error en el provider');
    }
  }

  Future<List<Pets>> fetchLocation(String location) async {
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List<dynamic> jsonData = json.decode(response.body);

      List<Pets> filteredPets =
          jsonData.map((pets) => Pets.fromJson(pets)).where((pets) {
        final petLocation = pets.location.toLowerCase();
        final selectedLocation = location.toLowerCase();
        return location == 'Todos' || petLocation == selectedLocation;
      }).toList();

      return filteredPets;
    } else {
      throw Exception('Error en location');
    }
  }
}
