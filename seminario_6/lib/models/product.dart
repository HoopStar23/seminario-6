import 'dart:convert';

class Product {
  bool available;
  String name;
  String? picture;
  double price;
  String? id;
  String date;

  Product({
    required this.available,
    required this.name,
    this.picture,
    required this.price,
    this.id,
    required this.date,
  });

  factory Product.fromJson(String str) => Product.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Product.fromMap(Map<String, dynamic> json) => Product(
        available: json["available"],
        date: json["date"],
        name: json["name"],
        picture: json["picture"],
        price: json["price"]?.toDouble(),
        id: json["id"],
      );

  Product copy() => Product(
        available: this.available,
        date: this.date,
        name: this.name,
        price: this.price,
        picture: this.picture,
        id: this.id,
      );

  Map<String, dynamic> toMap() => {
        "available": available,
        "date": date,
        "name": name,
        "picture": picture,
        "price": price,
        "id": id,
      };
}
