import 'package:flutter/material.dart';
import '../states/input_state.dart';
import 'package:provider/provider.dart';
import 'builders.dart';

class RadioBuilder extends WidgetBuilderBase {

  Widget build(BuildContext context) {
    var inputState = Provider.of<InputState>(context);
    return Radio(
      activeColor: obj['activeColor'] != null ? Color(obj['activeColor']) : Theme.of(context).toggleableActiveColor,
      value: obj['value'],
      groupValue: inputState.getStateForKey(obj['groupValue']),
      onChanged: (newValue) {
        inputState.setStateForKey(obj['groupValue'], newValue);
      }
    );
  }
}