import 'package:bond/core/app_localizations.dart';
import 'package:bond/core/resources/app_icons.dart';
import 'package:bond_core/bond_core.dart';
import 'package:material_ui/material_ui.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:share_plus/share_plus.dart';

class ShareButton extends StatelessWidget {
  const ShareButton({
    required this.postImageUrl,
    super.key,
  });

  final String postImageUrl;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      splashRadius: 20,
      onPressed: () => _onShare(context),
      icon: SvgPicture.asset(
        AppIcons.share,
        colorFilter: ColorFilter.mode(
          context.colorScheme.primary,
          BlendMode.srcIn,
        ),
      ),
    );
  }

  void _onShare(BuildContext context) {
    // iPad anchors the share sheet to this rect.
    final box = context.findRenderObject() as RenderBox?;
    SharePlus.instance.share(
      ShareParams(
        text: postImageUrl,
        subject: context.localizations.share_post_image,
        sharePositionOrigin:
            box == null ? null : box.localToGlobal(Offset.zero) & box.size,
      ),
    );
  }
}
