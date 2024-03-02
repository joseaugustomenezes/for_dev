import 'dart:async';

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
  late StreamController<String?> emailErrorController;
  late StreamController<String?> passwordErrorController;
  late StreamController<bool> isFormValidController;

  Future<void> loadPage(WidgetTester tester) async {
    presenter = MockLoginPresenter();
    emailErrorController = StreamController<String?>();
    passwordErrorController = StreamController<String?>();
    isFormValidController = StreamController<bool>();
    when(presenter.emailErrorStream)
        .thenAnswer((_) => emailErrorController.stream);
    when(presenter.passwordErrorStream)
        .thenAnswer((_) => passwordErrorController.stream);
    when(presenter.isFormValidStream)
        .thenAnswer((_) => isFormValidController.stream);
    final loginPage = MaterialApp(home: LoginPage(presenter: presenter));
    await tester.pumpWidget(loginPage);
  }

  tearDown(() {
    emailErrorController.close();
  });

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

  testWidgets('Should present error if email is invalid', (tester) async {
    await loadPage(tester);

    emailErrorController.add('any error');
    await tester.pump();

    expect(find.text('any error'), findsOneWidget);
  });

  testWidgets('Should present no error if email is valid', (tester) async {
    await loadPage(tester);

    emailErrorController.add(null);
    await tester.pump();

    final emailTextField = tester.widget<TextField>(find.byWidgetPredicate(
        (widget) =>
            widget is TextField && widget.decoration!.labelText == 'Email'));

    expect(emailTextField.decoration!.errorText, isNull);
  });

  testWidgets('Should present error if password is invalid', (tester) async {
    await loadPage(tester);

    passwordErrorController.add('any error');
    await tester.pump();

    expect(find.text('any error'), findsOneWidget);
  });

  testWidgets('Should present no error if password is valid', (tester) async {
    await loadPage(tester);

    passwordErrorController.add(null);
    await tester.pump();

    final passwordTextField = tester.widget<TextField>(find.byWidgetPredicate(
        (widget) =>
            widget is TextField && widget.decoration!.labelText == 'Password'));

    expect(passwordTextField.decoration!.errorText, isNull);
  });

  testWidgets('Should enable button if form is valid', (tester) async {
    await loadPage(tester);

    isFormValidController.add(true);
    await tester.pump();

    final loginButton =
        tester.widget<ElevatedButton>(find.byType(ElevatedButton));
    expect(loginButton.onPressed, isNotNull);
  });
}
