import 'dart:async';

import 'content_handler.dart';

/// Keeps track of any kind of content handler implementing [ContentHandler]
/// 
/// Handlers are searched in the order they are added so ensure that
/// handlers not requiring network access are registered before handlers
/// that will add a delay.
class ContentHandlerRegistry {
  static List<ContentHandler> contentHandlerRegistry = [];
  
  /// This controller provides updates about which is the current content served.
  /// This is not needed for an app since everything is managed internally inside json_to_flutter
  /// However, an editor or other tool that needs to show information related to the currently 
  /// served content can subscribe to this controller to know when changes occur.
  static final currentContentStreamController = StreamController<Map<String, Map<String, dynamic>>>.broadcast();

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

    /// 2.5 Not used by the apps, only by a higher or same level component such as an editor
    currentContentStreamController.add({key: content});

    /// 3. Return content or if still null, default error message
    return content != null
        ? content
        : {
            "Text": {"data": "$key Not found"}
          };
  }
}
