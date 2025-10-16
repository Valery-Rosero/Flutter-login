import 'package:get/get.dart';
import '../../data/local_storage/hive_config.dart';
import '../../data/models/transaction_model.dart';

class ExpenseController extends GetxController {
  var transactions = <TransactionModel>[].obs;

  double get totalIncome =>
      transactions.where((t) => t.type == 'income').fold(0, (sum, t) => sum + t.amount);

  double get totalExpense =>
      transactions.where((t) => t.type == 'expense').fold(0, (sum, t) => sum + t.amount);

  double get balance => totalIncome - totalExpense;

  @override
  void onInit() {
    super.onInit();
    loadTransactions();
  }

  void loadTransactions() {
    final box = HiveConfig.box;
    transactions.value = box.values.toList();
  }

  void addTransaction(TransactionModel tx) {
    final box = HiveConfig.box;
    box.add(tx);
    loadTransactions();
  }
}
