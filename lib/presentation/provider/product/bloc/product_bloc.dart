import 'package:uas_katalog_produk/domain/entity/product.dart';
import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends HydratedBloc<ProductEvent, ProductState> {
  ProductBloc() : super(const ProductState(products: [])) {
    on<LoadProducts>(_onLoadProducts);
  }

  void _onLoadProducts(LoadProducts event, Emitter<ProductState> emit) {

    final products = [
      const Product(
        id: 1,
        name: 'Kemeja Polos',
        price: 99000.0,
        imageAsset: '2.jpg',
        sizes: ['S', 'M', 'L', 'XL'],
      ),
      const Product(
        id: 2,
        name: 'Kemeja Kerja',
        price: 149000.0,
        imageAsset: '2.jpg',
        sizes: ['S', 'M', 'L', 'XL'],
      ),
      const Product(
        id: 3,
        name: 'Kemeja Garis',
        price: 199000.0,
        imageAsset: '3.jpg',
        sizes: ['S', 'M', 'L', 'XL'],
      ),
      const Product(
        id: 4,
        name: 'Kemeja Flannel',
        price: 189000.0,
        imageAsset: '3.jpg',
        sizes: ['S', 'M', 'L', 'XL'],
      ),
      const Product(
        id: 5,
        name: 'Kaos Berkerah',
        price: 229000.0,
        imageAsset: '2.jpg',
        sizes: ['S', 'M', 'L', 'XL'],
      ),
      const Product(
        id: 6,
        name: 'Kaos Cotton',
        price: 249000.0,
        imageAsset: '2.jpg',
        sizes: ['S', 'M', 'L', 'XL'],
      ),
       const Product(
        id: 7,
        name: 'Kaos ',
        price: 239000.0,
        imageAsset: '3.jpg',
        sizes: ['S', 'M', 'L', 'XL'],
      ),
       const Product(
        id: 8,
        name: 'Kaos - kaos ',
        price: 249000.0,
        imageAsset: '3.jpg',
        sizes: ['S', 'M', 'L', 'XL'],
      ),
    ];
    emit(ProductState(products: products));
  }

  @override
  ProductState? fromJson(Map<String, dynamic> json) {
    final productList = (json['products'] as List)
        .map((item) => Product.fromMap(item))
        .toList();
    return ProductState(products: productList);
  }

  @override
  Map<String, dynamic>? toJson(ProductState state) {
    return {
      'products': state.products.map((product) => product.toMap()).toList(),
    };
  }
}
