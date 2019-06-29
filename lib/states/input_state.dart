import 'package:flutter/material.dart';
import 'package:json_to_flutter/content/content_handler_registry.dart';

class InputState with ChangeNotifier {
  Map<String, dynamic> inputState = {};

  ContentHandlerRegistry _contentHandlerRegistry;
  String currentContentKey;

  InputState(ContentHandlerRegistry contentRegistry, String rootContentKey) {
    _contentHandlerRegistry = contentRegistry;
    currentContentKey = rootContentKey;
  }
  
  dispose() {
    super.dispose();
    print('Disposing InputState');
  }
  
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

  setCurrentContentKey(String key) {
    currentContentKey = key;
    notifyListeners();
  }

  Future<Map<String, dynamic>> getCurrentPage()  async {
    return await _contentHandlerRegistry.getContent(currentContentKey);
  }
}
