import 'package:flutter/material.dart';

class BaseLayout extends StatelessWidget {
  final FloatingActionButton fab;
  final List<Widget> children;
  const BaseLayout({super.key, required this.children, required this.fab});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: fab,
        backgroundColor: Theme.of(context).colorScheme.surface,
        body: SafeArea(
            child: CustomScrollView(
                physics: const AlwaysScrollableScrollPhysics(
                    parent: BouncingScrollPhysics()),
                slivers: children)));
  }
}
