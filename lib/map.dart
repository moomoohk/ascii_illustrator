// Copyright (c) 2015, Meshulam Silk (moomoohk@ymail.com). All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

part of ascii_illustrator;

int dimension = 5;

class PixelMap {
  List<List<bool>> _variations;
  String char;

  PixelMap(List<bool> map, String char)
      : _variations = new List<List<bool>>(),
        this.char = char {
    _variations.add(map);
  }

  PixelMap.variations(List<List<bool>> maps, String char)
      : _variations = maps,
        this.char = char;

  void addVariation(List<bool> variation) {
    _variations.add(variation);
  }

  bool check(List<bool> map) {
    for (List<bool> variation in _variations) {
      bool matches = true;
      if (map.length != variation.length) {
        return false;
      }
      for (int i = 0; i < map.length; i++) {
        if (map[i] != variation[i]) {
          matches = false;
        }
      }
      if (matches) {
        return true;
      }
    }
    return false;
  }

  PixelMap combine(PixelMap map, String char) {
    List<List<bool>> resultVariations = new List<List<bool>>();
    for (List<bool> variation1 in _variations) {
      for (List<bool> variation2 in map._variations) {
        if (variation1.length != variation2.length) {
          return null;
        }
        List<bool> result = new List<bool>(variation1.length);
        for (int i = 0; i < result.length; i++) {
          result[i] = variation1[i] || variation2[i];
        }
        resultVariations.add(result);
      }
    }
    return new PixelMap.variations(resultVariations, char);
  }

  PixelMap flip(String char) {
    List<List<bool>> resultVariations = new List<List<bool>>();
    for (List<bool> variation in _variations) {
      List<bool> result = new List<bool>();
      List<List<bool>> rows = new List<List<bool>>();
      for (int i = 0; i < variation.length; i += dimension) {
        rows.add(variation.sublist(i, i + dimension));
      }
      for (int i = rows.length - 1; i >= 0; i--) {
        result.addAll(rows[i]);
      }
      resultVariations.add(result);
    }
    return new PixelMap.variations(resultVariations, char);
  }

  String toString() {
    String output = "[";
    for (List<bool> variation in _variations) {
      for (int y = 0; y < dimension; y++) {
        for (int x = 0; x < dimension; x++) {
          output += "${variation[x + y * 5] ? "*" : " "} ";
        }
        output += "\n";
      }
      output += "-\n";
    }
    output += "]";
    return output;
  }
}
