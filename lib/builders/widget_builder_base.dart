import 'package:flutter/material.dart';

mixin WidgetBuilderBase {
  Map<String, dynamic> obj;

  assignInnerObject(Map<String, dynamic> obj) {
    this.obj = obj;
  }

  /// JSON (before JSON5) does not support hex numbers so they must be represented as strings
  /// For instance 0x00112233 has to be "0x00112233" but the class or widget expects an int
  dynamic getNumber(dynamic val) {
    return val is String ? int.parse(val) : val;
  }

  Widget build(BuildContext context);
}
