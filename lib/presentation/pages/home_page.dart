import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/expense_controller.dart';
import '../widgets/balance_card.dart';
import 'add_transaction_page.dart';
import '../widgets/transaction_title.dart';
import '../widgets/expense_chart.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ExpenseController());

    return Scaffold(
      appBar: AppBar(
        title: const Text('Mi Balance'),
        centerTitle: true,
      ),
      body: Obx(() {
        final txs = controller.transactions;

        return ListView(
          padding: const EdgeInsets.all(16),
          children: [
            BalanceCard(balance: controller.balance),
            const SizedBox(height: 16),
            ExpenseChart(transactions: txs),
            const SizedBox(height: 16),
            const Text('Historial',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            const SizedBox(height: 8),
            if (txs.isEmpty)
              const Text('No hay transacciones todavía 💤',
                  textAlign: TextAlign.center)
            else
              ...txs.map((t) => TransactionTile(tx: t)).toList(),
          ],
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.to(() => const AddTransactionPage()),
        child: const Icon(Icons.add),
      ),
    );
  }
}
