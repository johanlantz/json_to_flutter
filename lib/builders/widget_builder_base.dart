import 'package:flutter/material.dart';

abstract class WidgetBuilderBase {

 Map<String, dynamic> obj;


 assignInnerObject(Map<String, dynamic> obj) {
   this.obj = obj;
 }


 Widget build(BuildContext context);
}