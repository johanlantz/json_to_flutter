library json_to_flutter;

import 'package:flutter/material.dart';
import 'package:json_to_flutter/builders/builders.dart';
import 'package:json_to_flutter/states/input_state.dart';
import 'package:provider/provider.dart';

class JSONToFlutter {
  static Map<String, Map<String, dynamic>> _contentMapper = {};

  static Widget getPage(String contentKey) {
    InputState inputState = InputState();
    inputState.setRootPage(contentKey);
    return ChangeNotifierProvider<InputState>(
        builder: (context) => inputState, child: _JSONToFlutterPage());
  }

  static setContent(String key, dynamic value) {
    _contentMapper[key] = value;
  }

  /// App can assign a custom "not_found" page to show in case of an error.
  static Map<String, dynamic> getContent(String key) {
    return _contentMapper[key] ??
        _contentMapper['not_found'] ??
        {
          "Text": {"data": "$key Not found"}
        };
  }
}

class _JSONToFlutterPage extends StatefulWidget {
  _JSONToFlutterPage();

  @override
  _JSONToFlutterPageState createState() => _JSONToFlutterPageState();
}

/// 1. Manage building all dynamic content 
/// 2. Control popping dynamic pages. We maintain an internal navigation stack until we reach
/// the bottom, then we let the system control the popping in case there are other pages beneath.
class _JSONToFlutterPageState extends State<_JSONToFlutterPage> {
  @override
  Widget build(BuildContext context) {
    var inputState = Provider.of<InputState>(context);
    WidgetBuilderBase b = getBuilder(inputState.getCurrentPage());
    return WillPopScope(
        onWillPop: () async {
          bool didPop = inputState.pop();
          return !didPop;
        }, child: b.build(context));
  }
}
