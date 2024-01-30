import 'package:flutter/material.dart';
import 'package:for_dev/ui/components/components.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

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
                    TextFormField(
                      decoration: const InputDecoration(
                          labelText: 'Email',
                          icon: Icon(Icons.email),
                          focusColor: Colors.yellow,
                          hintStyle: TextStyle(
                            color: Colors.yellow,
                          )),
                      keyboardType: TextInputType.emailAddress,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8, bottom: 32),
                      child: TextFormField(
                        decoration: const InputDecoration(
                          labelText: 'Senha',
                          icon: Icon(Icons.lock),
                        ),
                        obscureText: true,
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {},
                      child: const Text('ENTRAR'),
                    ),
                    TextButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.person),
                      label: const Text('Criar Conta'),
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
