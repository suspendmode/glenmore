package mediafabrique.composite
{
	import flash.events.Event;
	import flash.utils.Dictionary;
	
	import mediafabrique.glenmore.interfaces.IComponent;
	
	public class Notification extends Event
	{		
		public var source: IComponent;
		
		public var propagate: Boolean = false; 
					
		public function Notification(type:String, propagate: Boolean = true, bubbles:Boolean=true)
		{
			super(type, bubbles, true);
			this.propagate = propagate;
		}
		
		private var targets: Array = []; 
		
		public function addNotifiedTarget(target: Object): void {
			targets.push(target);
		}
		
		public function isNotifiedTarget(target: Object): Boolean {
			return targets.indexOf(target) != -1;
		}
		
		public function clear(): void {
			source = null;
			targets = [];
		}
		
		override public function toString(): String {
			var string: String = "[PropagableEvent "+type;
			if (propagate) {
				string+=", propagate";
			}
			if (bubbles) {
				string+=", bubbles";
			}
			string+="]";
			return string;
		}
	}
}