
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:riverpod/riverpod.dart';

import '../../services/router_service.dart';
import 'app_bar.dart';
import 'drawer.dart';
import 'navigation_items.dart';

final isExpandedProvider = StateProvider<bool>((ref) => true);
final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

class ScaffoldWithNavigation extends StatelessWidget {
  const ScaffoldWithNavigation({
    super.key,
    required this.navigationShell,
  });

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    print("screen width: ${MediaQuery.sizeOf(context).width}");
    final breakpoint = ResponsiveBreakpoints.of(context).breakpoint;
    print("the brak point name: ${breakpoint.name}");
    return _ScaffoldWithNavigationBar(navigationShell);
    // return switch (breakpoint.name) {
    //   MOBILE => _ScaffoldWithNavigationBar(navigationShell),
    //   (_) => _ScaffoldWithNavigationRail(navigationShell),
    // };
  }
}

class _ScaffoldWithNavigationRail extends StatelessWidget {
  const _ScaffoldWithNavigationRail(this.navigationShell);

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    return Scaffold(
      appBar: const NavigationAppBar(),
      body: Row(
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _NavigationRail(
                navigationShell: navigationShell,
                expand: true,
              ),
              // const Padding(
              //   padding: EdgeInsets.all(16),
              //   child: ThemeModeButton.icon(),
              // ),
            ],
          ),
          VerticalDivider(
            thickness: 1,
            width: 1,
            color: colorScheme.primary.withOpacity(0.2),
          ),
          Expanded(child: navigationShell),
        ],
      ),
    );
  }
}

class _ScaffoldWithDrawer extends StatefulWidget {
  const _ScaffoldWithDrawer(this.navigationShell);

  final StatefulNavigationShell navigationShell;

  @override
  State<_ScaffoldWithDrawer> createState() => _ScaffoldWithDrawerState();
}

