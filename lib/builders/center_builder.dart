import 'package:flutter_web/material.dart';

import 'widget_builder_base.dart';
import 'builders.dart';

class CenterBuilder with WidgetBuilderBase{
  @override
  Widget build(BuildContext context) {
    return Center(
      child: getBuilder(obj['child']).build(context),
    );
  }
}