library json_to_flutter;

import 'package:flutter/material.dart';
import 'package:json_to_flutter/builders/builders.dart';
import 'package:json_to_flutter/states/input_state.dart';
import 'package:provider/provider.dart';

import 'content/content_registry.dart';

class JSONToFlutter {

  /// Get a new dynamic page using contentKey as root
  /// Provide a custom contentRegistry or use on of the supplied ones in /content
  static Widget getPage(String contentKey, ContentRegistry contentRegistry) {
    InputState inputState = InputState(contentRegistry);
    inputState.setRootPage(contentKey);
    return ChangeNotifierProvider<InputState>(
        builder: (context) => inputState, child: _JSONToFlutterPage());
  }

  static registerWidget(String widgetName, WidgetBuilderBase builder) {
    registerExternalWidget(widgetName, builder);
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
        },
        child: b.build(context));
  }
}
