
import 'dart:io';

String fixture(String name) => File('test/fixtures/$name').readAsStringSync();

// Future<Map<String, dynamic>> fixture(String name) async {
//   final String response = await rootBundle.loadString('test/fixtures/$name');
//   final data = await json.decode(response);
//   return data;
// }