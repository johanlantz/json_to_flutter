import 'package:flutter/material.dart';
import 'widget_builder_base.dart';
import 'builders.dart';

class ExpandedBuilder with WidgetBuilderBase {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: getBuilder(obj['child']).build(context),
      flex: obj['flex'] != null ? obj['flex'] : 1
    );
  }
}
