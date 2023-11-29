import 'dart:convert';

import 'package:http/http.dart' as http;

import '../Model/User.dart';
import '../Model/userLogin.dart';

class AuthenticationRepository {
  Future<UserLogin> login(String username, String password) async {
    final response = await http.post(
      Uri.parse('http://jeyliss05.pythonanywhere.com/api/verificarusuario'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'nombreusuario': username,
        'contrasena': password,
      }),
    );

    if (response.statusCode == 200) {
      return UserLogin.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load user');
    }
  }

  Future<User> getUserDetails(String username) async {
    final response = await http.get(
      Uri.parse('http://jeyliss05.pythonanywhere.com/api/usuarios'),
    );

    if (response.statusCode == 200) {
      final List<dynamic> users = jsonDecode(response.body);

      // Encuentra y devuelve los detalles del usuario correspondiente
      final userDetails = users.firstWhere(
        (user) => user['nombreusuario'] == username,
        orElse: () => null,
      );

      if (userDetails != null) {
        return User.fromJson(userDetails);
      } else {
        throw Exception('Usuario no encontrado');
      }
    } else {
      throw Exception('Fallo al cargar el usuario');
    }
  }
}
