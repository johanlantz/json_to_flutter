import 'package:flutter/foundation.dart';

import '../json_to_flutter.dart';

class InputState with ChangeNotifier {
  Map<String, dynamic> inputState = {};
  Map<String, Function> funcMap = {};

  List<String> navigationStack = ['firstPage'];

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

  performAction(Map<String, dynamic> action) {
    funcMap[action['type']](action['data']); 
  }

  navigate(Map<String, dynamic> data) {
    if (data['setAsRoot'] == true) {
      navigationStack = [];
    }
    navigationStack.add(data['destination']);
    notifyListeners();
  }

  pop() {
    if (navigationStack.length > 1) {
      navigationStack.removeLast();
      notifyListeners();
    }
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
