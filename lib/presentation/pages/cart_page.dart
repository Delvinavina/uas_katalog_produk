import 'package:uas_katalog_produk/presentation/pages/checkout.dart';
import 'package:uas_katalog_produk/presentation/provider/cart/bloc/cart_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomSheet: Container(
          width: double.infinity,
          decoration: const BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10), topRight: Radius.circular(10))),
          child: BlocBuilder<CartBloc, CartState>(
            builder: (context, state) {
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Total Items:',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          '${state.items.length}',
                          style: const TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Total Price:',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'Rp. ${state.items.fold(0, (previousValue, element) {
                            return (previousValue +
                                    element.quantity * element.product.price)
                                .toInt();
                          })}',
                          style: const TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const PaymentScreen(),
                        ));
                      },
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(double.infinity, 50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Text('Checkout'),
                    ),
                  ],
                ),
              );
            },
          )),
      appBar: AppBar(title: const Text('Cart')),
      body: BlocBuilder<CartBloc, CartState>(
        builder: (context, state) {
          if (state.items.isEmpty) {
            return const Center(child: Text('Your cart is empty'));
          }
          return Padding(
            padding: const EdgeInsets.only(bottom: 120.0),
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2),
              itemCount: state.items.length,
              itemBuilder: (context, index) {
                final item = state.items[index];
                return Card(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Center(
                          child: Image.asset(
                            'assets/${item.product.imageAsset}',
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          item.product.name,
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          item.size,
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.remove),
                            onPressed: () {
                              context.read<CartBloc>().add(UpdateQuantity(
                                  item.product.id,
                                  item.quantity - 1,
                                  item.size));
                            },
                          ),
                          Text('${item.quantity}'),
                          IconButton(
                            icon: const Icon(Icons.add),
                            onPressed: () {
                              context.read<CartBloc>().add(UpdateQuantity(
                                  item.product.id,
                                  item.quantity + 1,
                                  item.size));
                            },
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () {
                              context.read<CartBloc>().add(
                                  RemoveFromCart(item.product.id, item.size));
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                );
                // return ListTile(
                //   title: Text(item.product.name),
                //   subtitle: Text('\$${item.product.price.toStringAsFixed(2)}'),
                //   trailing: Row(
                //     mainAxisSize: MainAxisSize.min,
                //     children: [
                //       IconButton(
                //         icon: Icon(Icons.remove),
                //         onPressed: () {
                //           context.read<CartBloc>().add(
                //               UpdateQuantity(item.product.id, item.quantity - 1,item.size));
                //         },
                //       ),
                //       Text('${item.quantity}'),
                //       IconButton(
                //         icon: Icon(Icons.add),
                //         onPressed: () {
                //           context.read<CartBloc>().add(
                //               UpdateQuantity(item.product.id, item.quantity + 1));
                //         },
                //       ),
                //       IconButton(
                //         icon: Icon(Icons.delete),
                //         onPressed: () {
                //           context
                //               .read<CartBloc>()
                //               .add(RemoveFromCart(item.product.id));
                //         },
                //       ),
                //     ],
                //   ),
                // );
              },
            ),
          );
        },
      ),
    );
  }
}
