import 'dart:convert';
import 'package:flutter/services.dart';

class FileManager {
  static Future<dynamic> readJsonFile(String filePath) async {
    var input = await rootBundle.loadString(filePath);
    var map = jsonDecode(input);
    return map;
  }
}
