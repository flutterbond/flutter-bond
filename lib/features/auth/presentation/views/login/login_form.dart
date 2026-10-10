import 'package:bond/app/routes.dart';
import 'package:bond/core/app_localizations.dart';
import 'package:bond/core/app_widgets.dart';
import 'package:bond/core/resources/app_keys.dart';
import 'package:bond/features/auth/auth.dart';
import 'package:bond/features/auth/presentation/providers/login_form_provider.dart';
import 'package:bond_form/bond_form.dart';
import 'package:material_ui/material_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginForm extends ConsumerWidget {
  const LoginForm({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formController = ref.read(loginProvider.notifier);
    final formState = ref.watch(loginProvider);
    ref.listen(
      loginProvider,
      (previous, next) => _formStateListener(context, previous, next),
    );
    return Column(
      children: [
        TextFormField(
          key: AppKeys.loginEmailField,
          keyboardType: TextInputType.emailAddress,
          onChanged: (value) => formController.updateText('email', value),
          decoration: InputDecoration(
            labelText: formState.label('email'),
            errorText: formState.error('email'),
            prefixIcon: const Icon(Icons.email),
          ),
        ),
        const SizedBox(height: 12),
        TextFormField(
          key: AppKeys.loginPasswordField,
          keyboardType: TextInputType.text,
          onChanged: (value) => formController.updateText('password', value),
          decoration: InputDecoration(
            labelText: formState.label('password'),
            errorText: formState.error('password'),
            prefixIcon: const Icon(Icons.lock),
          ),
        ),
        const SizedBox(height: 16),
        AppButton(
          key: AppKeys.loginSubmitButton,
          onPressed: ref.read(loginProvider.notifier).submit,
          title: context.localizations.login_page_login_button,
          loading: formState.status == BondFormStateStatus.submitting,
        ),
      ],
    );
  }

  void _formStateListener(
    BuildContext context,
    BondFormState<User, Error>? previous,
    BondFormState<User, Error> next,
  ) {
    switch (next.status) {
      case BondFormStateStatus.submitted:
        goRouter.replace('/home');
        break;
      case BondFormStateStatus.failed:
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(next.failure.toString()),
            backgroundColor: Colors.red,
          ),
        );
        break;
      default:
        break;
    }
  }
}
