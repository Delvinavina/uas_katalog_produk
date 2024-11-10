part of 'cart_bloc.dart';

class CartState extends Equatable {
  final List<CartItem> items;

  const CartState({required this.items});

  @override
  List<Object> get props => [items];
}
