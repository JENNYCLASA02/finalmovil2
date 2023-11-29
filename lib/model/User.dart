class User {
  final String phone;
  final String password;
  final String email;
  final bool? state;
  final String name;
  final String nameUser;
  final String typeuser;
  final int id;

  User({
    required this.phone,
    required this.password,
    required this.email,
    this.state,
    required this.name,
    required this.nameUser,
    required this.typeuser,
    required this.id
  });

  factory User.fromJson(Map<String, dynamic> json) {
    try {
      return User(
        phone: json['celular'] ?? '',
        password: json['contrasena'] ?? '',
        email: json['correo'] ?? '',
        state: json['estado'] ?? true,
        name: json['nombre'] ?? '',
        nameUser: json['nombreusuario'] ?? '',
        typeuser: json['tipousuario'] ?? '',
        id: json['id'] ?? 0
      );
    } catch (e) {
      print('Error al convertir json a User: $e');
      return User(
        phone: '',
        password: '',
        email: '',
        state: false,
        name: '',
        nameUser: '',
        typeuser: '',
        id: 0
      );
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'celular': phone,
      'contraseña': password,
      'correo': email,
      'estado': state,
      'nombre': name,
      'nombreusuario': nameUser,
      'tipousuario': typeuser,
      'id': id
    };
  }
}
