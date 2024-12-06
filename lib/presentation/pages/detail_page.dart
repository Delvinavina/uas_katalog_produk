import 'package:uas_katalog_produk/domain/entity/product.dart';
import 'package:uas_katalog_produk/presentation/provider/cart/bloc/cart_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductDetailPage extends StatefulWidget {
  final Product product;

  const ProductDetailPage({super.key, required this.product});

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
        child: SingleChildScrollView(
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
              SizedBox(height: 16),
              Text(
                'Deskripsi Produk',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              _buildProductDescription(),
              SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: selectedSize == null
                          ? null
                          : () {
                              context.read<CartBloc>().add(
                                  AddToCart(widget.product, selectedSize!));
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                      '${widget.product.name} ditambahkan ke keranjang'),
                                ),
                              );
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
      ),
    );
  }

  Widget _buildProductDescription() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildDescriptionItem(
          'Bahan Katun Berkualitas',
          'Lembut dan nyaman di kulit, menyerap keringat dengan baik.',
        ),
        SizedBox(height: 8),
        _buildDescriptionItem(
          'Desain Modern dan Elegan',
          'Kemeja dengan potongan slim fit yang menonjolkan bentuk tubuh dan memberikan kesan rapi.',
        ),
        SizedBox(height: 8),
        _buildDescriptionItem(
          'Kancing Tahan Lama',
          'Dilengkapi dengan kancing yang kuat dan tahan lama, membuat tampilan tetap sempurna.',
        ),
        SizedBox(height: 8),
        _buildDescriptionItem(
          'Pilihan Warna Beragam',
          'Tersedia dalam berbagai pilihan warna yang mudah dipadupadankan dengan celana atau aksesori favorit Anda.',
        ),
      ],
    );
  }

  Widget _buildDescriptionItem(String title, String description) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 4),
        Text(
          description,
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey[700],
          ),
        ),
      ],
    );
  }
}
