import 'package:flutter/widgets.dart';

class TransactionModel extends ChangeNotifier {
  bool started = false;
  final List<Size> _items = [];

  void triggerTransaction() {
    started = true;
    notifyListeners();
  }

  void triggerSize(Size size) {
    if (_items.isNotEmpty) {
      _items.clear();
    } else {
      _items.add(size);
    }
    notifyListeners();
  }
}

class Size {
  final String size;
  Size(this.size);
}
