import 'dart:async';

import 'package:climater/services/last_update_service.dart';
import 'package:flutter/material.dart';

class LastUpdateProvider with ChangeNotifier {
  LastUpdateService lastUpdateService = LastUpdateService();
  Timer? timer;

  LastUpdateProvider() {
    _init();
  }

  Future<void> _init() async {
    await lastUpdateService.loadUpdateTime();
    debugPrint('Last update service initiated');
    _startTimer();
  }

  void _startTimer() {
    timer?.cancel();
    timer = Timer.periodic(Duration(seconds: 1), (timer) => notifyListeners());
  }

  Future<void> saveLastUpdate() async {
    debugPrint('SAVE UPDATE TIME CALLED ON LAST UPDATE PROVIDER.');
    await lastUpdateService.saveUpdateTime();
    notifyListeners();
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  String get lastUpdateTime => lastUpdateService.getLastUpdateFormatted();
}
