class ApiErrorModel {
  int? status;
  String? message;
  Errors? errors;

  ApiErrorModel({this.status, this.message, this.errors});

  ApiErrorModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    errors = json['errors'] == null ? null : Errors.fromJson(json['errors']);
  }
}

class Errors {
  List<String>? email;

  Errors({this.email});

  Errors.fromJson(Map<String, dynamic> json) {
    email = json['email'] == null ? null : List<String>.from(json['email']);
  }
}
