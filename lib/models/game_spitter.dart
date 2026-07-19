import 'package:flutter/material.dart';
import 'dart:math';

String randomKeySpitter(Map gameMap) {
  final randomKey = gameMap.keys.elementAt(Random().nextInt(gameMap.length));
  return randomKey;
}

List getexamples(Map gameMap, String key) {
  List exampleList = gameMap[key];
  return exampleList;
}