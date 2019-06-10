
abstract class ObjectBuilderBase {

 Map<String, dynamic> obj;


 assignInnerObject(Map<String, dynamic> obj) {
   this.obj = obj;
 }


 Object build();
}