import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'core/config/supabase_config.dart';
import 'data/local_storage/hive_config.dart';
import 'core/theme/app_theme.dart';
import 'presentation/pages/login_page.dart';
import 'presentation/pages/home_page.dart';
import 'presentation/pages/register_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SupabaseConfig.init();
  await HiveConfig.init();

  final session = Supabase.instance.client.auth.currentSession;

  runApp(ExpenseApp(initialPage: session == null ? const LoginPage() : const HomePage()));
}

class ExpenseApp extends StatelessWidget {
  final Widget initialPage;

  const ExpenseApp({super.key, required this.initialPage});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Expense Tracker',
      theme: AppTheme.lightTheme,
      debugShowCheckedModeBanner: false,
      home: initialPage,
      getPages: [
        GetPage(name: '/login', page: () => const LoginPage()),
        GetPage(name: '/register', page: () => const RegisterPage()),
        GetPage(name: '/home', page: () => const HomePage()),
      ],
    );
  }
}
