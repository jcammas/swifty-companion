import 'dart:async';
import 'dart:convert';
import 'package:app/models/user.dart';

import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

class GetUser with ChangeNotifier {
  Future<User> fetchUser(String token, String name) async {
    String url = "https://api.intra.42.fr/v2/users/$name";
    try {
      final response = await http.get(
        Uri.parse(url),
        headers: {'Authorization': 'Bearer $token'},
      );
      if (response.statusCode == 200) {
        // print(response.body);
        return User.fromJson(jsonDecode(response.body));
      } else {
        throw Exception("failed to load data");
      }
    } catch (e) {
      rethrow;
    }
  }
}
