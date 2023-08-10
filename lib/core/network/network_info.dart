
import 'dart:async';
import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';

abstract class NetworkInfo {
  Future<bool> get isConnected;
}

abstract class InternetAddressInfo {
  Future<bool> checkInternet();
}

class NetworkInfoImpl implements NetworkInfo {
  final InternetAddressInfo internetAddressInfo;
  final Connectivity connectivity;
  final StreamController streamController;
  // StreamController controller = StreamController.broadcast();

  NetworkInfoImpl({required this.internetAddressInfo, required this.connectivity, required this.streamController});

  Stream get myStream => streamController.stream;

  @override
  Future<bool> get isConnected => _hasConnection;

  Future<bool> get _hasConnection {
    Future<bool> isOnline = Future.value(false);
    try {
      isOnline = internetAddressInfo.checkInternet();
    } on SocketException catch (_) {
      isOnline = Future.value(false);
    }
    return isOnline;
  }

  //Public Methods

  void listen(Function body) async {
    myStream.listen(body());
    connectivity.onConnectivityChanged.listen((result) async {
      final isOnline = await _hasConnection;
      streamController.sink.add({result: isOnline});
    });
  }

  void dispose() => streamController.close();
}

class InternetAddressInfoImpl implements InternetAddressInfo {

  @override
  Future<bool> checkInternet() async {
    final result = await InternetAddress.lookup('google.com');
    if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
      return Future.value(true);
    } else {
      return Future.value(false);
    }
  }
}