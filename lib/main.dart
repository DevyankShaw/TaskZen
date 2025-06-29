import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:taskzen/router/app_router.dart';
import 'package:taskzen/features/shared/theme/app_theme.dart';

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
