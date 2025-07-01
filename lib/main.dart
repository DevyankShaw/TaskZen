import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:taskzen/bloc_observer.dart';
import 'package:taskzen/router/app_router.dart';
import 'package:taskzen/features/shared/theme/app_theme.dart';

void main() {
  Bloc.observer = const SimpleBlocObserver();
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
