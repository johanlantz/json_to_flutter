import 'content_handler.dart';

class ContentHandlerMem extends ContentHandler {

  Map<String, Map<String, dynamic>> _contentRegistry = {};

  @override
    Future<Map<String, dynamic>> getContent(String key) async {
    return _contentRegistry[key];
  }

  @override
  registerContent(String key, value) {
    _contentRegistry[key] = value;
  }
}