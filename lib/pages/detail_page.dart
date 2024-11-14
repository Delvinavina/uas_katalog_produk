import 'package:uas_katalog_produk/domain/entity/product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uas_katalog_produk/provider/cart/bloc/cart_bloc.dart';

class ProductDetailPage extends StatefulWidget {
  final Product product;

  const ProductDetailPage({Key? key, required this.product}) : super(key: key);

  @override
  _ProductDetailPageState createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  String? selectedSize;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.product.name),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset('assets/${widget.product.imageAsset}'),
            SizedBox(height: 16),
            Text(
              widget.product.name,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Text(
              'Rp ${widget.product.price.toStringAsFixed(0)}',
              style: TextStyle(fontSize: 20, color: Colors.grey[600]),
            ),
            SizedBox(height: 16),
            Text('Size', style: TextStyle(fontSize: 18)),
            SizedBox(height: 8),
            Wrap(
              spacing: 8.0,
              children: widget.product.sizes.map((size) {
                return ChoiceChip(
                  label: Text(size),
                  selected: selectedSize == size,
                  onSelected: (selected) {
                    setState(() {
                      selectedSize = selected ? size : null;
                    });
                  },
                );
              }).toList(),
            ),
            SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: selectedSize == null
                        ? null
                        : () {
                            context
                                .read<CartBloc>()
                                .add(AddToCart(widget.product, selectedSize!));
                          },
                    child: Text('Add to Cart'),
                    style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all<Color>(
                        selectedSize != null
                            ? Colors.blue.shade300
                            : Colors.grey,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
