import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uas_katalog_produk/presentation/provider/loading/bloc/Loading_bloc.dart';

class LoadingPage extends StatelessWidget {
  const LoadingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoadingBloc(),
      child: Scaffold(
        backgroundColor: Colors.purple[50], // Background warna ungu muda
        appBar: AppBar(
          title: const Text(
            'Welcome Katalog Produk',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.purple[200], // AppBar warna ungu muda
        ),
        body: BlocBuilder<LoadingBloc, LoadingState>(
          builder: (context, state) {
            if (state is LoadingInProgress) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(
                      color: Colors.purple[300], // Loading indicator ungu
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Loading...',
                      style: TextStyle(
                        color: Colors.purple[400],
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              );
            }
            
            if (state is LoadingSuccess) {
              return Center(
                child: Text(
                  state.data['message'] ?? 'Success',
                  style: TextStyle(
                    color: Colors.purple[400],
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              );
            }
            
            if (state is LoadingFailure) {
              return Center(
                child: Text(
                  'Error: ${state.error}',
                  style: TextStyle(
                    color: Colors.purple[400],
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              );
            }
            
            // LoadingInitial
            return Center(
              child: ElevatedButton(
                onPressed: () {
                  context.read<LoadingBloc>().add(StartLoading());
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.purple[200],
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 12,
                  ),
                ),
                child: const Text(
                  'Start Loading',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}