/**
 * Copyright (C) Piotr Kucharski
 * email: suspendmode@gmail.com
 *
 * All rights reserved. Any use, copying, modification, distribution and selling
 * of this software and it's documentation for any purposes without authors' written
 * permission is hereby prohibited.
 */
package mediafabrique.util {
  import flash.display.DisplayObject;
  import flash.display.Stage;
  import flash.geom.Point;
  
  /**
   *
   * @author piq
   *
   */
  public final class DisplayObjectUtil {
    
    /**
     *
     * @param source
     * @param stage
     *
     */
    public static function centerOnStage(source : DisplayObject, stage : Stage) : void {
      source.x = stage.stageWidth / 2 - source.width / 2;
      source.y = stage.stageHeight / 2 - source.height / 2;
    }
    
    /**
     *
     * @param source
     * @param retaliveObject
     * @param offset
     *
     */
    public static function centerTo(source : DisplayObject,
      retaliveObject : DisplayObject, offset : Point = null) : void {
      if (!offset) {
        offset = new Point(-source.width / 2, -source.height / 2);
      }
      var destinationGlobal : Point = retaliveObject.localToGlobal(new Point(retaliveObject.width / 2,
        retaliveObject.height / 2));
      var destinationLocal : Point = source.parent.globalToLocal(destinationGlobal);
      source.x = destinationLocal.x + offset.x;
      source.y = destinationLocal.y + offset.y;
    }
    
    /**
     *
     * @param object
     * @param context
     * @return
     *
     */
    public static function isInContextOf(object : DisplayObject,
      context : DisplayObject) : Boolean {
      var parent : DisplayObject = object;
      
      while (parent) {
        if (parent == context) {
          return true;
        } else {
          parent = parent.parent;
        }
      }
      return false;
    }
  
  /**
   *
   * @param container
   * @param child
   * @return
   *
   */ /* public static function owns(container : IContainer, child : DisplayObject) : Boolean {
    var childList : IChildList = container is IRawChildrenContainer ? IRawChildrenContainer(container).rawChildren :
    IChildList(container);
  
    if (childList.contains(child)) {
    return true;
    }
  
    try {
    while (child && child != container) {
    // do a parent walk
    if (child is IUIComponent) {
    child = IUIComponent(child).owner;
    } else {
    child = child.parent;
    }
    }
    } catch (e : SecurityError) {
    return false;
    }
  
    return child == container;
  } */
  }
}