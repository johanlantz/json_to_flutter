import 'package:flutter/material.dart';
import 'builders.dart';
import '../states/input_state.dart';
import 'package:provider/provider.dart';

class RaisedButtonBuilder extends WidgetBuilderBase {

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      onPressed: () {
        var inputState = Provider.of<InputState>(context);
        var actions = obj['onPressed']['actions'] != null ? obj['onPressed']['actions'] : [];
        actions.forEach((action) {
          inputState.performAction(action);  
        });
      },
      child: getBuilder(obj['child']).build(context),
    );
  }

}