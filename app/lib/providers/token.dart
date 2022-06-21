import 'dart:async';
import 'dart:convert';
import 'package:localstorage/localstorage.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

class TokenProvider with ChangeNotifier {
  Future<void> fetchToken() async {
    String secret = "";
    String id = "";
    String url = 'https://api.intra.42.fr/oauth/token';
    Map body = {
      "grant_type": "client_credentials",
      "client_id": id,
      "client_secret": secret,
    };
    try {
      final response = await http.post(Uri.parse(url),
          headers: {'Content-type': 'application/json'},
          body: jsonEncode(body));
      Map responseObject = await jsonDecode(response.body);
      if (response.statusCode == 200) {
        final LocalStorage storage = LocalStorage('client_info');
        storage.ready.then((_) async {
          await storage.setItem("client", responseObject);
        });
      } else {
        throw Exception("failed to load data");
      }
    } catch (e) {
      rethrow;
    }
  }
}
