import 'package:flutter/material.dart';
import 'builders.dart';

class IconBuilder with WidgetBuilderBase {

  Widget build(BuildContext context) {
    return Icon(IconData(obj['codePoint'], fontFamily: 'MaterialIcons'));
  }
}