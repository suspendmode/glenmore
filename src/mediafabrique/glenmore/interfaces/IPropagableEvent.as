package mediafabrique.glenmore.interfaces
{
	public interface IPropagableEvent
	{
		
		function set type(value: String): void;
		function get type(): String;
		
		function set data(value: Object): void;
		function get data(): Object;
	}
}