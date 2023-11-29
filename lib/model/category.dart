class Category {
  final String image_url;
  final String name;
  Category({required this.image_url, required this.name});

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      image_url: json['image_url'],
      name: json['nombre'],
    );
  }
}
