import 'package:flutter/cupertino.dart';

class CounterModel extends ChangeNotifier {
  int _count = 0;

  int get count => _count;

  void increment() {
    _count++;
    notifyListeners(); // Data changed: Notify listeners
  }
}