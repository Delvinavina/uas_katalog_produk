
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
        appBar: AppBar(
          title: const Text('Loading Page'),
        ),
        body: BlocBuilder<LoadingBloc, LoadingState>(
          builder: (context, state) {
            if (state is LoadingInProgress) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            
            if (state is LoadingSuccess) {
              return Center(
                child: Text(state.data['message'] ?? 'Success'),
              );
            }
            
            if (state is LoadingFailure) {
              return Center(
                child: Text('Error: ${state.error}'),
              );
            }
            
            // LoadingInitial
            return Center(
              child: ElevatedButton(
                onPressed: () {
                  context.read<LoadingBloc>().add(StartLoading());
                },
                child: const Text('Start Loading'),
              ),
            );
          },
        ),
      ),
    );
  }
}