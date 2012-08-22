/**
 * Copyright (C) Piotr Kucharski
 * email: suspendmode@gmail.com
 *
 * All rights reserved. Any use, copying, modification, distribution and selling
 * of this software and it's documentation for any purposes without authors' written
 * permission is hereby prohibited.
 */
package mediafabrique.util {

  import flash.utils.Dictionary;

  /**
   *
   * @author Work
   *
   */
  public class DictionaryUtil {

    /**
     *
     */

    /**
     *
     * @param dictionaries
     * @return
     *
     */
    public static function merge(... dictionaries : Array) : Dictionary {
      var out : Dictionary = new Dictionary();

      for each (var source : Dictionary in dictionaries) {
        for (var key : *in source) {
          out[key] = source[key];
        }
      }
      return out;
    }

    /**
     *
     * @param target
     * @param dictionaries
     *
     */
    public static function mergeTo(target : Dictionary, ... dictionaries : Array) : void {
      for each (var source : Dictionary in dictionaries) {
        for (var key : *in source) {
          target[key] = source[key];
        }
      }
    }

    /**
     *
     * @param source
     * @return
     *
     */
    public static function toArray(source : Dictionary) : Array {
      var list : Array = [];

      for each (var item : *in source) {
        list.push(item);
      }
      return list;
    }

    /**
     *
     * @param source
     * @return
     *
     */
    public static function getKeys(source : Dictionary) : Array {
      var list : Array = [];

      for (var item : *in source) {
        list.push(item);
      }
      return list;
    }

    /**
     *
     * @param source
     * @param item
     * @return
     *
     */
    public static function getKey(source : Dictionary, item : *) : * {
      for (var key : *in source) {
        if (item == source[key]) {
          return key;
        }
      }
      return null;
    }
  }
}