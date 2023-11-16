import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:mdtt/model/contact.dart';

class ContactApi {
  final _httpClient = HttpClient();

  static const host = 'api.byteplex.info';
  static const path = '/api/test/contact/';

  Future<void> postContact(Contact contact) async { 
    final params = contact.toJson();
  
    final request = await _httpClient.postUrl(Uri.https(host, path));
    request.headers.set('Content-type', 'application/json; charset=UTF-8');
    request.write((json.encode(params)));
    final response = await request.close();
    if (response.statusCode == 201) {
      return;
    } else {
      throw Exception('error post contact');
    }
  }
}