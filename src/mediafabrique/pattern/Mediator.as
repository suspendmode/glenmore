package mediafabrique.pattern
{
	import flash.events.Event;
	import flash.events.IEventDispatcher;
	
	import mediafabrique.lifecycle.LazyObject;

	public class Mediator
	extends LazyObject {
	
		public function Mediator(target: IEventDispatcher = null)
		{
			super(target);
			if (target) {
			this.target = target;
			}
		}
				
		private var targetChanged:Boolean;
		
		private var _target:IEventDispatcher;
		
		[Bindable("targetChanged")]
		public function get target():IEventDispatcher
		{
			return _target;
		}
		
		public function set target(value:IEventDispatcher):void
		{
			if (_target != value)
			{
				if (_target)
				{
					unregister();
				}
				_target=value;
				if (value)
				{
					register();
				}
			}
			invalidateProperties();
			dispatchEvent(new Event("targetChanged"))
		}
		
		protected function unregister():void
		{
			
		}
		
		protected function register():void
		{
			
		}
		
		override protected function commitProperties():void {
			super.commitProperties();
			
			if (targetChanged) {
				targetChanged = false;
			}
		}
	}
}