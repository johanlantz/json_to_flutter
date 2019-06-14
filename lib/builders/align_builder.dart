import 'package:flutter_web/material.dart';
import 'widget_builder_base.dart';
import 'builders.dart';

class AlignBuilder with WidgetBuilderBase{
  @override
  Widget build(BuildContext context) {
    assert(obj['alignment'] != null, 'Alignment attribute missing');
    Alignment alignment;
    switch(obj['alignment']) {
      case 'Alignment.bottomCenter':
        alignment = Alignment.bottomCenter;
      break;
      case 'Alignment.bottomLeft':
        alignment = Alignment.bottomLeft;
      break;
      case 'Alignment.bottomRight':
        alignment = Alignment.bottomRight;
      break;
      case 'Alignment.center':
        alignment = Alignment.center;
      break;
      case 'Alignment.centerLeft':
        alignment = Alignment.centerLeft;
      break;
      case 'Alignment.centerRight':
        alignment = Alignment.centerRight;
      break;
      case 'Alignment.topCenter':
        alignment = Alignment.topCenter;
      break;
      case 'Alignment.topLeft':
        alignment = Alignment.topLeft;
      break;
      case 'Alignment.topRight':
        alignment = Alignment.topRight;
      break;
      default:
        assert(false, 'Unrecognized Align value ${obj['alignment']}');
    }
    return Align(
      widthFactor: obj['widthFactor'],
      heightFactor: obj['heightFactor'],
      alignment: obj['alignment'] != null ? alignment : Alignment.center,
      child: getBuilder(obj['child']).build(context),
    );
  }
}