import 'package:bond/core/app_localizations.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:bond_core/bond_core.dart';
import 'package:go_router/go_router.dart';

class NewAccountView extends StatelessWidget {
  const NewAccountView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: 56,
      child: RichText(
        strutStyle: StrutStyle.fromTextStyle(
          context.textTheme.labelLarge!,
        ),
        text: TextSpan(
          children: [
            TextSpan(
              text: context.localizations.login_page_not_have_account,
              style: context.textTheme.bodySmall,
            ),
            TextSpan(
              recognizer: TapGestureRecognizer()
                ..onTap = () => context.push('/register'),
              text: context.localizations.login_page_new_account_button,
              style: context.textTheme.labelSmall,
            ),
          ],
        ),
      ),
    );
  }
}
