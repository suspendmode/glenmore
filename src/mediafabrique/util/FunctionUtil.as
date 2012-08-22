/**
 * Copyright (C) Piotr Kucharski
 * email: suspendmode@gmail.com
 *
 * All rights reserved. Any use, copying, modification, distribution and selling
 * of this software and it's documentation for any purposes without authors' written
 * permission is hereby prohibited.
 */
package mediafabrique.util {
  
  /**
   *
   * @author Work
   *
   */
  public class FunctionUtil {
    
    /**
     *
     */
    private static const NO_MORE_ARGUMENTS_ERROR : String = "no more than 12 parameters allowed";
    
    /**
     *
     * @param reference
     * @param args
     * @return
     *
     */
    public static function invoke(reference : Function, args : Array = null) : * {
      var result : *;
      
      if (args == null) {
        result = reference();
      } else {
        switch (args.length) {
          case 0:
            result = reference();
            break;
          case 1:
            result = reference(args[0]);
            break;
          case 2:
            result = reference(args[0], args[1]);
            break;
          case 3:
            result = reference(args[0], args[1], args[2]);
            break;
          case 4:
            result = reference(args[0], args[1], args[2], args[3]);
            break;
          case 5:
            result = reference(args[0], args[1], args[2], args[3], args[4]);
            break;
          case 6:
            result = reference(args[0], args[1], args[2], args[3], args[4],
              args[5]);
            break;
          case 7:
            result = reference(args[0], args[1], args[2], args[3], args[4],
              args[5], args[6]);
            break;
          case 8:
            result = reference(args[0], args[1], args[2], args[3], args[4],
              args[5], args[6], args[7]);
            break;
          case 9:
            result = reference(args[0], args[1], args[2], args[3], args[4],
              args[5], args[6], args[7], args[8]);
            break;
          case 10:
            result = reference(args[0], args[1], args[2], args[3], args[4],
              args[5], args[6], args[7], args[8], args[9]);
            break;
          case 11:
            result = reference(args[0], args[1], args[2], args[3], args[4],
              args[5], args[6], args[7], args[8], args[9], args[10]);
            break;
          case 12:
            result = reference(args[0], args[1], args[2], args[3], args[4],
              args[5], args[6], args[7], args[8], args[9], args[10], args[11]);
            break;
          default:
            throw new Error(NO_MORE_ARGUMENTS_ERROR);
        }
      }
      return result;
    }
  }
}