import 'content_handler.dart';

/// Keeps track of any kind of content handler implementing [ContentHandler]
/// 
/// Handlers are searched in the order they are added so ensure that
/// handlers not requiring network access are registered before handlers
/// that will add a delay.
class ContentHandlerRegistry {
  static List<ContentHandler> contentHandlerRegistry = [];

  registerContentHandler(ContentHandler handler) {
    contentHandlerRegistry.add(handler);
  }

  Future<Map<String, dynamic>> getContent(String key) async {
    Map<String, dynamic> content;
    /// 1. Check if any of our handlers recognizes this key
    for (ContentHandler contentHandler in contentHandlerRegistry) {
      content = await contentHandler.getContent(key);
      if (content != null) {
        break;
      }
    }

    /// 2. If not found, check if any registry provides a custom error page
    if (content == null) {
      for (ContentHandler contentHandler in contentHandlerRegistry) {
        content = await contentHandler.getContent('not_found');
        if (content != null) {
          break;
        }
      }
    }

    /// 3. Return content or if still null, default error message
    return content != null
        ? content
        : {
            "Text": {"data": "$key Not found"}
          };
  }
}
