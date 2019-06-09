
export 'widget_builder_base.dart';
export 'scaffold_builder.dart';
export 'app_bar_builder.dart';
export 'text_builder.dart';
export 'center_builder.dart';
export 'icon_builder.dart';
export 'text_field_builder.dart';
export 'raised_button_builder.dart';
export 'checkbox_builder.dart';
export 'radio_builder.dart';

import 'package:flutter/material.dart';
import 'widget_builder_base.dart';
import 'scaffold_builder.dart';
import 'app_bar_builder.dart';
import 'text_builder.dart';
import 'center_builder.dart';
import 'column_builder.dart';
import 'row_builder.dart';
import 'floating_action_button_builder.dart';
import 'icon_builder.dart';
import 'text_field_builder.dart';
import 'raised_button_builder.dart';
import 'checkbox_builder.dart';
import 'radio_builder.dart';
import 'expanded_builder.dart';
import 'container_builder.dart';
import 'align_builder.dart';


class DummyBuilder with WidgetBuilderBase{
  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
final Map<String, WidgetBuilderBase> _builderMap = {
    'Scaffold': ScaffoldBuilder(),
    'AppBar': AppBarBuilder(),
    'Text': TextBuilder(), 
    'Center': CenterBuilder(),
    'Column': ColumnBuilder(),
    'Row': RowBuilder(),
    'FloatingActionButton': FloatingActionButtonBuilder(),
    'Icon': IconBuilder(),
    'TextField': TextFieldBuilder(),
    'RaisedButton': RaisedButtonBuilder(),
    'Checkbox': CheckboxBuilder(),
    'Radio': RadioBuilder(),
    'Expanded': ExpandedBuilder(),
    'Container': ContainerBuilder(),
    'Align': AlignBuilder()
  };

 
WidgetBuilderBase getBuilder(Map<String, dynamic> obj) {
  var widgetBuilder = _builderMap[obj.keys.first];
  assert(widgetBuilder != null, '-->${obj.keys.first}<-- is not a widget we recognize. Did you remember to register it.');
  Map innerObject = obj[obj.keys.first];
  if (innerObject.keys.length > 0) {
    widgetBuilder.assignInnerObject(innerObject);
  }
  return widgetBuilder;
}

/// Register widgets from the outside 
void registerExternalWidget(String widgetName, WidgetBuilderBase builder) {
  _builderMap[widgetName] = builder;
}