import 'package:equatable/equatable.dart';

class Product extends Equatable {
  final int id;
  final String name;
  final double price;
  final String imageAsset;
  final List<String> sizes;

  const Product({
    required this.id,
    required this.name,
    required this.price,
    required this.imageAsset,
    required this.sizes,
  });

  @override
  List<Object?> get props => [id, name, price, imageAsset, sizes];

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'imageAsset': imageAsset,
      'sizes': sizes,
    };
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      id: map['id'],
      name: map['name'],
      price: map['price'],
      imageAsset: map['imageAsset'],
      sizes: List<String>.from(map['sizes']),
    );
  }
}
