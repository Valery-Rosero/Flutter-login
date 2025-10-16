import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../data/models/transaction_model.dart';

class TransactionTile extends StatelessWidget {
  final TransactionModel tx;

  const TransactionTile({super.key, required this.tx});

  @override
  Widget build(BuildContext context) {
    final isIncome = tx.type == 'income';
    final color = isIncome ? AppColors.income : AppColors.expense;
    final icon = isIncome ? Icons.arrow_upward : Icons.arrow_downward;

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 6),
      child: ListTile(
        leading: Icon(icon, color: color),
        title: Text(
          tx.category.isEmpty ? (isIncome ? 'Ingreso' : 'Gasto') : tx.category,
          style: const TextStyle(fontWeight: FontWeight.w500),
        ),
        subtitle: Text(tx.description),
        trailing: Text(
          '\$${tx.amount.toStringAsFixed(2)}',
          style: TextStyle(color: color, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
