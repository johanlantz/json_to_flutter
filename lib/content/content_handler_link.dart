import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import 'content_handler.dart';

class ContentHandlerLink extends ContentHandler {
  Map<String, String> _contentRegistry = {};

  @override
  Future<Map<String, dynamic>> getContent(String key) async {
    Map<String, dynamic> jsonResponse;

    var response = await http.get(_contentRegistry[key]);
    if (response.statusCode == 200) {
      jsonResponse = convert.jsonDecode(response.body);
    } else {
      print("Request failed with status: ${response.statusCode}.");
    }
    return jsonResponse ??
        _contentRegistry['not_found'] ??
        {
          "Text": {"data": "$key Not found"}
        };
  }

  @override
  registerContent(String key, dynamic value) {
    _contentRegistry[key] = value;
  }

  @override
  Future<bool> updateContent(String key, value) async {
    return false;
  }

  @override
  Future<List<String>> getIndex() async {
   return _contentRegistry.keys.toList();
  }
}
