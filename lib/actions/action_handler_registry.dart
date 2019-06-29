import 'package:flutter/material.dart';

import 'action_handler.dart';

class ActionHandlerRegistry with ChangeNotifier {
  static List<ActionHandler> actionHandlerRegistry = [];

  registerActionHandler(ActionHandler handler) {
    actionHandlerRegistry.add(handler);
  }

  Future<bool> performAction(Map<String, dynamic> action, BuildContext context) async {
    bool anyHandlerProcessedAction = false;
    for(ActionHandler actionHandler in actionHandlerRegistry) {
      anyHandlerProcessedAction |= await actionHandler.handleAction(action['type'], action['data'], context);
    }
    return anyHandlerProcessedAction;
  }
}