import 'package:hive/hive.dart';

part 'transaction_model.g.dart';

@HiveType(typeId: 0)
class TransactionModel extends HiveObject {
  @HiveField(0)
  String type; // 'income' o 'expense'

  @HiveField(1)
  double amount;

  @HiveField(2)
  String category;

  @HiveField(3)
  String description;

  @HiveField(4)
  DateTime date;

  TransactionModel({
    required this.type,
    required this.amount,
    required this.category,
    required this.description,
    required this.date,
  });
}
