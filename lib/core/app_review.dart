import 'package:in_app_review/in_app_review.dart';

class AppReviewHelper {
  // TODO: replace with your app's App Store id. Android opens the Play Store
  // listing of the running package, so it needs no id.
  static const String appStoreId = '6444267986';

  static Future<bool> showAppReview() async {
    bool isAvailable = await InAppReview.instance.isAvailable();
    if (isAvailable) {
      await InAppReview.instance.requestReview();
      return true;
    } else {
      return false;
    }
  }

  static Future<void> openStoreListing() =>
      InAppReview.instance.openStoreListing(appStoreId: appStoreId);
}
