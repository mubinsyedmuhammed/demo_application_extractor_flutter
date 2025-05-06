import 'package:flutter/foundation.dart';

class HomeViewModel {
  final ValueNotifier<bool> isStarted = ValueNotifier<bool>(false);

  void start() {
    isStarted.value = true;
  }

  void stop() {
    isStarted.value = false;
  }
}
