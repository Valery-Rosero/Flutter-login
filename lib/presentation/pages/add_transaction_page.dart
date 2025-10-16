import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../data/models/transaction_model.dart';
import '../controllers/expense_controller.dart';

class AddTransactionPage extends StatefulWidget {
  const AddTransactionPage({super.key});

  @override
  State<AddTransactionPage> createState() => _AddTransactionPageState();
}

class _AddTransactionPageState extends State<AddTransactionPage> {
  final _formKey = GlobalKey<FormState>();
  final amountCtrl = TextEditingController();
  final descCtrl = TextEditingController();
  final categoryCtrl = TextEditingController();
  String type = 'income';

  void save() {
    if (_formKey.currentState!.validate()) {
      final tx = TransactionModel(
        type: type,
        amount: double.parse(amountCtrl.text),
        category: categoryCtrl.text,
        description: descCtrl.text,
        date: DateTime.now(),
      );

      final controller = Get.find<ExpenseController>();
      controller.addTransaction(tx);
      Get.back();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Nueva Transacción')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              DropdownButtonFormField<String>(
                value: type,
                items: const [
                  DropdownMenuItem(value: 'income', child: Text('Ingreso')),
                  DropdownMenuItem(value: 'expense', child: Text('Gasto')),
                ],
                onChanged: (v) => setState(() => type = v!),
                decoration: const InputDecoration(labelText: 'Tipo'),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: amountCtrl,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Monto'),
                validator: (v) =>
                    v == null || v.isEmpty ? 'Ingresa un monto' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: categoryCtrl,
                decoration: const InputDecoration(labelText: 'Categoría'),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: descCtrl,
                decoration: const InputDecoration(labelText: 'Descripción'),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: save,
                child: const Text('Guardar'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
