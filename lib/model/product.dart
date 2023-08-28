class Product {
  String? name;
  int? id;
  String? message;
  Product({this.id, this.name, this.message});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> product = <String, dynamic>{};
    product['id'] = id;
    product['name'] = name;
    product['message'] = message;
    return product;
  }

  factory Product.fromJson(Map<String, dynamic>? json) {
    return Product(
        id: json?['id'],
         name: json?['name'],
         message: json?['message']);
  }
}
