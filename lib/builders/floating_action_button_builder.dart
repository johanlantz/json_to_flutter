import 'package:flutter/material.dart';
import 'package:json_to_flutter/actions/action_handler_registry.dart';
import 'package:provider/provider.dart';
import 'widget_builder_base.dart';
import 'builders.dart';

class FloatingActionButtonBuilder with WidgetBuilderBase {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      child: getBuilder(obj['child']).build(context),
      onPressed: () {
        var actionHandlerRegistry = Provider.of<ActionHandlerRegistry>(context);
        var actions = obj['onPressed']['actions'] != null ? obj['onPressed']['actions'] : [];
        actions.forEach((action) {
          actionHandlerRegistry.performAction(action, context);

        });
      },
      tooltip: obj['tooltip'],
    );
  }
}
