/**
 * 
 */
package mediafabrique.lifecycle
{
	import flash.events.Event;
	import flash.events.IEventDispatcher;
	import flash.utils.setTimeout;
	
	import mediafabrique.event.CompoundEventDispatcher;
	
	import org.as3commons.logging.api.ILogger;
	import org.as3commons.logging.api.getLogger;

	/**
	 * 
	 * @author Peter
	 * 
	 */
	public class LazyObject extends CompoundEventDispatcher
	{
		/**
		 * 
		 */
		private static const logger:ILogger=getLogger(LazyObject);
		
		/**
		 * 
		 * @param target
		 * 
		 */
		public function LazyObject(target:IEventDispatcher=null)
		{
			super(target);
		}

		/**
		 * 
		 */
		private var callLaters:Array=[];

		/**
		 * 
		 * @param event
		 * @param eventDispatcher
		 * 
		 */
		public function dispatchLater(event:Event, eventDispatcher:IEventDispatcher=null):void
		{
			if (!eventDispatcher)
			{
				eventDispatcher=this;
			}
			callLater(eventDispatcher.dispatchEvent, [event], eventDispatcher);
		}

		/**
		 * 
		 * @param reference
		 * @param args
		 * @param scope
		 * @return 
		 * 
		 */
		public function callLater(reference:Function, args:Array=null, scope:Object=null):void
		{
			var info:CallLater=new CallLater();
			info.reference=reference;
			info.args=args;
			info.scope=scope;			
			callLaters.push(info);
			invalidateCallLater();			
		}

		/**
		 * 
		 * 
		 */
		public function invalidateProperties():void
		{
			if (!propertiesDirty)
			{
				propertiesDirty=true;
				setTimeout(validateProperties, 1);
			}
		}

		/**
		 * 
		 */
		private var callLaterDirty:Boolean=false;

		/**
		 * 
		 * 
		 */
		private function invalidateCallLater():void
		{
			if (!callLaterDirty)
			{
				callLaterDirty=true;
				invalidateProperties();
			}
		}

		/**
		 * 
		 */
		private var propertiesDirty:Boolean=false;

		/**
		 * 
		 * 
		 */
		private function validateProperties():void
		{
			if (propertiesDirty)
			{
				commitProperties();
				propertiesDirty=false;
			}
			if (callLaterDirty)
			{
				validateCallLaters();
				callLaterDirty=false;
			}
		}

		/**
		 * 
		 * 
		 */
		private function validateCallLaters():void
		{
			while (callLaters.length)
			{
				var info:CallLater=callLaters.shift() as CallLater;
				var scope:Object=info.scope;
				if (!scope)
				{
					scope=this;
				}
				try
				{
					var result:*=info.reference.apply(scope, info.args);					
				}
				catch (error:Error)
				{
					
				}
			}
		}

		/**
		 * 
		 * 
		 */
		protected function commitProperties():void
		{
			//abstract	
		}

	}
}
import flash.events.IEventDispatcher;

/**
 * 
 * @author Peter
 * 
 */
class CallLater
{
	/**
	 * 
	 */
	public var reference:Function;
	
	/**
	 * 
	 */
	public var scope:Object;
	
	/**
	 * 
	 */
	public var args:Array=null;

}
