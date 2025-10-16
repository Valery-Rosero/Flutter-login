import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../data/models/transaction_model.dart';

class ExpenseChart extends StatelessWidget {
  final List<TransactionModel> transactions;

  const ExpenseChart({super.key, required this.transactions});

  @override
  Widget build(BuildContext context) {
    final data = _getChartData();

    final total = data.fold<double>(0, (sum, d) => sum + d.amount);

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const Text(
              'Distribución de gastos',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 220,
              child: PieChart(
                PieChartData(
                  sectionsSpace: 2,
                  centerSpaceRadius: 40,
                  sections: data.map((d) {
                    final percentage = total > 0 ? (d.amount / total * 100) : 0;
                    return PieChartSectionData(
                      color: _getColorForCategory(d.category),
                      value: d.amount,
                      title:
                          '${d.category}\n${percentage.toStringAsFixed(1)}%',
                      radius: 80,
                      titleStyle: const TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Agrupa las transacciones por categoría y suma los montos
  List<_ChartData> _getChartData() {
    final Map<String, double> totals = {};
    for (final t in transactions.where((t) => t.type == 'expense')) {
      final category = t.category.isEmpty ? 'Otros' : t.category;
      totals[category] = (totals[category] ?? 0) + t.amount;
    }
    return totals.entries
        .map((e) => _ChartData(e.key, e.value))
        .toList();
  }

  /// Asigna un color diferente a cada categoría
  Color _getColorForCategory(String category) {
    final colors = {
      'Comida': Colors.pinkAccent,
      'Transporte': Colors.blueAccent,
      'Entretenimiento': Colors.orangeAccent,
      'Compras': Colors.greenAccent,
      'Salud': Colors.purpleAccent,
      'Otros': Colors.grey,
    };
    return colors[category] ?? Colors.blueGrey;
  }
}

class _ChartData {
  final String category;
  final double amount;
  _ChartData(this.category, this.amount);
}
