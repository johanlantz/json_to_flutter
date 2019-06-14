import 'package:flutter_web/material.dart';
import 'builders.dart';

class ScaffoldBuilder with WidgetBuilderBase {

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getBuilder(obj['appBar']).build(context),
      body: getBuilder(obj['body']).build(context),
      floatingActionButton: getBuilder(obj['floatingActionButton']).build(context),
    );
  }
}