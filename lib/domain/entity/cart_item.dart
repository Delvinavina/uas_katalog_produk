import 'package:uas_katalog_produk/domain/entity/product.dart';
import 'package:equatable/equatable.dart';

class CartItem extends Equatable {
  final Product product;
  final int quantity;
  final String size;

  const CartItem(
      {required this.product, required this.quantity, required this.size});

  @override
  List<Object?> get props => [product, quantity];

  Map<String, dynamic> toMap() {
    return {'product': product.toMap(), 'quantity': quantity, 'size': size};
  }

  factory CartItem.fromMap(Map<String, dynamic> map) {
    return CartItem(
        product: Product.fromMap(map['product']),
        quantity: map['quantity'],
        size: map['size']);
  }
}
