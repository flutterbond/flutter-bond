import 'package:bond/core/app_localizations.dart';
import 'package:bond/core/app_widgets.dart';
import 'package:bond/core/resources/app_assets.dart';
import 'package:flutter/material.dart';
import 'package:open_store/open_store.dart';

class UpdateAppPage extends StatelessWidget {
  final String message;

  const UpdateAppPage({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Image.asset(
                AppImagesAssets.forceUpdate,
              ),
              const SizedBox(
                height: 16,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    context.localizations.update_app,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 87.0),
                    child: Text(
                      message,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(
                    height: 29,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: AppButton(
                      title: context.localizations.update_app_now,
                      onPressed: _onUpdate,
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _onUpdate() {
    //TODO::CHANGE appStoreId
    OpenStore.instance.open(
      appStoreId: '6444267986',
      androidAppBundleId: 'ps.app.bond',
    );
  }
}
