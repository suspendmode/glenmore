/**
 * Copyright (C) Piotr Kucharski
 * email: suspendmode@gmail.com
 *
 * All rights reserved. Any use, copying, modification, distribution and selling
 * of this software and it's documentation for any purposes without authors' written
 * permission is hereby prohibited.
 */
package mediafabrique.util {
  import org.as3commons.logging.api.ILogger;
  import org.as3commons.logging.api.getLogger;

  /**
   *
   * @author Peter
   *
   */
  public final class AutowireUtil {
    
	  /**
	   * 
	   */
	  private static const logger:ILogger=getLogger(AutowireUtil);
    
    /**
     *
     * @return
     *
     */
   /* private static function get application() : Application {
      return Application(Application.application);
    }*/
    
    /**
     *
     * @param autowiredObject
     *
     */
    public static function unwire(autowiredObject : Object) : void {
      /*var typeInfo : DescribeTypeCacheRecord = DescribeTypeCache.describeType(autowiredObject);
      var metadatas : XMLList = typeInfo.typeDescription..metadata;
      
      for each (var metaDataNode : XML in metadatas) {
        if (metaDataNode.attribute("name") == "Autowired") {
          var propertyNode : XML = metaDataNode.parent();
          var property : String = propertyNode.@name.toString();
          var objectName : String = property;
          autowiredObject[property] = null;
        }
      }*/
    }
    
    /**
     *
     * @param autowiredObject
     *
     */
    public static function autowire(autowiredObject : Object) : void {
    /* var typeInfo : DescribeTypeCacheRecord = DescribeTypeCache.describeType(autowiredObject);
     var metadatas : XMLList = typeInfo.typeDescription..metadata;
    
     for each (var metaDataNode : XML in metadatas) {
       if (metaDataNode.attribute("name") == "Autowired") {
         var propertyNode : XML = metaDataNode.parent();
         var property : String = propertyNode.@name.toString();
         var objectName : String = property;
         var autowireByType : Boolean = false;
    
         for each (var arg : XML in metaDataNode.arg) {
           if (arg.attribute("value") == "byName") {
             autowireByType = false;
           }
         }
    
         if (autowireByType) {
           throw "not implemented";
           var clazz : Class = ClassUtils.forName(propertyNode.@type.toString());
           var objectNames : Array = applicationContext.getObjectNamesForType(clazz);
    
           if (objectNames.length == 1) {
             objectName = objectNames[0];
           }
         }
    
         var flexApplication : IFlexApplication = IFlexApplication(Application.
           application);
         var context : IContext = flexApplication.context;
         var object : Object = context.getDefinition(objectName);
    
         if (object) {
           autowiredObject[property] = object;
    
           if (autowiredObject is UIComponent) {
             UIComponent(autowiredObject).executeBindings(true);
           }
         } else {
           throw "definition " + objectName + " not found";
         }
     }
       }*/
    }
  
  }
}