export 'edge_inset_builder.dart';

import 'object_builder_base.dart';
import 'edge_inset_builder.dart';


class DummyBuilder extends ObjectBuilderBase{
  @override
  Object build() {
    return Object();
  }
}

final Map<String, ObjectBuilderBase> builderMap = {
   'EdgeInsets': EdgeInsetBuilder()
  };



ObjectBuilderBase getObjectBuilder(Map<String, dynamic> obj) {
  var objectBuilder = obj != null ? builderMap[obj.keys.first] : DummyBuilder();
  assert(objectBuilder != null, '${obj.keys.first} is not something we recognize.');
  if (objectBuilder is DummyBuilder) {
    return objectBuilder;
  }
  Map innerObject = obj[obj.keys.first];
  if (innerObject.keys.length > 0) {
    objectBuilder.assignInnerObject(innerObject);
  }
  return objectBuilder;
}