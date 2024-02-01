import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:for_dev/ui/pages/login/login_page.dart';
import 'package:for_dev/ui/pages/login/login_presenter.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

@GenerateNiceMocks([MockSpec<LoginPresenter>()])
import 'login_page_test.mocks.dart';

void main() {
  late LoginPresenter presenter;

  Future<void> loadPage(WidgetTester tester) async {
    presenter = MockLoginPresenter();
    final loginPage = MaterialApp(home: LoginPage(presenter: presenter));
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

    final email = faker.internet.email();
    final emailFinder = find.byWidgetPredicate((widget) =>
        widget is TextField && widget.decoration!.labelText == 'Email');

    final password = faker.internet.password();
    final passwordFinder = find.byWidgetPredicate((widget) =>
        widget is TextField && widget.decoration!.labelText == 'Password');

    await tester.enterText(emailFinder, email);
    await tester.enterText(passwordFinder, password);

    verify(presenter.validateEmail(email));
    verify(presenter.validatePassword(password));
  });
}
