enum Status { initial, loading, success, error }

class RegisterState {
  final Status status;
  final String? message;

  const RegisterState({required this.status, this.message});

  RegisterState copyWith({Status? status, String? message}) {
    return RegisterState(
      status: status ?? this.status,
      message: message ?? this.message,
    );
  }
}
