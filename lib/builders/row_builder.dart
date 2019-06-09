import 'package:flutter/material.dart';
import 'widget_builder_base.dart';
import 'builders.dart';

class RowBuilder with WidgetBuilderBase {
  @override
  Widget build(BuildContext context) {
    return Row(
        mainAxisAlignment: obj['mainAxisAlignment'] != null ? MainAxisAlignment.values[MainAxisAlignment.values.firstWhere((value) => value.toString() == obj['mainAxisAlignment']).index] : MainAxisAlignment.start,
        children: obj['children'].map<Widget>((child) {
      return getBuilder(child).build(context);
    }).toList());
  }
}
