import 'dart:io';

import 'package:flutter/material.dart';
import 'package:json_to_flutter/actions/action_handler.dart';
import 'package:http/http.dart' as http;

class ActionHandlerPost extends ActionHandler {
  static const String ACTION_POST = "post";
  

  @override
  Future<bool> handleAction(
      String actionName, dynamic data, BuildContext context) async {
    if (actionName == ACTION_POST) {
      return _post(data, context);
    } else {
      return false;
    }
  }

  Future<bool> _post(Map<String, dynamic> data, BuildContext context) async {
    var response = await http.post(data['uri'],
    headers: {HttpHeaders.authorizationHeader: data['token']});
    if (response.statusCode != 200) {
      return false;
    } 
    return true;
  }
}
