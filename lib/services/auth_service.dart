import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AuthService extends ChangeNotifier {
  final String _baseUrl = 'identitytoolkit.googleapis.com';
  final String _firebaseToke = 'AIzaSyCWr4Ym5by0GJQYfCihbHaboCDcElyTojY';

  // Si retorna un String, es un error, si retorna un null, todo esta Ok.
  Future<String?> createUser(String email, String password) async {
    final Map<String, dynamic> authData = {'email': email, 'password': password};

    final url = Uri.https(_baseUrl, '/v1/accounts:signUp', {'key': _firebaseToke});

    final resp = await http.post(url, body: json.encode(authData));
    final Map<String, dynamic> respDecoded = json.decode(resp.body);
    if (respDecoded.containsKey('idToken')) {
      //Token guardar storage
      // return respDecoded['idToken'];
      return null;
    } else {
      return respDecoded['error']['message'];
    }
    return null;
  }

  // Si retorna un String, es un error, si retorna un null, todo esta Ok.
  Future<String?> login(String email, String password) async {
    final Map<String, dynamic> authData = {'email': email, 'password': password};

    final url = Uri.https(_baseUrl, '/v1/accounts:signInWithPassword', {'key': _firebaseToke});

    final resp = await http.post(url, body: json.encode(authData));
    final Map<String, dynamic> respDecoded = json.decode(resp.body);
    if (respDecoded.containsKey('idToken')) {
      //Token guardar storage
      // return respDecoded['idToken'];
      return null;
    } else {
      return respDecoded['error']['message'];
    }
    return null;
  }

}
