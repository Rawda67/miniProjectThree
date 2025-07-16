import 'dart:convert';
import 'package:dio/dio.dart';

class AuthService {
  final Dio dio = Dio();
  List<String> tokenList = [];

  Future<bool> login(String username, String password) async {
    try {
      final url = 'https://dummyjson.com/auth/login';
      final resp = await dio.post(
        url,
        data: json.encode({'username': username, 'password': password}),
        options: Options(contentType: Headers.jsonContentType),
      );

      if (resp.statusCode == 200) {
        final data = resp.data;
        String? token = data['token'];
        if (token != null) tokenList.add(token);
        print("Token saved: $token");
        return true;
      } else {
        print('Login failed, status: ${resp.statusCode}');
        return false;
      }
    } catch (e) {
      print('Error during login: $e');
      return false;
    }
  }
}

// data to check
// Username: emilys
// Password: emilyspass
