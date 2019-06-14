import 'package:flutter_web/material.dart';

import '../json_to_flutter.dart';

class InputState with ChangeNotifier {
  Map<String, dynamic> inputState = {};
  Map<String, Function> funcMap = {};

  List<String> navigationStack = [];

  InputState() {
    funcMap['submit'] = submit;
    funcMap['navigate'] = navigate;
  }
  
  dispose() {
    super.dispose();
    print('Disposing');
  }
  
  /// State handling
  
  dynamic getStateForKey(String key) {
    if (inputState[key] == null) {
      inputState[key] = false;
    }
    return inputState[key];
  }

  setStateForKey(String key, dynamic value) {
    inputState[key] = value;
    notifyListeners();
  }

  update(String key, dynamic value) {
    inputState[key] = value;
  }

  /// Action handling

  performAction(Map<String, dynamic> action, BuildContext context) {
    funcMap[action['type']](action['data'], context); 
  }

  navigate(Map<String, dynamic> data, BuildContext context) {
    if (data['setAsRoot'] == true) {
      navigationStack = [];
    }

    if(data['eject'] == true) {
      Navigator.pushNamed(context, data['destination']);
    } else {
      navigationStack.add(data['destination']);
    }
    notifyListeners();
  }

  canPop() {
    return navigationStack.length > 1;
  }

  pop() {
    if (navigationStack.length > 0) {
      navigationStack.removeLast();
      if (navigationStack.length > 0) {
        notifyListeners();
        return true;
      }
    } 
    return false;
  }

  Map<String, dynamic> getCurrentPage()  {
    return JSONToFlutter.getContent(navigationStack.last);
  }

  setRootPage(String contentKey)  {
    navigationStack = [contentKey];
  }

  submit(Map<String, dynamic> data) {
    inputState.keys.forEach((key) {
      print('Uploading ${inputState.toString()}');
    });
  }

  
}
