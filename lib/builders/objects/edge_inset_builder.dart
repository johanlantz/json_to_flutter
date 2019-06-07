import 'package:flutter/material.dart';

import 'object_builder_base.dart';

class EdgeInsetBuilder extends ObjectBuilderBase {

  EdgeInsets build() {
    if (obj['all'] != null) {
      return EdgeInsets.all(obj['all'].toDouble());  
    }
    return EdgeInsets.only(left: obj['left'] != null ? obj['left'].toDouble() : 0.0, right: obj['right'] != null ? obj['right'].toDouble() : 0.0, top: obj['top'] != null ? obj['top'].toDouble() : 0.0, bottom: obj['bottom'] != null ? obj['bottom'].toDouble() : 0.0);
  }
  
}
