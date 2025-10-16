import 'package:hive_flutter/hive_flutter.dart';
import '../models/transaction_model.dart';

class HiveConfig {
  static const String boxName = 'transactionsBox';

  static Future<void> init() async {
    await Hive.initFlutter();
    Hive.registerAdapter(TransactionModelAdapter());
    await Hive.openBox<TransactionModel>(boxName);
  }

  static Box<TransactionModel> get box => Hive.box<TransactionModel>(boxName);
}
