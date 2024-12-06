import 'package:uas_katalog_produk/presentation/pages/success_payment.dart';
import 'package:uas_katalog_produk/presentation/provider/cart/bloc/cart_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  bool useOlaifCash = false;
  int selectedPaymentMethod = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pembayaran'),
        centerTitle: true,
      ),
      body: BlocBuilder<CartBloc, CartState>(
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Use Olaif Cash
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Gunakan ProdukPay',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    Switch(
                      value: useOlaifCash,
                      onChanged: (value) {
                        setState(() {
                          useOlaifCash = value;
                        });
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                const Row(
                  children: [
                    Icon(Icons.account_balance_wallet, size: 20),
                    SizedBox(width: 8),
                    Text('Rp 2.000.000',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold)),
                  ],
                ),
                const Divider(height: 32),

                // Metode Lainnya
                const Text(
                  'Metode Lainnya',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                ListTile(
                  title: const Text('Pembayaran Bank & Cicilan'),
                  leading: Radio(
                    value: 1,
                    groupValue: selectedPaymentMethod,
                    onChanged: (value) {
                      setState(() {
                        selectedPaymentMethod = value as int;
                      });
                    },
                  ),
                ),
                const Divider(height: 32),

                // Ringkasan Pembayaran
                const Text(
                  'Ringkasan Pembayaran',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Total Tagihan', style: TextStyle(fontSize: 16)),
                    Text(
                      'Rp. ${state.items.fold(0, (previousValue, element) {
                        return (previousValue +
                                element.quantity * element.product.price)
                            .toInt();
                      })}',
                      style: const TextStyle(fontSize: 16),
                    )
                  ],
                ),
                const Spacer(),

                // Cashback and Bottom Button
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Total Bayar',
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
                        )
                      ],
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => PaymentSuccessPage(),
                        ));
                      }, // Disabled button
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(double.infinity, 50),
                      ),
                      child: const Text('LANJUTKAN'),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
