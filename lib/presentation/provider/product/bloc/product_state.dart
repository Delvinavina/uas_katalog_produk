part of 'product_bloc.dart';

class ProductState extends Equatable {
  final List<Product> products;

  const ProductState({required this.products});

  @override
  List<Object> get props => [products];
}
