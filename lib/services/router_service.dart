import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:minet_insuarance/navigation/scaffold_with_navigation.dart';
import 'package:minet_insuarance/splash_screen.dart';
import 'package:minet_insuarance/features/auth/auth_module.dart';
import 'package:minet_insuarance/features/home/home_module.dart';
import 'package:minet_insuarance/features/calculator/calculator_module.dart';


final rootNavigatorKey = GlobalKey<NavigatorState>();

const routerInitialLocation = '/splash';
final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    navigatorKey: rootNavigatorKey,
    routes: [
      GoRoute(
        path: '/splash',
        name: SplashScreenPage.routeName,
        pageBuilder: (context, state) => const NoTransitionPage(
          child: SplashScreenPage(),
        ),
      ),
      GoRoute(
        path: '/login',
        name: LoginScreen.routeName,
        pageBuilder: (context, state) => NoTransitionPage(
          child: LoginScreen(),
        ),
      ),
      GoRoute(
        path: '/insurance-form',
        name: InsuranceFormScreen.routeName,
        pageBuilder: (context, state) => const NoTransitionPage(
          child: InsuranceFormScreen(),
        ),
      ),
      GoRoute(
        path: '/comparison',
        name: ComparisonScreen.routeName,
        pageBuilder: (context, state) {
          final extra = state.extra as Map<String, dynamic>?;
          if (extra == null) {
            return const NoTransitionPage(child: HomeScreen());
          }
          return NoTransitionPage(
            child: ComparisonScreen(
              client: extra['client'] as Client,
              vehicle: extra['vehicle'] as Vehicle,
              comparisons: extra['comparisons'] as List<InsurerComparison>?,
            ),
          );
        },
      ),

      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return ScaffoldWithNavigation(navigationShell: navigationShell);
        },
        branches: <StatefulShellBranch>[
          // Home/Dashboard Branch
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/home',
                name: HomeScreen.routeName,
                pageBuilder: (context, state) => const NoTransitionPage(
                  child: HomeScreen(),
                ),
              ),
            ],
          ),
          // Calculator Branch
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/calculator',
                name: CalculatorScreen.routeName,
                pageBuilder: (context, state) => const NoTransitionPage(
                  child: CalculatorScreen(),
                ),
              ),
            ],
          ),
          // Profile Branch
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/profile',
                name: ProfileScreen.routeName,
                pageBuilder: (context, state) => const NoTransitionPage(
                  child: ProfileScreen(),
                ),
              ),
            ],
          ),
        ],
      ),
      
    ],
    debugLogDiagnostics: kDebugMode,
    initialLocation: routerInitialLocation,
    redirect: (BuildContext context, GoRouterState state) {
      final authState = ref.read(authProvider);
      final isLoggedIn = authState.isLoggedIn;
      final isLoading = authState.isLoading;
      
      // Don't redirect while loading
      if (isLoading) return null;
      
      // If user is logged in and trying to access login/splash, redirect to home
      if (isLoggedIn && (state.uri.path == '/login' || state.uri.path == '/splash')) {
        return '/home';
      }
      
      // If user is not logged in and trying to access protected routes, redirect to login
      if (!isLoggedIn && state.uri.path != '/login' && state.uri.path != '/splash') {
        return '/login';
      }
      
      return null; // No redirect needed
    },
  );

});
