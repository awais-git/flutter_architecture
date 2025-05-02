import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_structure/core/constants/app_constants.dart';
import 'package:flutter_structure/presentation/state/user_state.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'core/constants/app_colors.dart';
import 'core/network/dio_interceptors.dart';
import 'core/routes/app_router.dart';
import 'data/models/user_model.dart';

// Dio provider for Riverpod
final dioProvider = Provider<Dio>((ref) {
  final dio = Dio();
  dio.interceptors.add(AppInterceptors(ref));
  return dio;
});

Future<void> main() async {
  // Ensure Flutter binding is initialized
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Hive
  await Hive.initFlutter();

  // Register Hive adapters
  Hive.registerAdapter(UserModelAdapter());

  // Open Hive boxes
  await Hive.openBox<UserModel>('users');

  // Run the app with ProviderScope
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Get dependencies from providers
    final router = ref.watch(routerProvider);
    final appState = ref.watch(appStateProvider);

    // Dio is automatically initialized via dioProvider when needed
    // No need to explicitly access it here unless needed

    return MaterialApp.router(
      title: AppStrings.appName,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.primaryColor,
          brightness: appState.isDarkMode ? Brightness.dark : Brightness.light,
        ),
        useMaterial3: true,
      ),
      routerConfig: router,
      debugShowCheckedModeBanner: false,
    );
  }
}
