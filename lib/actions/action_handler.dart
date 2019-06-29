import 'package:flutter/material.dart';

abstract class ActionHandler with ChangeNotifier {
  Future<bool> handleAction(String actionName, dynamic data, BuildContext context);
}