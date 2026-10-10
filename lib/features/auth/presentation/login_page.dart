import 'package:bond/core/app_localizations.dart';
import 'package:bond/core/resources/app_assets.dart';
import 'package:bond/core/widgets/bond_pop_menu/bond_pop_menu_button.dart';
import 'package:bond/features/auth/presentation/views/login/login_form.dart';
import 'package:material_ui/material_ui.dart';
import 'package:flutter_svg/svg.dart';

import 'views/login/new_account_view.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.localizations.login_page_title),
        actions: const [BondPopMenuButton()],
      ),
      body: SingleChildScrollView(
        child: AutofillGroup(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 64),
                  SvgPicture.asset(
                    AppImagesAssets.logo,
                    width: 95,
                    height: 120,
                  ),
                  const SizedBox(height: 48),
                  const LoginForm(),
                  const SizedBox(height: 16),
                  const NewAccountView(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
