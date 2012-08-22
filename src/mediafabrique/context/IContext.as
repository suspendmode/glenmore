/**
 *
 */
package mediafabrique.context {
	import mediafabrique.glenmore.interfaces.IComponent;
	import mediafabrique.glenmore.interfaces.IContainer;
	
  
  
  /**
   *
   * @author Peter
   *
   */
  public interface IContext extends IContainer {
    
    /**
     *
     * @param value
     *
     */
    function set descriptor(value : Object) : void;
    
    /**
     *
     * @return
     *
     */
    function get descriptor() : Object;
    
    /**
     *
     * @param descriptor
     * @return
     *
     */
    function getContextByDescriptor(descriptor : Object) : IContext;
	
	/**
	 * 
	 * @param path
	 * @return 
	 * 
	 */
	function getByPath(path: String): Object;		
        
  }
}