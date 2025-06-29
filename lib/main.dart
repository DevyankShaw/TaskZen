import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:taskzen/app_router.dart';
import 'package:taskzen/features/shared/themes/app_theme.dart';

void main() {
  runApp(
    ProviderScope(
      child: MaterialApp.router(
        title: 'TaskZen',
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        routerConfig: appRouter,
      ),
    ),
  );
}
