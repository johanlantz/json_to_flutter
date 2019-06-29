import 'package:flutter/material.dart';
import 'package:json_to_flutter/actions/action_handler.dart';
import 'package:json_to_flutter/states/input_state.dart';
import 'package:provider/provider.dart';

class ActionHandlerNav extends ActionHandler {
  static const String ACTION_NAV = "navigate";
  List<String> navigationStack = [];

  @override
  Future<bool> handleAction(
      String actionName, dynamic data, BuildContext context) async {
    if (actionName == ACTION_NAV) {
      return _navigate(data, context);
    } else {
      return false;
    }
  }

  bool _navigate(Map<String, dynamic> data, BuildContext context) {
    bool didNavigate = true;

    if (data['pop'] == true) {
      didNavigate = _pop();
    } else {
      if (data['setAsRoot'] == true) {
        navigationStack = [];
      }

      if (data['eject'] == true) {
        Navigator.pushNamed(context, data['destination']);
      } else {
        navigationStack.add(data['destination']);
      }
    }

    if (didNavigate) {
      var inputState = Provider.of<InputState>(context);
      inputState.setCurrentContentKey(navigationStack.last);
    }

    return didNavigate;
  }

  _pop() {
    if (navigationStack.length > 0) {
      navigationStack.removeLast();

      if (navigationStack.length > 0) {
        return true;
      }
    }
    return false;
  }
}
