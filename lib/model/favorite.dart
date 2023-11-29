class Favorite {
  final int animal;
  final int usuario;

  Favorite({required this.animal, required this.usuario});

  factory Favorite.fromJson(Map<String, dynamic> json) {
    return Favorite(animal: json['animal'], usuario: json['usuario']);
  }
}
