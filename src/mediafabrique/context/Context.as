/**
 * Copyright (C) Piotr Kucharski
 * email: suspendmode@gmail.com
 *
 * All rights reserved. Any use, copying, modification, distribution and selling
 * of this software and it's documentation for any purposes without authors' written
 * permission is hereby prohibited.
 */
package mediafabrique.context
{
	import flash.errors.IllegalOperationError;
	import flash.events.Event;
	import flash.events.IEventDispatcher;
	import flash.utils.getQualifiedClassName;
	
	import mediafabrique.composite.Container;
	import mediafabrique.glenmore.interfaces.IComponent;
	import mediafabrique.glenmore.interfaces.IContainer;
	
	import org.as3commons.logging.api.ILogger;
	import org.as3commons.logging.api.getLogger;


	/**
	 *
	 * @author Peter
	 *
	 */
	public class Context extends Container implements IContext
	{

		/**
		 *
		 */
		public static const ROOT_CONTEXT_ID:String="root";
		
		/**
		 *
		 */
		private static const logger:ILogger=getLogger(Context);

		/**
		 *
		 * @param descriptor
		 * @param id
		 * @param eventDispatcher
		 * @return
		 *
		 */
		public function Context(contextId:String=null, descriptor:Object=null, eventDispatcher:IEventDispatcher=null)
		{				
			super(contextId, eventDispatcher);
			this.descriptor=descriptor;
			if (!(this is RootContext)) {
				root.add(this, componentId);
			}
		}

		public function getByPath(path: String): Object {
			var chain:Array = path.split(".");
			var element:IContainer;
			var i:uint = 0;
			
			if (chain[0] == "this" || chain[0] == componentId)
			{
				element = this;
				i++;
			}
			if (chain[0] == ROOT_CONTEXT_ID)
			{
				element = root;
				i++;
			}
			
			while (i < (chain.length - 1))
			{
				element = element[chain[i++]];
			}
			
			return element.getById(chain[i]);
		}
				
		// IContext impl

		/**
		 *
		 */
		private var _descriptor:Object;

		/**
		 *
		 * @return
		 *
		 */
		public function get descriptor():Object
		{
			return _descriptor;
		}

		/**
		 *
		 * @param value
		 *
		 */
		public function set descriptor(value:Object):void
		{
			if (_descriptor != value)
			{
				_descriptor=value;
				dispatchEvent(new Event("descriptorChange"));
			}
		}


		////////////////////////////////////////////////////////////////////////

		/**
		 *
		 */
		private static var _root: IContext

		/**
		 *
		 * @return
		 *
		 */
		public static function get root():IContext
		{
			if (!_root) {
				_root = new RootContext(ROOT_CONTEXT_ID);
			}
			return _root;
		}
		
		override public function find(id:String):*
		{
			var found: Object = super.find(id);
			if (found) {
				return found;
			} else {
				throw new IllegalOperationError("child with id " + id + " not found");
			}
		}

		/**
		 *
		 * @return
		 *
		 */
		override public function toString():String
		{
			var string:String=super.toString();
			var replacementString:String=getQualifiedClassName(this);
			string=string.replace("Container", replacementString);
			return string;
		}

		/**
		 *
		 * @param descriptor
		 * @return
		 *
		 */
		public function getContextByDescriptor(descriptor:Object):IContext
		{
			var list:Array=toArray();

			for each (var component:Object in list)
			{
				if (component is IContext && IContext(component).descriptor == descriptor)
				{
					return IContext(component);
				}
			}
			return null;
		}
	}
}
import flash.events.IEventDispatcher;

import mediafabrique.context.Context;

class RootContext extends Context {

	public function RootContext(contextId:String=null, descriptor:Object=null, eventDispatcher:IEventDispatcher=null)
	{
		super(contextId, descriptor, eventDispatcher);
		isInitialized = true;
	}
}