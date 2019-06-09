import 'package:flutter/material.dart';
import '../states/input_state.dart';
import 'package:provider/provider.dart';
import 'widget_builder_base.dart';
import 'builders.dart';

class CheckboxBuilder with WidgetBuilderBase {
  @override
  Widget build(BuildContext context) {
    var inputState = Provider.of<InputState>(context);
    return Checkbox(
      value: inputState.getStateForKey(obj['key']),
      onChanged: (newValue) {
          inputState.setStateForKey(obj['key'], newValue);
      }
    );
  }
}
