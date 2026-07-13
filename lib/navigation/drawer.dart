import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:minet_insuarance/features/auth/auth_module.dart';
import 'package:minet_insuarance/features/home/home_module.dart';
import 'package:minet_insuarance/features/calculator/calculator_module.dart';


class AppDrawer extends StatefulWidget {
  const AppDrawer({super.key});

  @override
  State<AppDrawer> createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: MediaQuery.sizeOf(context).width * .7,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildDrawerHeader(),
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                _buildDrawerItem(
                  context: context,
                  icon: const Icon(Icons.home_outlined),
                  text: 'Home',
                  onTap: () {
                    Navigator.pop(context);
                    context.goNamed(HomeScreen.routeName);
                  },
                ),
                _buildDrawerItem(
                  context: context,
                  icon: const Icon(Icons.calculate_outlined),
                  text: 'Calculator',
                  onTap: () {
                    Navigator.pop(context);
                    context.goNamed(CalculatorScreen.routeName);
                  },
                ),
                _buildDrawerItem(
                  context: context,
                  icon: const Icon(Icons.person_outline),
                  text: 'Profile',
                  onTap: () {
                    Navigator.pop(context);
                    context.goNamed(ProfileScreen.routeName);
                  },
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 20.0),
            child: _buildDrawerItem(
              context: context,
              icon: const Icon(Icons.logout_outlined),
              text: 'Logout',
              onTap: () {
                Navigator.pop(context);
                // TODO: Implement logout functionality
                context.goNamed(LoginScreen.routeName);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDrawerHeader() {
    return InkWell(
      onTap: () => context.goNamed(ProfileScreen.routeName),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Theme.of(context).colorScheme.primary,
              Theme.of(context).colorScheme.primaryContainer,
            ],
          ),
        ),
        child: DrawerHeader(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Theme.of(context).colorScheme.onPrimary.withOpacity(0.1),
                Theme.of(context).colorScheme.onPrimary.withOpacity(0.3),
              ],
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              CircleAvatar(
                radius: 30,
                backgroundColor: Theme.of(context).colorScheme.onPrimary.withOpacity(0.2),
                child: Icon(
                  Icons.person,
                  size: 30,
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                'Minet Insurance',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
              ),
              Text(
                'User Profile',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Theme.of(context).colorScheme.onPrimary.withOpacity(0.8),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDrawerItem({
    required BuildContext context,
    required Widget icon,
    required String text,
    required VoidCallback onTap,
    Widget? trailing,
  }) {
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
        child: Column(
          children: [
            Row(
              children: [
                icon,
                SizedBox(width: 15),
                Text(
                  text,
                  style: theme.textTheme.bodyMedium,
                ),
                if (trailing != null) ...[
                  const Spacer(),
                  trailing,
                ],
              ],
            ),
            Divider()
          ],
        ),
      ),
    );
  }
}
