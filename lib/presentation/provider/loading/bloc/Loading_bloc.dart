// lib/bloc/loading_bloc.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

// State
abstract class LoadingState extends Equatable {
  const LoadingState();
  
  @override
  List<Object?> get props => [];
}

class LoadingInitial extends LoadingState {}

class LoadingInProgress extends LoadingState {}

class LoadingSuccess extends LoadingState {
  final Map<String, dynamic> data;
  const LoadingSuccess(this.data);
  
  @override
  List<Object?> get props => [data];
}

class LoadingFailure extends LoadingState {
  final String error;
  const LoadingFailure(this.error);
  
  @override
  List<Object?> get props => [error];
}

// Event
abstract class LoadingEvent extends Equatable {
  const LoadingEvent();
  
  @override
  List<Object?> get props => [];
}

class StartLoading extends LoadingEvent {}

// Bloc
class LoadingBloc extends Bloc<LoadingEvent, LoadingState> {
  LoadingBloc() : super(LoadingInitial()) {
    on<StartLoading>((event, emit) async {
      emit(LoadingInProgress());
      
      try {
        // Simulasi loading data
        await Future.delayed(const Duration(seconds: 2));
        final data = await fetchData();
        emit(LoadingSuccess(data));
      } catch (e) {
        emit(LoadingFailure(e.toString()));
      }
    });
  }

  Future<Map<String, dynamic>> fetchData() async {
    // Implementasi fetch data Anda di sini
    return {'message': 'Data berhasil dimuat'};
  }
}