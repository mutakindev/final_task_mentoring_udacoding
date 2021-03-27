import 'dart:convert';

class LoginResponse {
  int value;
  String username;
  String fullname;
  String email;
  String address;
  String sex;
  String message;
  LoginResponse({
    this.value,
    this.username,
    this.fullname,
    this.email,
    this.address,
    this.sex,
    this.message,
  });

  factory LoginResponse.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return LoginResponse(
      value: map['value'],
      username: map['username'],
      fullname: map['name'],
      email: map['email'],
      address: map['address'],
      sex: map['sex'],
      message: map['message'],
    );
  }

  factory LoginResponse.fromJson(String source) =>
      LoginResponse.fromMap(json.decode(source));

  @override
  String toString() {
    return 'UserResponse(value: $value, username: $username, fullname: $fullname, message: $message)';
  }
}

class LoginRequest {
  String username;
  String password;

  LoginRequest({this.username, this.password});

  Map<String, dynamic> toJson() {
    return {
      'username': username.trim(),
      'password': password.trim(),
    };
  }
}

class RegisterRequest {
  String username;
  String email;
  String fullname;
  String sex;
  String password;
  String address;
  RegisterRequest({
    this.username,
    this.email,
    this.fullname,
    this.sex,
    this.password,
    this.address,
  });

  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'email': email,
      'full_name': fullname,
      'sex': sex,
      'password': password,
      'address': address,
    };
  }
}

class RegisterResponse {
  int value;
  String message;
  RegisterResponse({
    this.value,
    this.message,
  });

  factory RegisterResponse.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return RegisterResponse(
      value: map['value'],
      message: map['message'],
    );
  }

  factory RegisterResponse.fromJson(String source) =>
      RegisterResponse.fromMap(json.decode(source));
}
