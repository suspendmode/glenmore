/**
 * Copyright (C) Piotr Kucharski
 * email: suspendmode@gmail.com
 *
 * All rights reserved. Any use, copying, modification, distribution and selling
 * of this software and it's documentation for any purposes without authors' written
 * permission is hereby prohibited.
 */
package mediafabrique.composite
{
	import flash.errors.IllegalOperationError;
	import flash.events.Event;
	import flash.events.IEventDispatcher;
	import flash.utils.Dictionary;
	
	import mediafabrique.glenmore.interfaces.IComponent;
	import mediafabrique.glenmore.interfaces.IContainer;
	
	import org.as3commons.logging.api.ILogger;
	import org.as3commons.logging.api.getLogger;

	/**
	 *
	 */
	[Event(name="componentRemoved", type="mediafabrique.composite.ContainerEvent")]

	/**
	 *
	 */
	[Event(name="componentAdded", type="mediafabrique.composite.ContainerEvent")]

	/**
	 *
	 * @author piku
	 *
	 */
	public class Container extends Component implements IContainer
	{

		/**
		 *
		 */
		private static const logger:ILogger=getLogger(Container);

		/**
		 *
		 * @param id
		 * @param eventDispatcher
		 *
		 */
		public function Container(containerId:String=null, eventDispatcher:IEventDispatcher=null)
		{
			super(containerId, eventDispatcher);

		}

		/**
		 *
		 */
		private var children:Dictionary=new Dictionary();
		
		/**
		 * 
		 */
		private var indices:Dictionary=new Dictionary();

		/**
		 *
		 * @return
		 *
		 */
		public function toArray():Array
		{
			var list:Array=[];

			for each (var component:Object in children)
			{
				list.push(component);
			}
			return list;
		}
				
				
		/**
		 * 
		 * @param path
		 * @return 
		 * 
		 */
		public function find(id:String):*
		{			
			if (id == componentId) {
				return this;
			}
			
			var children: Array = toArray();
			
			while (children.length)
			{
				var child: Object = children.shift();
				var componentId: String = getId(child);
					
				if (componentId == id) {
					return child;
				}
				
				if (child is IContainer) {
					var found: Object = IContainer(child).find(id);
					if (found) {
						return found;
					}
				}
			}
			return null;
		}
		
		/**
		 *
		 * adds component with given name
		 *
		 * @param component Object instance of business component to register
		 * @param name String name of business component
		 *
		 */
		public function add(component:Object, id:String):void
		{
			if (!component)
			{
				throw new IllegalOperationError("no component");
			}

			if (!id)
			{
				throw new IllegalOperationError("no id");
			}
			//
			children[id]=component;
			indices[component]=id;

			if (component is IComponent)
			{
				if (IComponent(component).componentId != id)
				{
					IComponent(component).componentId=id;
				}
				IComponent(component).parent=this;
			}
			//
			logger.info("component {0} added at id: {1}", [ component, id]);
			dispatchEvent(new ContainerEvent(ContainerEvent.COMPONENT_ADDED, component, id));
		}

		/**
		 *
		 * @param component
		 *
		 */
		public function remove(component:Object):void
		{
			if (!component)
			{
				throw new IllegalOperationError("no component");
			}
			if (component.parent != this)
			{
				throw new IllegalOperationError("component parent is different");
			}
			var id:String=getId(component);
			removeById(id);
		}

		public function removeById(id:String):Object
		{
			if (!id)
			{
				throw new IllegalOperationError("no id");
			}
			var component:Object=children[id];
			delete children[id];
			delete indices[component];
			dispatchEvent(new ContainerEvent(ContainerEvent.COMPONENT_REMOVED, component, id));
			logger.info("component {0} removed at id: {1}", [ component, id]);
			return component;
		}

		/**
		 *
		 * @param type
		 * @return
		 *
		 */
		public function getByType(type:Class):Object
		{
			for each (var component:Object in children)
			{
				if (component is type)
				{
					return component;
				}
			}
			throw new IllegalOperationError("component with type " + type + " not found");
		}

		/**
		 * Returns component by name
		 *
		 * @param name String name of business component
		 * @return Object instance of business component
		 *
		 */
		public function getById(id:String):Object
		{
			if (id in children)
			{
				return children[id];
			}
			throw new IllegalOperationError("component with " + componentId + " not found");
		}

		/**
		 * 
		 * @param component
		 * @return 
		 * 
		 */
		public function getId(component:Object):String
		{
			if (!component)
			{
				throw new IllegalOperationError("no component");
			}
			if (component in indices)
			{
				return indices[component];
			}
			throw new IllegalOperationError("component not found");
		}

		// EventBubbling

		override public function dispatchEvent(event:Event):Boolean
		{
			var dispatched:Boolean=super.dispatchEvent(event);
			if (event is Notification && !event.isDefaultPrevented())
			{
				var propagated:Boolean=propagateEvent(event as Notification);			
				return dispatched || propagated;
			}
			return dispatched;

		}
		
		private function propagateEvent(notification:Notification):Boolean
		{
			if (!notification || !notification.propagate || !notification.source)
			{
				return false;
			}
			var propagated:Boolean=false;
			for each (var component:Object in children)
			{
				if (component != notification.source && !notification.isDefaultPrevented() && component is IEventDispatcher)
				{

					var dispatched:Boolean=IEventDispatcher(component).dispatchEvent(notification);
					if (dispatched)
					{
						logger.info("propagateEvent {0}", [ notification]);
						propagated=true;
					}
				}
			}
			return propagated;
		}


		/**
		 *
		 * @return
		 *
		 */
		override public function toString():String
		{
			var string:String=super.toString();
			var containerString:String="Container"
			string=string.replace("Component", containerString);
			return string;
		}
	}
}
