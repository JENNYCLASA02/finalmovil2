class Stories {
  final String description;
  final String image_url;
  final String tittle;
  Stories(
      {required this.description,
      required this.image_url,
      required this.tittle});

  factory Stories.fromJson(Map<String, dynamic> json) {
    return Stories(
        description: json['description'],
        image_url: json['imagen_url'],
        tittle: json['tittle']);
  }
}
