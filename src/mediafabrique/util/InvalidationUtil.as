/**
 *
 */
package mediafabrique.util {
  import flash.utils.Dictionary;
  import flash.utils.setTimeout;
  
  /**
   *
   * @author Peter
   *
   */
  public class InvalidationUtil {
    
    /////////////////////////////////////////////////////////////////////////
    
    /**
     *
     */
    public static var INVALIDATION_TIMEOUT : int = 5;
    
    /**
     *
     */
    private static var validateFunctions : Dictionary = new Dictionary();
    
    /**
     *
     * @param validateFunction
     * @return
     *
     */
    public static function invalidate(validateFunction : Function) : void {
      if (validateFunction in validateFunctions) {
        return;
      } else {
        var onValidate : Function = function() : void {
          FunctionUtil.invoke(validateFunction);
          delete validateFunctions[validateFunction];
        }
        validateFunctions[validateFunction] = new Error().getStackTrace();
        setTimeout(onValidate, INVALIDATION_TIMEOUT);
      }
    }
  }
}