import 'package:flutter_web/material.dart';
import '../states/input_state.dart';
import 'package:provider/provider.dart';

import 'widget_builder_base.dart';

class TextFieldBuilder with WidgetBuilderBase {
  @override
  Widget build(BuildContext context) {
    var inputState = Provider.of<InputState>(context);
    return TextField(
      key: Key(obj['key']),
      onSubmitted: (text) {
        inputState.update(obj['key'], {'data': text});
      },
    );
  }

}