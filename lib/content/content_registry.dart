abstract class ContentRegistry {
  registerContent(String key, dynamic value);
  Map<String, dynamic> getContent(String key);
}