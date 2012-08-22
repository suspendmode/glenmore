/**
 * Copyright (C) Piotr Kucharski
 * email: suspendmode@gmail.com
 *
 * All rights reserved. Any use, copying, modification, distribution and selling
 * of this software and it's documentation for any purposes without authors' written
 * permission is hereby prohibited.
 */
package mediafabrique.composite {
  import flash.events.Event;
  
  import mediafabrique.glenmore.interfaces.IComponent;
  
  /**
   *
   * @author Peter
   *
   */
  public class ContainerEvent extends Event {
    
    /**
     *
     */
    public static const COMPONENT_ADDED : String = "componentAdded";
    
    /**
     *
     */
    public static const COMPONENT_REMOVED : String = "componentRemoved";
    
    /**
     *
     */
    public var component : Object;
    
	/**
	 * 
	 */
	public var id: String;
	
    /**
     *
     * @param type
     * @param object
     * @param name
     *
     */
    public function ContainerEvent(type : String, component : Object, id: String) {
      super(type);
      this.component = component;      
    }
  }
}