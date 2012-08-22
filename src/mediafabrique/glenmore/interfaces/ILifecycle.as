package mediafabrique.glenmore.interfaces
{
	public interface ILifecycle
	{
		function initialize(): void;
		
		function dispose(): void;
		
		function get isInitialized():Boolean;
	}
}