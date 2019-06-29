export 'edge_inset_builder.dart';

import 'object_builder_base.dart';
import 'edge_inset_builder.dart';

final Map<String, ObjectBuilderBase> builderMap = {
   'EdgeInsets': EdgeInsetBuilder()
  };

ObjectBuilderBase getObjectBuilder(Map<String, dynamic> obj) {
  var objectBuilder = builderMap[obj.keys.first];
  assert(objectBuilder != null, '${obj.keys.first} is not something we recognize.');
  Map innerObject = obj[obj.keys.first];
  if (innerObject.keys.length > 0) {
    objectBuilder.assignInnerObject(innerObject);
  }
  return objectBuilder;
}