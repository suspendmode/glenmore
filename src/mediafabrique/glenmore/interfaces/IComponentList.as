/**
 * Copyright (C) Piotr Kucharski
 * email: suspendmode@gmail.com
 *
 * All rights reserved. Any use, copying, modification, distribution and selling
 * of this software and it's documentation for any purposes without authors' written
 * permission is hereby prohibited.
 */
package mediafabrique.glenmore.interfaces {
  
  /**
   *
   * @author piku
   *
   */
  public interface IComponentList {
    

	  /**
	   * 
	   * @param component
	   * 
	   */
	  function add(component:Object, id: String):void
    
    /**
     *
     * @param object
     *
     */
    function remove(component : Object) : void;
	
	function removeById(id: String): Object;
			
	/**
	 * 
	 * @param componentId
	 * @return 
	 * 
	 */
	function getById(id:String):Object
	
	function getId(component:Object):String
  }
}