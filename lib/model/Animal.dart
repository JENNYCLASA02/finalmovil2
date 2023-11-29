class Pets {
  final String description;
  final int age;
  final int id;
  final String image_url;
  final String name;
  final String location;
  final bool state;
  Pets({
    required this.description,
    required this.age,
    required this.id,
    required this.image_url,
    required this.location,
    required this.name,
    required this.state,
  });

  factory Pets.fromJson(Map<String, dynamic> json) {
    return Pets(
        description: json['descripcion'],
        age: json['edad'],
        id: json['id'],
        image_url: json['imagen_url'],
        location: json['ubicacion'],
        name: json['nombre'],
        state: json['estado']);
  }

  Pets toInformation() {
    return Pets(
      description: description,
      age: age,
      id: id,
      image_url: image_url,
      location: location,
      name: name,
      state: state,
    );
  }
}
