import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AuthService extends ChangeNotifier {
  final String _baseUrl = 'identitytoolkit.googleapis.com';
  final String _firebaseToke = 'AIzaSyCWr4Ym5by0GJQYfCihbHaboCDcElyTojY';
  final storage = const FlutterSecureStorage();

  // Si retorna un String, es un error, si retorna un null, todo esta Ok.
  Future<String?> createUser(String email, String password) async {
    final Map<String, dynamic> authData = {'email': email, 'password': password};

    final url = Uri.https(_baseUrl, '/v1/accounts:signUp', {'key': _firebaseToke});

    final resp = await http.post(url, body: json.encode(authData));
    final Map<String, dynamic> respDecoded = json.decode(resp.body);
    if (respDecoded.containsKey('idToken')) {
      //Token guardar storage
      await storage.write(key: 'token', value: respDecoded['idToken']);
      return null;
    } else {
      return respDecoded['error']['message'];
    }
  }

  // Si retorna un String, es un error, si retorna un null, todo esta Ok.
  Future<String?> login(String email, String password) async {
    final Map<String, dynamic> authData = {'email': email, 'password': password};

    final url = Uri.https(_baseUrl, '/v1/accounts:signInWithPassword', {'key': _firebaseToke});

    final resp = await http.post(url, body: json.encode(authData));
    final Map<String, dynamic> respDecoded = json.decode(resp.body);
    if (respDecoded.containsKey('idToken')) {
      //Token guardar storage
      await storage.write(key: 'token', value: respDecoded['idToken']);
      return null;
    } else {
      return respDecoded['error']['message'];
    }
  }

  Future logout() async {
    await storage.delete(key: 'token');
    return;
  }

  Future<String> readToken() async {
    return await storage.read(key: 'token') ?? '';
  }
}
