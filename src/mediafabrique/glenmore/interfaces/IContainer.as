/**
 * Copyright (C) Piotr Kucharski
 * email: suspendmode@gmail.com
 *
 * All rights reserved. Any use, copying, modification, distribution and selling
 * of this software and it's documentation for any purposes without authors' written
 * permission is hereby prohibited.
 */
package mediafabrique.glenmore.interfaces {
  import flash.utils.Dictionary;
  
  /**
   *
   * @author piku
   *
   */
  public interface IContainer extends IComponent, IComponentList {    
    
    /**
     *
     * @return
     *
     */
    function toArray() : Array;

	/**
	 * 
	 * @param type
	 * @return 
	 * 
	 */
	function getByType(type:Class):Object;
    
	/**
	 * 
	 * @param path
	 * @return 
	 * 
	 */
	function find(id:String):*;
}
}