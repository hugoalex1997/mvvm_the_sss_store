import 'package:flutter/material.dart';
import 'package:the_sss_store/navigation/app_route.dart';
import 'package:the_sss_store/screen/login/login_data.dart';
import 'package:the_sss_store/screen/login/login_view_model.dart';
import 'package:the_sss_store/screen/home/home_screen.dart';
import 'package:the_sss_store/screen/screen.dart';

class LoginScreenRoute extends AppRoute {
  LoginScreenRoute()
      : super(
          path: '/',
          builder: (context, state) => LoginScreen(key: state.pageKey),
        );
}

class LoginScreen extends Screen {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState
    extends ScreenState<LoginScreen, LoginViewModel, LoginData> {
  late TextEditingController _usernameController;
  late TextEditingController _passwordController;

  @override
  void initState() {
    super.initState();
    _usernameController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget buildScreen(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _LoginUserNameInput(controller: _usernameController),
            const SizedBox(height: 16),
            _LoginPasswordInput(controller: _passwordController),
            const SizedBox(height: 16),
            MaterialButton(
              child: const _LoginButtonChild(),
              color: Theme.of(context).colorScheme.primary,
              textTheme: ButtonTextTheme.primary,
              onPressed: _onLoginTap,
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _onLoginTap() async {
    final login = await viewModel.login(_usernameController.text, _passwordController.text);

    if (!login) {
      return;
    }

    HomeScreenRoute().push(context);
  }
}

class _LoginUserNameInput extends StatelessWidget {
  const _LoginUserNameInput({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: const InputDecoration(
        label: Text('Nome de Utilizador'),
      ),
    );
  }
}

class _LoginPasswordInput extends StatelessWidget {
  const _LoginPasswordInput({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: const InputDecoration(
        label: Text('Password'),
      ),
    );
  }
}

class _LoginButtonChild extends StatelessWidget {
  const _LoginButtonChild({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Text('Sign In');
  }
}
