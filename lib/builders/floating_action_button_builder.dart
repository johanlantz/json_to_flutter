import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'widget_builder_base.dart';
import 'builders.dart';
import '../states/input_state.dart';


class FloatingActionButtonBuilder with WidgetBuilderBase {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      child: getBuilder(obj['child']).build(context),
      onPressed: () {
        var inputState = Provider.of<InputState>(context);
        var actions = obj['onPressed']['actions'] != null ? obj['onPressed']['actions'] : [];
        actions.forEach((action) {
          inputState.performAction(action, context);

        });
      },
      tooltip: obj['tooltip'],
    );
  }
}
