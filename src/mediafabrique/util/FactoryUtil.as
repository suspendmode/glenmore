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
  public class FactoryUtil {

    /**
     *
     */
    private static const NO_MORE_ARGUMENTS_ERROR : String = "no more than 12 constructor arguments allowed";

    /**
     *
     * @param reference
     * @param args
     * @return
     *
     */
    public static function createInstance(generator : Class, constructorArguments : Array = null) : * {
      var result : *;

      if (constructorArguments != null && constructorArguments.length) {
        switch (constructorArguments.length) {
          case 1 : 
            result = new generator(constructorArguments[0]);
            break;
          case 2 : 
            result = new generator(constructorArguments[0], constructorArguments[1]);
            break;
          case 3 : 
            result = new generator(constructorArguments[0], constructorArguments[1],
              constructorArguments[2]);
            break;
          case 4 : 
            result = new generator(constructorArguments[0], constructorArguments[1],
              constructorArguments[2], constructorArguments[3]);
            break;
          case 5 : 
            result = new generator(constructorArguments[0], constructorArguments[1],
              constructorArguments[2], constructorArguments[3], constructorArguments[4]);
            break;
          case 6 : 
            result = new generator(constructorArguments[0], constructorArguments[1],
              constructorArguments[2], constructorArguments[3], constructorArguments[4],
              constructorArguments[5]);
            break;
          case 7 : 
            result = new generator(constructorArguments[0], constructorArguments[1],
              constructorArguments[2], constructorArguments[3], constructorArguments[4],
              constructorArguments[5], constructorArguments[6]);
            break;
          case 8 : 
            result = new generator(constructorArguments[0], constructorArguments[1],
              constructorArguments[2], constructorArguments[3], constructorArguments[4],
              constructorArguments[5], constructorArguments[6], constructorArguments[7]);
            break;
          case 9 : 
            result = new generator(constructorArguments[0], constructorArguments[1],
              constructorArguments[2], constructorArguments[3], constructorArguments[4],
              constructorArguments[5], constructorArguments[6], constructorArguments[7],
              constructorArguments[8]);
            break;
          case 10 : 
            result = new generator(constructorArguments[0], constructorArguments[1],
              constructorArguments[2], constructorArguments[3], constructorArguments[4],
              constructorArguments[5], constructorArguments[6], constructorArguments[7],
              constructorArguments[8], constructorArguments[9]);
            break;
          case 11 : 
            result = new generator(constructorArguments[0], constructorArguments[1],
              constructorArguments[2], constructorArguments[3], constructorArguments[4],
              constructorArguments[5], constructorArguments[6], constructorArguments[7],
              constructorArguments[8], constructorArguments[9], constructorArguments[10]);
            break;
          case 12 : 
            result = new generator(constructorArguments[0], constructorArguments[1],
              constructorArguments[2], constructorArguments[3], constructorArguments[4],
              constructorArguments[5], constructorArguments[6], constructorArguments[7],
              constructorArguments[8], constructorArguments[9], constructorArguments[10],
              constructorArguments[11]);
            break;
          default : 
            throw new Error(NO_MORE_ARGUMENTS_ERROR);
        }
      } else {
        result = new generator();
      }
      return result;
    }
  }
}