import 'package:flutter/material.dart';
import 'widget_builder_base.dart';

class TextBuilder extends WidgetBuilderBase {
  @override
  Widget build(BuildContext context) {
    
    return Text(obj['data'],
      textAlign: obj['textAlign'] != null ? TextAlign.values[TextAlign.values.firstWhere((value) => value.toString() == obj['textAlign']).index] : TextAlign.right,
    );
  }
}