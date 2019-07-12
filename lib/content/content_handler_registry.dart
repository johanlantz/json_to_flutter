import 'dart:async';

import 'package:flutter/foundation.dart';

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
  /// This broadcast will contain the contentKey and then the complete content as value
  static final currentContentStreamController =
      StreamController<Map<String, Map<String, dynamic>>>.broadcast();

  /// For editors to be notified about changes in any of the content indexes
  /// The key value is the name of the content handler, can be used for grouping in the editor if desired
  static final indexUpdateStreamController =
      StreamController<Map<String, List<String>>>.broadcast();

  registerContentHandler(ContentHandler handler) async {
    contentHandlerRegistry.add(handler);
    _notifyIndexUpdated();
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

  static Future<bool> updateContent(String key, dynamic value) async {
    ContentHandler contentHandler;
    for (contentHandler in contentHandlerRegistry) {
      if (await contentHandler.getContent(key) != null) {
        break;
      }
    }
    return contentHandler.updateContent(key, value);
  }

  Future<Map<String, List<String>>> _getAllIndexes() async {
    var indexMap = Map<String, List<String>>();
    var registryClone = [];
    registryClone.addAll(contentHandlerRegistry);
    for (ContentHandler contentHandler in registryClone) {
      indexMap[contentHandler.runtimeType.toString()] =
          await contentHandler.getIndex();
    }
    return indexMap;
  }

  _notifyIndexUpdated() async {
    indexUpdateStreamController.add(await _getAllIndexes());
  }
}
