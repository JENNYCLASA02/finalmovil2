import 'dart:convert';

import 'package:http/http.dart' as http;

import '../model/Stories.dart';

class StoryProviders {
  final url = Uri.parse('http://jeyliss05.pythonanywhere.com/api/historias');
  Future<List<Stories>> fetchStories() async {
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      List<Stories> stories = [];
      for (var item in jsonData) {
        stories.add(Stories(
            description: item['descripcion'],
            image_url: item['imagen_url'],
            tittle: item['titulo']));
      }
      return stories;
    } else {
      throw Exception('Error en el provider');
    }
  }
}
