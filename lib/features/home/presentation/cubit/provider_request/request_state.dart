abstract class RequestState {}

class RequestInit extends RequestState {}

class RequestLoading extends RequestState {}

class RequestSuccess extends RequestState {}

class RequestFailure extends RequestState {
  final String message;
  RequestFailure(this.message);
}
