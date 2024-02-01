import 'package:flutter/material.dart';
import 'package:for_dev/ui/components/components.dart';
import 'package:for_dev/ui/pages/pages.dart';

class LoginPage extends StatelessWidget {
  final LoginPresenter presenter;

  const LoginPage({super.key, required this.presenter});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const LoginHeader(),
            const Headline1(
              text: 'Login',
            ),
            Padding(
              padding: const EdgeInsets.all(32),
              child: Form(
                child: Column(
                  children: [
                    StreamBuilder<String?>(
                        stream: presenter.emailErrorStream,
                        builder: (context, snapshot) {
                          return TextFormField(
                            decoration: InputDecoration(
                              labelText: 'Email',
                              icon: const Icon(Icons.email),
                              focusColor: Colors.yellow,
                              hintStyle: const TextStyle(
                                color: Colors.yellow,
                              ),
                              errorText: snapshot.data,
                            ),
                            onChanged: presenter.validateEmail,
                            keyboardType: TextInputType.emailAddress,
                          );
                        }),
                    Padding(
                      padding: const EdgeInsets.only(top: 8, bottom: 32),
                      child: TextFormField(
                        decoration: const InputDecoration(
                          labelText: 'Password',
                          icon: Icon(Icons.lock),
                        ),
                        onChanged: presenter.validatePassword,
                        obscureText: true,
                      ),
                    ),
                    const ElevatedButton(
                      onPressed: null,
                      child: Text('Login'),
                    ),
                    TextButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.person),
                      label: const Text('Register'),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
