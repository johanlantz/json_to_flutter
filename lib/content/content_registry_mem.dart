import 'content_registry.dart';

class ContentRegistryMem extends ContentRegistry {

  Map<String, Map<String, dynamic>> _contentRegistry = {};

  @override
    Map<String, dynamic> getContent(String key) {
    return _contentRegistry[key] ??
        _contentRegistry['not_found'] ??
        {
          "Text": {"data": "$key Not found"}
        };
  }

  @override
  registerContent(String key, value) {
    _contentRegistry[key] = value;
  }
}