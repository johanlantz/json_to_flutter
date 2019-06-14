import 'package:flutter_web/material.dart';

import 'widget_builder_base.dart';
import 'builders.dart';
import 'objects/object_builders.dart';

class ContainerBuilder with WidgetBuilderBase {
  @override
  Widget build(BuildContext context) {
    
    if (obj['width'] != null || obj['height'] != null) {
      return Container(
        margin: obj['margin'] != null ? getObjectBuilder(obj['margin']).build() : EdgeInsets.all(0),
        padding: obj['margin'] != null ? getObjectBuilder(obj['margin']).build() : EdgeInsets.all(0),
        width: obj['width'].toDouble(),
        height: obj['height'].toDouble(),
        child: getBuilder(obj['child']).build(context),
      );
    } else {
      return Container(
        color: obj['color'] != null ? Color(obj['color']) : null,
        margin: obj['margin'] != null ? getObjectBuilder(obj['margin']).build() : EdgeInsets.all(0),
        padding: obj['margin'] != null ? getObjectBuilder(obj['margin']).build() : EdgeInsets.all(0),
        child: getBuilder(obj['child']).build(context));
    }
  }
}
