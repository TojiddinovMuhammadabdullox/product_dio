class Product {
  int id;
  String title;
  double price;
  String description;
  int categoryId;
  List<String> images;

  Product({
    required this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.categoryId,
    required this.images,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json['id'],
        title: json['title'],
        price: json['price'].toDouble(),
        description: json['description'],
        categoryId: json['category']['id'],
        images: List<String>.from(json['images']),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'price': price,
        'description': description,
        'categoryId': categoryId,
        'images': images,
      };
}
