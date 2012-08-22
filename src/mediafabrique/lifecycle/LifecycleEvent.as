package mediafabrique.lifecycle
{
	import flash.events.Event;
	
	public class LifecycleEvent extends Event
	{
		
		public static const INITIALIZE: String = "initialize";
		public static const DISPOSE: String = "dispose";
		
		public static const INITIALIZED: String = "initialized";
		public static const DISPOSED: String = "disposed";
		
		public function LifecycleEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
		
		/**
		 *
		 * @return
		 *
		 */
		override public function clone() : Event {
			var event : LifecycleEvent = new LifecycleEvent(type, bubbles, cancelable);
			
			if (isDefaultPrevented()) {
				event.preventDefault();
			}
			return event;
		}
	}
}