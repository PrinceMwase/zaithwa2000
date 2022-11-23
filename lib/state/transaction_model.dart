import 'package:flutter/widgets.dart';
import 'dart:async'; // new

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_parcel_app/ui/widgets/my_parcel_delivery_method.dart';

class TransactionModel extends ChangeNotifier {
  bool transactionStarted = false;
  final List<Size> _items = [];

  void triggerTransaction(Size size) {
    transactionStarted = true;
    triggerSize(size);
    notifyListeners();
  }

  List get allItems => _items;

  void triggerSize(Size size) {
    if (_items.isNotEmpty) {
      _items.clear();
      _items.add(size);
    } else {
      _items.add(size);
    }
    notifyListeners();
  }

  void clearTransaction() {
    _items.clear();
    transactionStarted = false;
    notifyListeners();
  }

  Future<DocumentReference> addTransactionToCustomerService(
      ParcelTransaction transaction) {
    return FirebaseFirestore.instance
        .collection('transactions')
        .add(<String, dynamic>{
      "service_type": transaction.serviceType,
      "customer_id": transaction.customerId,
      "receiver_name": transaction.receiverName,
      "receiver_phone": transaction.receiverPhone,
      "whatsapp_status": transaction.whatsappStatus == WhatsappStatus.online
          ? "online"
          : "offline",
      "fragile": transaction.fragile == IsFragile.yes ? "yes" : "no",
      "electronics": transaction.electronics == IsElectronic.yes ? "yes" : "no",
      "location": transaction.location,
      "district": transaction.district,
      'timestamp': DateTime.now().millisecondsSinceEpoch,
    });
  }
}

class Size {
  final String _size;
  Size(this._size);

  String get size => _size;
}

class ParcelTransaction {
  final String serviceType;
  final String customerId;
  final String receiverName;
  final String receiverPhone;
  final WhatsappStatus? whatsappStatus;
  final IsFragile? fragile;
  final IsElectronic? electronics;
  final String location;
  final String district;

  ParcelTransaction(
    this.serviceType,
    this.customerId,
    this.receiverName,
    this.receiverPhone,
    this.whatsappStatus,
    this.fragile,
    this.electronics,
    this.location,
    this.district,
  );
}
