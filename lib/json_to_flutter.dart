library json_to_flutter;

import 'package:flutter/material.dart';
import 'package:json_to_flutter/builders/builders.dart';
import 'package:json_to_flutter/states/input_state.dart';
import 'package:provider/provider.dart';

class JSONToFlutter {
  static Map<String, Map<String, dynamic>> _contentMapper = {};
  static InputState _inputState = InputState();
  static _JSONToFlutterPage _thePage = _JSONToFlutterPage();
  static ChangeNotifierProvider provider = ChangeNotifierProvider<InputState>(
            builder: (context) => _inputState,
            child: _thePage);

  static Widget getPage(String contentKey) {
    _inputState.setRootPage(contentKey);
    return provider;
  }

  static setContent(String key, dynamic value) {
    _contentMapper[key] = value;
  }

  /// App can assign a custom "not_found" page to show in case of an error.
  static Map<String, dynamic> getContent(String key) {
    return _contentMapper[key] ?? _contentMapper['not_found'] ?? {"Text": {"data": "$key Not found"}};
  }
}

class _JSONToFlutterPage extends StatefulWidget {
  
  _JSONToFlutterPage();
  
  @override
  _JSONToFlutterPageState createState() => _JSONToFlutterPageState();
}

class _JSONToFlutterPageState extends State<_JSONToFlutterPage> with WidgetsBindingObserver {

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  didPopRoute(){
    var inputState = Provider.of<InputState>(context);
    inputState.pop();
    return new Future<bool>.value(true);
  }

  @override
  Widget build(BuildContext context) {
    var inputState = Provider.of<InputState>(context);
    
    WidgetBuilderBase b = getBuilder(inputState.getCurrentPage());

    return b.build(context);
  }
}