import 'dart:convert';

import 'package:http/http.dart' as http;

import '../model/category.dart';

class CategoryProvider {
  final url = Uri.parse('http://jeyliss05.pythonanywhere.com/api/categorias');

  Future<List<Category>> fetchCategory() async {
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      List<Category> categories = [];
      for (var item in jsonData) {
        categories
            .add(Category(image_url: item['imagen_url'], name: item['nombre']));
      }
      return categories;
    } else {
      throw Exception('Error en el provider');
    }
  }
}
