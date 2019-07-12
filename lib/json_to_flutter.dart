library json_to_flutter;

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:json_to_flutter/actions/action_handler_registry.dart';
import 'package:json_to_flutter/builders/builders.dart';
import 'package:json_to_flutter/states/input_state.dart';
import 'package:provider/provider.dart';
import 'content/content_handler_registry.dart';

class JSONToFlutter {
  /// Get a new dynamic page using contentKey as root
  ///
  /// [ContentRegistry] can be a fixed registry or unique one for this page.
  /// [ActionHandlerRegistry] is a ChangeNotifier and will be disposed when the widget is unloaded so a new instance must
  /// be provided on each call to this function.
  static Widget getPage(
      String contentKey,
      ContentHandlerRegistry contentRegistry,
      ActionHandlerRegistry actionHandlerRegistry) {
    InputState inputState = InputState(contentRegistry, contentKey);

  // TODO replace number with uuid for key
    return MultiProvider(providers: [
      ChangeNotifierProvider<InputState>(key: Key(Random().nextInt(1000).toString()), builder: (context) => inputState),
      ChangeNotifierProvider<ActionHandlerRegistry>(
          builder: (context) => actionHandlerRegistry)
    ], child: _JSONToFlutterPage(key: Key(Random().nextInt(1000).toString())));
  }

  /// Register an external widget
  ///
  /// If you have a custom widget you can register its builder here in order to reference it from your json file
  /// just like any of the standard Flutter Widgets.
  static registerWidget(String widgetName, WidgetBuilderBase builder) {
    registerExternalWidget(widgetName, builder);
  }
}

class _JSONToFlutterPage extends StatefulWidget {
  _JSONToFlutterPage({Key key})
      : super(key: key); // Check later if this is really needed for the redraw

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
    var actionHandlerRegistry = Provider.of<ActionHandlerRegistry>(context);

    return FutureBuilder<Map<String, dynamic>>(
        future: inputState.getCurrentPage(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Container(child: Text("Loading"));
          }
          var currentPage = snapshot.data;
          WidgetBuilderBase b = getBuilder(currentPage);
          return WillPopScope(
              onWillPop: () async {
                bool didPop = await actionHandlerRegistry.performAction({
                  'type': 'navigate',
                  'data': {'pop': true}
                }, context);
                return !didPop;
              },
              child: b.build(context));
        });
  }
}
