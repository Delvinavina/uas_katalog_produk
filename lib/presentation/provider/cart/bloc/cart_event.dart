part of 'cart_bloc.dart';

abstract class CartEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class AddToCart extends CartEvent {
  final Product product;
  final String size;

  AddToCart(this.product, this.size);

  @override
  List<Object> get props => [product];
}

class RemoveFromCart extends CartEvent {
  final int productId;
  final String size;

  RemoveFromCart(this.productId, this.size);

  @override
  List<Object> get props => [productId];
}

class UpdateQuantity extends CartEvent {
  final int productId;
  final int quantity;
  final String size;

  UpdateQuantity(this.productId, this.quantity, this.size);

  @override
  List<Object> get props => [productId, quantity];
}
