import 'package:bond/core/app_localizations.dart';
import 'package:bond/core/app_review.dart';
import 'package:bond/core/app_widgets.dart';
import 'package:bond/core/resources/app_assets.dart';
import 'package:bond/core/resources/app_keys.dart';
import 'package:material_ui/material_ui.dart';

class UpdateAppPage extends StatelessWidget {
  final String message;

  const UpdateAppPage({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: AppKeys.updateAppPage,
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
                      key: AppKeys.updateAppMessage,
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

  void _onUpdate() => AppReviewHelper.openStoreListing();
}
