import 'package:bond/core/app_localizations.dart';
import 'package:bond/core/resources/app_assets.dart';
import 'package:bond/core/resources/app_icons.dart';
import 'package:bond/core/widgets/app_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:open_store/open_store.dart';

class SoftUpdatePage extends StatelessWidget {
  const SoftUpdatePage({super.key, required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 20,
        ),
        child: Stack(
          children: [
            Positioned(
              top: 0,
              right: 0,
              child: IconButton(
                onPressed: () => context.pop(),
                icon: SvgPicture.asset(
                  AppIcons.close,
                  colorFilter: ColorFilter.mode(
                    Colors.grey,
                    BlendMode.srcIn,
                  ),
                  width: 14,
                  height: 14,
                ),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(
                  AppImagesAssets.forceUpdate,
                  width: 104,
                  height: 104,
                ),
                const SizedBox(height: 32),
                Text(
                  context.localizations.update_app,
                ),
                const SizedBox(height: 12),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 87.0),
                  child: Text(
                    message,
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 32),
                AppButton(
                  title: context.localizations.update_app_now,
                  onPressed: onUpdate,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void onUpdate() {
    // //TODO:: CHANGE appStoreId
    OpenStore.instance.open(
      appStoreId: '6444267986',
      androidAppBundleId: 'ps.app.bond',
    );
  }
}
