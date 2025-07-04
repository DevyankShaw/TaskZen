import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'bloc_observer.dart';
import 'features/shared/theme/app_theme.dart';
import 'router/app_router.dart';

void main() {
  Bloc.observer = const SimpleBlocObserver();
  runApp(
    ProviderScope(
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        title: 'TaskZen',
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        routerConfig: appRouter,
      ),
    ),
  );
}