class _ScaffoldWithDrawerState extends State<_ScaffoldWithDrawer> {
  String? userType = "";

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    final theme = Theme.of(context);
    return Scaffold(
      appBar: const NavigationAppBar(),
      body: widget.navigationShell,
      drawer: Drawer(
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              DrawerHeader(
                decoration: const BoxDecoration(border: Border()),
                margin: EdgeInsets.zero,
                child: Center(
                  child: Text(
                    'Washamba App',
                    style: theme.textTheme.bodyMedium!
                        .copyWith(fontWeight: FontWeight.w600),
                  ),
                ),
              ),
              _NavigationRail(
                navigationShell: widget.navigationShell,
                expand: true,
              ),
              // const Padding(
              //   padding: EdgeInsets.all(16),
              //   child: ThemeModeButton.outlined(),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}

class _NavigationRail extends ConsumerStatefulWidget {
  const _NavigationRail({required this.navigationShell, required this.expand});

  final StatefulNavigationShell navigationShell;
  final bool expand;

  @override
  ConsumerState<_NavigationRail> createState() => _NavigationRailState();
}

class _NavigationRailState extends ConsumerState<_NavigationRail> {


  String location = "";
  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    final RouteMatch lastMatch = ref
        .read(routerProvider)
        .routerDelegate
        .currentConfiguration
        .last;
    final RouteMatchList matchList = lastMatch is ImperativeRouteMatch
        ? lastMatch.matches
        : ref
        .read(routerProvider)
        .routerDelegate
        .currentConfiguration;
    print('location: $location');
    setState(() {
      location = matchList.uri.toString();
    });
    super.didChangeDependencies();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Flexible(
      fit: FlexFit.loose,
      child: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.sizeOf(context).height + 250,
          child: NavigationRail(
            extended: true,
            selectedIndex: widget.navigationShell.currentIndex,
            unselectedLabelTextStyle: theme.textTheme.bodyMedium,
            selectedLabelTextStyle: theme.textTheme.bodyMedium!.copyWith(
              fontWeight: FontWeight.bold,
            ),
            onDestinationSelected: (index) {
              widget.navigationShell.goBranch(
                index,
                initialLocation: index == widget.navigationShell.currentIndex,
              );
            },
            destinations: [
              for (final item in navItems)
                NavigationRailDestination(
                  icon: item.icon,
                  label: Text(
                    item.labelText,
                    style: theme.textTheme.bodySmall,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ScaffoldWithNavigationBar extends StatefulWidget {
  const _ScaffoldWithNavigationBar(this.navigationShell);

  final StatefulNavigationShell navigationShell;

  @override
  State<_ScaffoldWithNavigationBar> createState() => _ScaffoldWithNavigationBarState();
}

class _ScaffoldWithNavigationBarState extends State<_ScaffoldWithNavigationBar> {


  void _goBranch(int index) {
    try {
      if (kDebugMode) {
        print('the selected index: $index');
      }
      if (kDebugMode) {
        print('the selected index: ${widget.navigationShell.route.branches}');
      }
      widget.navigationShell.goBranch(
        index,
        // A common pattern when using bottom navigation bars is to support
        // navigating to the initial location when tapping the item that is
        // already active. This example demonstrates how to support this behavior,
        // using the initialLocation parameter of goBranch.
        initialLocation: index == widget.navigationShell.currentIndex,
      );
      setState(() {});
      if (kDebugMode) {
        print('go branch done ${widget.navigationShell.currentIndex}');
      }
    } catch (e, s) {
      if (kDebugMode) {
        print(e);
      }
      if (kDebugMode) {
        print(s);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      drawer: const AppDrawer(),
      // appBar: const NavigationAppBar(),
      body: widget.navigationShell,
      bottomNavigationBar:BottomAppBar(
        padding: const EdgeInsets.symmetric(horizontal: 0),
        color: Theme.of(context).colorScheme.surface,
        shape: const CircularNotchedRectangle(),
        notchMargin: 0.1,
        // notchMargin: 0.3.sp, // Margin for notch
        child: SizedBox(
          height: kToolbarHeight + 50, // Increased height for the label
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(3, (index) {
              return Expanded(
                child: InkWell(
                  onTap: () async {
                    _goBranch(index);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        getIconForIndex(
                          index,
                          widget.navigationShell.currentIndex,
                        ),
                        getLabelForIndex(index,widget.navigationShell.currentIndex,)
                      ],
                    ),
                  ),
                )
              );
            }),
          ),
        ),
      ),
    );
  }

  Widget getIconForIndex(int index, int currentIndex) {
    IconData iconData;
    Color color = Theme.of(context).colorScheme.onSurfaceVariant;
    
    switch (index) {
      case 0:
        iconData = Icons.home_outlined;
        if (currentIndex == 0) {
          color = Theme.of(context).colorScheme.primary;
        }
        break;
      case 1:
        iconData = Icons.calculate_outlined;
        if (currentIndex == 1) {
          color = Theme.of(context).colorScheme.primary;
        }
        break;
      case 2:
        iconData = Icons.person_outline;
        if (currentIndex == 2) {
          color = Theme.of(context).colorScheme.primary;
        }
        break;
      default:
        iconData = Icons.home_outlined;
        color = Theme.of(context).colorScheme.primary;
    }
    
    return Padding(
      padding: const EdgeInsets.only(bottom: 5.0),
      child: Icon(
        iconData,
        color: color,
      ),
    );
  }

  Widget getLabelForIndex(int index, int currentIndex) {
    String text = '';
    Color color = Theme.of(context).colorScheme.onSurfaceVariant;
    
    switch (index) {
      case 0:
        text = 'Home';
        break;
      case 1:
        text = 'Calculator';
        break;
      case 2:
        text = 'Profile';
        break;
      default:
        text = '';
    }
    
    if (index == currentIndex) {
      color = Theme.of(context).colorScheme.primary;
    }
    
    return Text(
      text,
      textAlign: TextAlign.center,
      style: Theme.of(context).textTheme.labelSmall!.copyWith(
        color: color,
        fontWeight: index == currentIndex ? FontWeight.w600 : FontWeight.normal,
      ),
    );
  }

}
