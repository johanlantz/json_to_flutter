import 'package:flutter/material.dart';
import 'builders.dart';

class AppBarBuilder with WidgetBuilderBase {

   Widget build(BuildContext context) {

    return AppBar(
      title: getBuilder(obj['title']).build(context),
      backgroundColor: Color(getNumber(obj['backgroundColor']))
    );
  }
}