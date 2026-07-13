
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:minet_insuarance/navigation/scaffold_with_navigation.dart';
class NavigationAppBar extends ConsumerStatefulWidget implements PreferredSizeWidget {
  const NavigationAppBar({super.key});

  @override
  ConsumerState<NavigationAppBar> createState() => _NavigationAppBarState();

  @override
  Size get preferredSize => AppBar().preferredSize;
}

class _NavigationAppBarState extends ConsumerState<NavigationAppBar> {


  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Theme.of(context).colorScheme.surface,
      elevation: 0,
      leading: IconButton(
        onPressed: (){
          scaffoldKey.currentState?.openDrawer();
        },
        icon: const Icon(Icons.menu),
      ),
      actions: [
        IconButton(
          onPressed: (){
            // TODO: Implement search functionality
          },
          icon: const Icon(Icons.search),
        ),
        IconButton(
          onPressed: (){
            // TODO: Navigate to notifications screen
          },
          icon: const Icon(Icons.notifications_outlined),
        ),
      ],
    );
  }

// @override
// Size get preferredSize => AppBar().preferredSize;
}
