import 'package:bond/core/app_widgets.dart';
import 'package:bond/core/resources/app_assets.dart';
import 'package:flutter/material.dart';

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  const HomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: false,
      title: Image.asset(
        AppImagesAssets.homeBond(
          Theme.of(context).brightness,
          Localizations.localeOf(context).languageCode,
        ),
        width: 90,
      ),
      actions: const [
        BondPopMenuButton(),
      ],
      bottom: const PreferredSize(
        preferredSize: Size.fromHeight(4),
        child: Divider(
          height: 0.5,
          color: Colors.grey,
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 4);
}
