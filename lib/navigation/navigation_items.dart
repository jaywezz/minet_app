import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NavItems {
  Widget icon;
  String labelText;

  NavItems({required this.icon, required this.labelText});
}

List<NavItems> navItems = [
  NavItems(icon: const Icon(Icons.dashboard_customize_outlined), labelText: "DashBoard"),
  // NavItems(icon: const Icon(CupertinoIcons.shopping_cart), labelText: "Pos"),
  // NavItems(icon: const Icon(CupertinoIcons.creditcard), labelText: "Expenses"),
  // NavItems(icon: const Icon(Icons.miscellaneous_services), labelText: "Service Sale"),
];

