abstract class ContentHandler {
  String name = "unknown";
  Future<List<String>> getIndex();
  registerContent(String key, dynamic value);
  Future<Map<String, dynamic>> getContent(String key);
  Future<bool> updateContent(String key, dynamic value);
}