library json_to_flutter;

import 'package:flutter/material.dart';
import 'package:json_to_flutter/builders/builders.dart';
import 'package:json_to_flutter/states/input_state.dart';
import 'package:provider/provider.dart';



class JSONToFlutterPage extends StatefulWidget {
  
  JSONToFlutterPage();
  
  @override
  _JSONToFlutterPageState createState() => _JSONToFlutterPageState();
}

class _JSONToFlutterPageState extends State<JSONToFlutterPage> with WidgetsBindingObserver {

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