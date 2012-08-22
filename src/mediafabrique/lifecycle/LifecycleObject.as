/**
 *
 */
package mediafabrique.lifecycle
{
	import flash.events.Event;
	import flash.events.IEventDispatcher;
	
	import mediafabrique.glenmore.interfaces.ILifecycle;
	
	import org.as3commons.logging.api.ILogger;
	import org.as3commons.logging.api.getLogger;

	/**
	 *
	 */
	[Event(name="initialize", type="mediafabrique.lifecycle.LifecycleEvent")]

	/**
	 *
	 */
	[Event(name="dispose", type="mediafabrique.lifecycle.LifecycleEvent")]

	/**
	 *
	 */
	[Event(name="initialized", type="mediafabrique.lifecycle.LifecycleEvent")]
	
	/**
	 *
	 */
	[Event(name="disposed", type="mediafabrique.lifecycle.LifecycleEvent")]
	
	/**
	 *
	 * @author Peter
	 *
	 */
	public class LifecycleObject extends LazyObject implements ILifecycle
	{

		/**
		 *
		 */
		private static const logger:ILogger=getLogger(LifecycleObject);

		/**
		 *
		 */
		protected var isChangeingLifecycle : Boolean = false;
		
		/**
		 *
		 * @param target
		 *
		 */
		public function LifecycleObject(target:IEventDispatcher=null)
		{
			super(target);
		}

		//////////////////////////////////////////////////////////////////////////////////////

		/**
		 *
		 */
		private var _isInitialized:Boolean=false;

		[Bindable(event="isInitializedChange")]
		/**
		 *
		 * @return
		 *
		 */
		public function get isInitialized():Boolean
		{
			return _isInitialized;
		}

		/**
		 *
		 * @param value
		 *
		 */
		public function set isInitialized(value:Boolean):void
		{
			if (_isInitialized !== value)
			{
				_isInitialized=value;
				dispatchEvent(new Event("isInitializedChange"));
				if (value)
				{
					//logger.info("initialized");
				}
			}
		}

		//////////////////////////////////////////////////////////////////////////////////////

		/**
		 *
		 *
		 */
		public function initialize():void
		{
			if (isInitialized || isChangeingLifecycle)
			{
				return;
			}
			isChangeingLifecycle = true;
			//logger.info("initialize");
			var event:LifecycleEvent=new LifecycleEvent(LifecycleEvent.INITIALIZE);
			dispatchEvent(event);
			if (!event.isDefaultPrevented())
			{
				isChangeingLifecycle = false;
				isInitialized=true;				
				dispatchEvent(new LifecycleEvent(LifecycleEvent.INITIALIZED));
			}
		}

		//////////////////////////////////////////////////////////////////////////////////////

		/**
		 *
		 *
		 */
		public function dispose():void
		{
			if (!isInitialized || isChangeingLifecycle)
			{
				return;
			}
			isChangeingLifecycle = true;
			//logger.info("dispose");
			var event:LifecycleEvent=new LifecycleEvent(LifecycleEvent.DISPOSE);
			dispatchEvent(event);
			if (!event.isDefaultPrevented())
			{
				isChangeingLifecycle = false;				
				isInitialized=false;
				dispatchEvent(new LifecycleEvent(LifecycleEvent.DISPOSED));
			}
		}

	}
}
