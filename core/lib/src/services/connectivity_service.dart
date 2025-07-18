import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';

class ConnectivityService {
  final Connectivity _connectivity = Connectivity();
  late final Stream<bool> isOnlineStream;

  ConnectivityService() {
    isOnlineStream = _connectivity.onConnectivityChanged
        .map((results) => _hasConnection(results))
        .asBroadcastStream();
  }

  Future<bool> isOnline() async {
    final results = await _connectivity.checkConnectivity();
    return _hasConnection(results);
  }

  bool _hasConnection(List<ConnectivityResult> results) {
    return !results.contains(ConnectivityResult.none);
  }
}
