import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:minet_insuarance/services/router_service.dart';
import 'package:minet_insuarance/theme.dart';
import 'package:responsive_framework/responsive_framework.dart';


void main() async {

  WidgetsFlutterBinding.ensureInitialized();

  // FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  runApp(ProviderScope(observers:[Logging()],child: const MinetInsuaranceApp()));
}

class MinetInsuaranceApp extends ConsumerStatefulWidget {
  const MinetInsuaranceApp({super.key});

  @override
  ConsumerState<MinetInsuaranceApp> createState() => _MinetInsuaranceAppState();
}

class _MinetInsuaranceAppState extends ConsumerState<MinetInsuaranceApp> {
  @override
  Widget build(BuildContext context) {
    return ResponsiveBreakpoints.builder(
      breakpoints: [
        const Breakpoint(start: 0, end: 450, name: MOBILE),
        const Breakpoint(start: 451, end: 960, name: TABLET),
        const Breakpoint(start: 961, end: double.infinity, name: DESKTOP),
      ],
      child: SafeArea(
          top: false,
          child: MaterialApp.router(
            title: 'Minet Insuarance',
            routerConfig: ref.read(routerProvider),
            theme: AppTheme.light,
            darkTheme: AppTheme.dark,
            debugShowCheckedModeBanner: false,
          ),
        ),
    );
  }
}

class Logging extends ProviderObserver {
  @override
  void didUpdateProvider(
      ProviderBase provider,
      Object? previousValue,
      Object? newValue,
      ProviderContainer container,
      ) {
    // _log.i('[${provider.name ?? provider.runtimeType}] value: $newValue');
  }
}
