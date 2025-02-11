import 'package:bond/core/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MainPage extends StatelessWidget {
  const MainPage({
    super.key,
    required this.body,
  });

  final StatefulNavigationShell body;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: body,
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          border: Border(
            top: BorderSide(
              color: Colors.grey,
              width: 0.5,
            ),
          ),
        ),
        child: BottomNavigationBar(
          currentIndex: body.currentIndex,
          onTap: body.goBranch,
          items: [
            BottomNavigationBarItem(
              icon: const Icon(Icons.home),
              label: context.localizations.navigation_bar_home,
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.collections),
              label: context.localizations.navigation_bar_collections,
            ),
          ],
        ),
      ),
    );
  }
}
