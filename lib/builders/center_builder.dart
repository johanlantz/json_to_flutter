import 'package:flutter/material.dart';

import 'widget_builder_base.dart';
import 'builders.dart';

class CenterBuilder extends WidgetBuilderBase{
  @override
  Widget build(BuildContext context) {
    return Center(
      child: getBuilder(obj['child']).build(context),
    );
  }
}