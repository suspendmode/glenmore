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
   * simple array util
   */
  public class ArrayUtil {

    /**
     *
     * @param array
     * @return
     *
     */
    public function getUniqueValues(array : Array) : Array {
      var length : Number = array.length;
      var dictionary : Dictionary = new Dictionary();
      var value : Object;

      for (var i : Number = 0; i < length; i++) {
        value = array[i];
        dictionary[value] = value;
      }

      return DictionaryUtil.toArray(dictionary);
    }

    /**
     *
     * @param array
     * @param elements
     *
     */
    public static function addAll(array : Array, elements : Array) : void {
      while (elements.length) {
        array.push(elements.shift());
      }
    }

    /**
     *
     */
    public static function removeAll(array : Array) : Array {
      var clone : Array = [];

      while (array.length) {
        clone.push(array.shift());
      }
      return clone;
    }

    /**
     *
     * @param array
     * @param object
     * @return
     *
     */
    public static function remove(array : Array, object : Object) : int {
      var index : int = getObjectIndex(array, object);
      array.splice(index, 1);
      return index;
    }

    /**
     * Gets index of item if found otherwise returns -1 (outofrange index)
     *
     * @param array Array of items as a source
     * @param object Object to found in source
     *
     * @return index of item
     */
    public static function getObjectIndex(array : Array, object : Object) : int {
      for (var i : int = 0; i < array.length; i++) {
        if (array[i] == object) {
          return i;
        }
      }
      return -1;
    }

    /**
     *
     * @param array
     * @return
     *
     */
    public static function toDictionary(array : Array) : Dictionary {
      var l : int = array.length;
      var out : Dictionary = new Dictionary();

      while (l--) {
        out[l] = array[l];
      }
      return out;
    }
  }
}