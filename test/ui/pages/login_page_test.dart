import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:for_dev/ui/pages/login_page.dart';

void main() {
  Future<void> loadPage(WidgetTester tester) async {
    const loginPage = MaterialApp(home: LoginPage());
    await tester.pumpWidget(loginPage);
  }

  testWidgets('Should load with correct initial value', (tester) async {
    await loadPage(tester);

    final emailTextField = tester.widget<TextField>(find.byWidgetPredicate(
        (widget) =>
            widget is TextField && widget.decoration!.labelText == 'Email'));

    expect(emailTextField.decoration!.errorText, isNull);

    final passwordTextField = tester.widget<TextField>(find.byWidgetPredicate(
        (widget) =>
            widget is TextField && widget.decoration!.labelText == 'Password'));

    expect(passwordTextField.decoration!.errorText, isNull);

    final loginButton =
        tester.widget<ElevatedButton>(find.byType(ElevatedButton));
    expect(loginButton.onPressed, isNull);

    // final registerButton = tester.widget<TextButton>(
    //     find.byWidgetPredicate((widget) => widget is TextButton));
    // expect(registerButton.onPressed, isNull);
  });

  testWidgets('Should call validate with correct values', (tester) async {
    await loadPage(tester);
  });
}
