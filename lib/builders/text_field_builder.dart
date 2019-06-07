import 'package:flutter/material.dart';
import '../states/input_state.dart';
import 'package:provider/provider.dart';

import 'widget_builder_base.dart';

class TextFieldBuilder extends WidgetBuilderBase {
  @override
  Widget build(BuildContext context) {
    var inputState = Provider.of<InputState>(context);
    return TextField(
      onSubmitted: (text) {
        inputState.update(obj['key'], {'data': text});
      },
    );
  }

}