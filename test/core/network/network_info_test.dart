import 'dart:async';
import 'package:test/test.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:food_app_flutter/core/network/network_info.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'network_info_test.mocks.dart';

// modified
@GenerateMocks([InternetAddressInfo, Connectivity, StreamController])
main() {
  late MockInternetAddressInfo mockInternetAddressInfo;
  late MockConnectivity mockConnectivity;
  late MockStreamController mockStreamController;
  late NetworkInfoImpl networkInfoImpl;

  setUp(() {
    mockInternetAddressInfo = MockInternetAddressInfo();
    mockConnectivity = MockConnectivity();
    mockStreamController = MockStreamController();
    networkInfoImpl = NetworkInfoImpl(
        internetAddressInfo: mockInternetAddressInfo,
        connectivity: mockConnectivity,
        streamController: mockStreamController);
  });

  group('isConnected', () {
    test('should invoke to checkInternet', () {
      //arrange
      final nConnected = Future.value(true);
      when(mockInternetAddressInfo.checkInternet())
          .thenAnswer((_) => nConnected);
      //act
      final result = networkInfoImpl.isConnected;
      //assert
      verify(mockInternetAddressInfo.checkInternet());
      expect(result, nConnected);
    });
  });
}
