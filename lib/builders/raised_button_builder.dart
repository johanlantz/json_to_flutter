import 'package:flutter/material.dart';
import 'package:json_to_flutter/actions/action_handler_registry.dart';
import 'builders.dart';
import 'package:provider/provider.dart';

class RaisedButtonBuilder with WidgetBuilderBase {

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      onPressed: () {
        
        var actions = obj['onPressed']['actions'] != null ? obj['onPressed']['actions'] : [];
         var actionHandlerRegistry = Provider.of<ActionHandlerRegistry>(context);
        actions.forEach((action) {
          actionHandlerRegistry.performAction(action, context);
        });
      },
      child: getBuilder(obj['child']).build(context),
    );
  }

}