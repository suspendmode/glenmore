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
  public interface IComponent extends ICompoundEventDispatcher, ILifecycle {
    
    /**
     *
     * @param value
     *
     */
    function set componentId(value : String) : void;
    
    /**
     *
     * @return
     *
     */
    function get componentId() : String;
    
    /**
     *
     * @param value
     *
     */
    function set parent(value : IContainer) : void;
    
    /**
     *
     * @return
     *
     */
    function get parent() : IContainer;
  }
}