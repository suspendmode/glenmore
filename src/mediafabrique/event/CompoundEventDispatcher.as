/**
 * Copyright (C) Piotr Kucharski
 * email: suspendmode@gmail.com
 *
 * All rights reserved. Any use, copying, modification, distribution and selling
 * of this software and it's documentation for any purposes without authors' written
 * permission is hereby prohibited.
 */
package mediafabrique.event {
  import flash.errors.IllegalOperationError;
  import flash.events.Event;
  import flash.events.EventDispatcher;
  import flash.events.IEventDispatcher;
  
  import mediafabrique.glenmore.interfaces.ICompoundEventDispatcher;
  import mediafabrique.lifecycle.EventDispatcherEntry;
  import mediafabrique.util.SearchUtil;
  
  import org.as3commons.logging.api.ILogger;
  import org.as3commons.logging.api.getLogger;
  
  /**
   *
   * @author piku
   *
   */
  public class CompoundEventDispatcher implements ICompoundEventDispatcher {
    
	  /**
	   * 
	   */
	  private static const logger:ILogger=getLogger(CompoundEventDispatcher);
	  
    ///////////////////////////////////////////////////////////////////////////////////
    
    /**
     *
     * @param eventDisplatcher
     *
     */
    public function CompoundEventDispatcher(eventDispatcher : IEventDispatcher = null) {
		if (eventDispatcher) {
      		this.eventDispatcher = eventDispatcher;
		}
    }
    
    ///////////////////////////////////////////////////////////////////////////////////
    
    /**
     *
     */
    private var _eventDispatcher : IEventDispatcher;
    
    /**
     *
     * @param value
     *
     */
    public function set eventDispatcher(value : IEventDispatcher) : void {
      if (_eventDispatcher != value) {
        if (_eventDispatcher) {
          storeEventListeners();
        }
        _eventDispatcher = value;
        
        if (_eventDispatcher) {
          restoreEventListeners();
        }
      }
    }
    
    /**
     *
     * @return
     *
     */
    public function get eventDispatcher() : IEventDispatcher {
		if (!_eventDispatcher) {
			_eventDispatcher = new EventDispatcher();
		}
      return _eventDispatcher;
    }
    
    ////////////////////////////////////////////////////////////////////////////////////
    
    /**
     *
     */
    private var eventListeners : Array = [];
    
    /**
     *
     *
     */
    private function restoreEventListeners() : void {
      for each (var eventListener : EventDispatcherEntry in eventListeners) {
        eventDispatcher.addEventListener(eventListener.type,
          eventListener.listener, eventListener.useCapture,
          eventListener.priority, eventListener.useWeakReference);
      }
    }
    
    /**
     *
     *
     */
    private function storeEventListeners() : void {
      for each (var eventListener : EventDispatcherEntry in eventListeners) {
        eventDispatcher.removeEventListener(eventListener.type,
          eventListener.listener, eventListener.useCapture);
      }
    }
    
    ///////////////////////////////////////////////////////////////////////////////////
    
    // Extended EventDispatcher
    
    /**
     *
     */
    private var eventCallacks : Array = [];
    
    /**
     *
     * @param type
     * @param listener
     * @param scope
     * @param useCapture
     * @param priority
     * @param useWeakReference
     *
     */
    public function addEventCallback(type : String, listener : Function,
      scope : Object = null, useCapture : Boolean = false, priority : int = 0,
      useWeakReference : Boolean = false) : void {
      
      var similar : EventDispatcherEntry = getCallback(type, listener,
        useCapture, scope);
      
      if (similar) {
        //not implemented
        //in future:        
        //remove existing callback
        //addNewCallback
        return;
      }
      
      var listenerFunction : Function = function(event : Event) : void {
        if (listener.length == 0) {
          listener.apply(scope);
        } else if (listener.length == 1) {
          listener.apply(scope, [event]);
        } else {
          listener.apply(scope, [event, scope]);
        }
      }
      addEventListener(type, listener, useCapture, priority, useWeakReference);
    }
    
    /**
     *
     * @param type
     * @param listener
     * @param useCapture
     *
     */
    public function removeEventCallback(type : String, listener : Function,
      useCapture : Boolean = false) : void {
      //not implemented
    }
    
    /**
     *
     * @param type
     * @param listener
     * @param useCapture
     * @return
     *
     */
    private function getCallback(type : String, listener : Function,
      useCapture : Boolean = false, scope : Object = null) : EventDispatcherEntry {
      for each (var callback : EventDispatcherEntry in eventCallacks) {
        if (callback.type == type && callback.listener == listener &&
          callback.useCapture == useCapture && callback.scope == scope) {
          return callback;
        }
      }
      
      return null;
    }
    
    // IEventDispatcher impl
    
    /**
     *
     * @param type
     * @param listener
     * @param useCapture
     * @param priority
     * @param useWeakReference
     * @param scope
     * @return
     *
     */
    private function createEventDispatcherEntry(type : String,
      listener : Function, useCapture : Boolean = false, priority : int = 0,
      useWeakReference : Boolean = false, scope : Object = null) : EventDispatcherEntry {
      var entry : EventDispatcherEntry = new EventDispatcherEntry(type,
        listener, useCapture, priority, useWeakReference, scope);
      return entry;
    }
    
    /**
     *
     * @param type
     * @param listener
     * @param useCapture
     * @param priority
     * @param useWeakReference
     *
     */
    public function addEventListener(type : String, listener : Function,
      useCapture : Boolean = false, priority : int = 0,
      useWeakReference : Boolean = false) : void {
      
      var eventListener : EventDispatcherEntry = new EventDispatcherEntry(type,
        listener, useCapture, priority, useWeakReference);
      
      eventListeners.push(eventListener);
      
      eventDispatcher.addEventListener(type, listener, useCapture, priority,
        useWeakReference);
    }
    
    /**
     *
     * @param type
     * @param listener
     * @param useCapture
     *
     */
    public function removeEventListener(type : String, listener : Function,
      useCapture : Boolean = false) : void {
      removeEventListenerWith(type, listener, useCapture);
      eventDispatcher.removeEventListener(type, listener, useCapture);
    }
    
    /**
     *
     * @param type
     * @param listener
     * @param useCapture
     *
     */
    private function removeEventListenerWith(type : String, listener : Function,
      useCapture : Boolean) : void {
      var index : int = SearchUtil.searchFor(eventListeners,
        {type: type, listener: listener, useCapture: useCapture});
      
      if (index != -1) {
        eventListeners.splice(index, 1);
      } else {
        throw new IllegalOperationError("not found");
      }
    }
    
    /**
     *
     * @param event
     * @return
     *
     */
    public function dispatchEvent(event : Event) : Boolean {
      return eventDispatcher.dispatchEvent(event);
    }
    
    /**
     *
     * @param type
     * @return
     *
     */
    public function hasEventListener(type : String) : Boolean {
      return eventDispatcher.hasEventListener(type);
    }
    
    /**
     *
     * @param type
     * @return
     *
     */
    public function willTrigger(type : String) : Boolean {
      return eventDispatcher.willTrigger(type);
    }
  }
}
