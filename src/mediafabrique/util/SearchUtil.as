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
  public class SearchUtil {
    
    /**
     * 
     * @param list
     * @param searchObject
     * @return 
     * 
     */
    public static function searchFor(list: Array, searchObject: Object): int {
      var index: int = -1;
      for (var i: int = 0; i < list.length; i++) {
        var item: Object = list[i];
        var found: Boolean = true;
        for (var searchProperty: String in searchObject) {
          if (item.hasOwnProperty(searchProperty) && (item[searchProperty] === searchObject[searchProperty])) {
            found &&= true;             
          } else {
            found = false;
            break;
          }
        }
        if (found) {
          index = i;
          break;
        } else {
          continue;
        }
      }
      return index;
    }
  }
}