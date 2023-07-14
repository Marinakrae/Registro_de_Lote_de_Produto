class Produtos {
  int id;
  String title;
  double price; // Ajuste o tipo para double
  String category;
  String description;
  String image;

  Produtos({
    required this.id,
    required this.title,
    required this.price,
    required this.category,
    required this.description,
    required this.image,
  });

  factory Produtos.fromJson(Map<String, dynamic> json) {
    return Produtos(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      price: (json['price'] ?? 0).toDouble(), // Converta para double
      category: json['category'] ?? '',
      description: json['description'] ?? '',
      image: json['image'] ?? '',
    );
  }

  @override
  String toString() {
    return 'Produto{id: $id, title: $title, price: $price, category: $category, description: $description, image: $image}';
  }
}
