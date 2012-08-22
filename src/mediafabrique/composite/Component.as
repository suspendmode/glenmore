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
  import flash.events.IEventDispatcher;
  
  import mediafabrique.glenmore.interfaces.IComponent;
  import mediafabrique.glenmore.interfaces.IContainer;
  import mediafabrique.lifecycle.LifecycleEvent;
  import mediafabrique.lifecycle.LifecycleObject;
  import mediafabrique.util.GUIDUtil;
  
  import org.as3commons.logging.api.ILogger;
  import org.as3commons.logging.api.getLogger;
  
  [Exclude(kind="method", name="addEventListener")]
  [Exclude(kind="method", name="removeEventListener")]
  [Exclude(kind="method", name="hasEventListener")]
  [Exclude(kind="method", name="addEventCallback")]
  [Exclude(kind="method", name="removeEventCallback")]
  [Exclude(kind="method", name="dispatchEvent")]
  [Exclude(kind="method", name="willTrigger")]
    
  /**
   *
   * @author piku
   *
   */
  public class Component extends LifecycleObject implements IComponent {
    
	  /**
	   * 
	   */
	  private static const logger:ILogger=getLogger(Component);
	  
    
    /**
     *
     * @param id
     * @param eventDispatcher
     *
     */
    public function Component(componentId : String = null,
      eventDispatcher : IEventDispatcher = null) {
      super(eventDispatcher);
      
      if (componentId) {
        this.componentId = componentId;
      }
    }
    
    /**
     *
     */
    private var _componentId : String;
    
    /**
     * @private
     */
    public function set componentId(value : String) : void {
      if (_componentId != value) {
        _componentId = value;
        dispatchEvent(new Event("idChange"));
      }
    }
    
    /**
     *
     */
    public function get componentId() : String {
      if (!_componentId) {
        _componentId = GUIDUtil.create();
      }
      return _componentId;
    }
    
    /**
     *
     */
    private var _parent : IContainer;
    
    /**
     *
     * @param value
     *
     */
    public function set parent(value : IContainer) : void {
      if (_parent != value) {
		  parentChange(_parent, value);
        _parent = value;
        dispatchEvent(new Event("parentChange"));
      }
    }
    
    /**
     *
     * @return
     *
     */
    public function get parent() : IContainer {
      return _parent;
    }
 
	protected function parentChange(oldParent: IComponent, newParent: IComponent): void {
		if (oldParent) {
			oldParent.removeEventListener(LifecycleEvent.INITIALIZED, onParentInitialized);
			oldParent.removeEventListener(LifecycleEvent.DISPOSED, onParentDisposed);
			addEventListener(LifecycleEvent.DISPOSED, onDisposedOnParentChange);
			dispose();
		}
		if (newParent) {
			newParent.addEventListener(LifecycleEvent.INITIALIZED, onParentInitialized);
			newParent.addEventListener(LifecycleEvent.DISPOSED, onParentDisposed);
			if (newParent.isInitialized) {
				initialize();
			}			
		}		
	}
	
	private function onDisposedOnParentChange(event: LifecycleEvent): void {
		removeEventListener(LifecycleEvent.DISPOSED, onDisposedOnParentChange);
		if (parent && parent.isInitialized) {
			initialize();
		}
	}
	
	private function onParentInitialized(event: LifecycleEvent): void {		
		initialize();
	}
	
	private function onParentDisposed(event: LifecycleEvent): void {
		dispose();	
	}
	
	/**
	 * 
	 * @param event
	 * @return 
	 * 
	 */
	override public function dispatchEvent(event:Event):Boolean {
		if (event is Notification && Notification(event).isNotifiedTarget(this)) {
			return false;
		}
		if (event is Notification && !Notification(event).source)
		{
			Notification(event).source=this;
		}
		if (event.isDefaultPrevented()) {
			return false;
		}
		if (event is Notification) {
			Notification(event).addNotifiedTarget(this);
		}
		var dispatched: Boolean = super.dispatchEvent(event);
		if (dispatched) {
			logger.info("dispatchEvent {0}", [ event]);			
		}
		
		
		if (event is Notification && !event.isDefaultPrevented())
		{
			var bubbled:Boolean=bubbleEvent(event as Notification);
			return dispatched || bubbled;
		}
		
		
		return dispatched;
	}
	
	private function bubbleEvent(notification:Notification):Boolean
	{
		if (!notification || !notification.bubbles || !parent || !notification.source || parent == notification.source || notification.isDefaultPrevented())
		{
			return false;
		}
		var bubbled:Boolean=false;
		bubbled=parent.dispatchEvent(notification);
		if (bubbled) {
			logger.info("bubbleEvent {0}", [notification]);
		}
		return bubbled;
	}

	
	public function notify(notification: Notification): void {
		dispatchEvent(notification);
	}
	
	public function observe(notificationType: String, observeFunction: Function): void {
		addEventListener(notificationType, observeFunction, false, 0, false);
	}
	
	public function unobserve(notificationType: String, observeFunction: Function): void {
		removeEventListener(notificationType, observeFunction, false);
	}
	
    /**
     *
     * @return
     *
     */
    public function toString() : String {
      var string : String = "[Component";
      
      if (_componentId) {
        string += " id: " + _componentId;
      }
      
      if (_parent) {
        string += " parent: " + Object(_parent).toString();
      }
      
      string += "]";
      return string;
    }
  }
}