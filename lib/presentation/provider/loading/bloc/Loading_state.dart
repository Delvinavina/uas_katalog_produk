abstract class LoadingState {
  const LoadingState();
}

class LoadingInitial extends LoadingState {}

class LoadingInProgress extends LoadingState {}

class LoadingSuccess extends LoadingState {
  final dynamic data;
  LoadingSuccess(this.data);
}

class LoadingFailure extends LoadingState {
  final String error;
  LoadingFailure(this.error);
}
