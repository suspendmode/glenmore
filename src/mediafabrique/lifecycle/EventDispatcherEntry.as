/**
 * Copyright (C) Piotr Kucharski
 * email: suspendmode@gmail.com
 *
 * All rights reserved. Any use, copying, modification, distribution and selling
 * of this software and it's documentation for any purposes without authors' written
 * permission is hereby prohibited.
 */
package mediafabrique.lifecycle {
  
  /**
   *
   * @author Peter
   *
   */
  public class EventDispatcherEntry {
    
    /**
     *
     */
    public var type : String;
    
    /**
     *
     */
    public var listener : Function;
    
    /**
     *
     */
    public var useCapture : Boolean = false;
    
    /**
     *
     */
    public var priority : int = 0;
    
    /**
     *
     */
    public var useWeakReference : Boolean = false;
    
    /**
     *
     */
    public var scope : Object;
    
    /**
     *
     */
    public var stack : String;
    
    /**
     *
     * @param type
     * @param listener
     * @param useCapture
     * @param priority
     * @param useWeakReference
     * @param scope
     *
     */
    public function EventDispatcherEntry(type : String, listener : Function,
      useCapture : Boolean = false, priority : int = 0,
      useWeakReference : Boolean = false, scope : Object = null) {
      this.type = type;
      this.listener = listener;
      this.useCapture = useCapture;
      this.priority = priority;
      this.useWeakReference = useWeakReference;
      this.scope = scope;
      this.stack = new Error().getStackTrace();
    }
  }
}