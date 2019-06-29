abstract class ContentHandler {
  registerContent(String key, dynamic value);
  Future<Map<String, dynamic>> getContent(String key);
}