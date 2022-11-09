import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AuthService extends ChangeNotifier {
  final String _baseUrl = 'identitytoolkit.googleapis.com';
  final String _firebaseToke = 'AIzaSyCWr4Ym5by0GJQYfCihbHaboCDcElyTojY';

  Future<String?> createUser(String email, String password) async {
    final Map<String, dynamic> authData = {'email': email, 'password': password};

    final url = Uri.https(_baseUrl, '/v1/accounts:signUp', {'key': _firebaseToke});

    final resp = await http.post(url, body: json.encode(authData));
    final Map<String, dynamic> respDecoded = json.decode(resp.body);
    print(respDecoded);
    return null;
  }
}
