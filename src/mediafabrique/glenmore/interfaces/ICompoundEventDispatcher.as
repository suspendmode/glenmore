/**
 * Copyright (C) Piotr Kucharski
 * email: suspendmode@gmail.com
 *
 * All rights reserved. Any use, copying, modification, distribution and selling
 * of this software and it's documentation for any purposes without authors' written
 * permission is hereby prohibited.
 */
package mediafabrique.glenmore.interfaces {
  import flash.events.IEventDispatcher;
  
  /**
   *
   * @author piku
   *
   */
  public interface ICompoundEventDispatcher extends IEventDispatcher {
    
    /**
     *
     * @param value
     *
     */
    function set eventDispatcher(value : IEventDispatcher) : void;
    
    /**
     *
     * @return
     *
     */
    function get eventDispatcher() : IEventDispatcher;
  }
}