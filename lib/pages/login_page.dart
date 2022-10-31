import 'package:flame/actions/auth_state_action.dart';
import 'package:flame/extensions/color_extension.dart';
import 'package:flame/services/account_service.dart';
import 'package:flame/states/app_state.dart';
import 'package:flame/states/auth_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

typedef OnAuthStateCallback = void Function(AuthState authState);

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _accountService = AccountService();

  String? _login;
  String? _password;
  bool isLoading = false;
  bool isFetchSuccess = false;

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, OnAuthStateCallback>(
        converter: (Store<AppState> store) {
      return (data) {
        store.dispatch(AuthStateAction(authState: data));
      };
    }, builder: (BuildContext context, OnAuthStateCallback authStateCallback) {
      return Padding(
        padding: const EdgeInsets.all(30),
        child: Center(
          child: SafeArea(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  CircleAvatar(
                    maxRadius: 40,
                    backgroundColor: Colors.transparent,
                    child: Image.asset('/images/logo.png'),
                  ),
                  const SizedBox(height: 30),
                  TextFormField(
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: HexColor("#EEEEEE"),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(
                            width: 0,
                            style: BorderStyle.none,
                          ),
                        ),
                        contentPadding: const EdgeInsets.only(
                            left: 14.0, bottom: 8.0, top: 8.0),
                        hintText: 'Enter your login',
                        labelText: "Login",
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your login';
                        }

                        return null;
                      },
                      onChanged: (value) {
                        setState(() {
                          _login = value;
                        });
                      }),
                  const SizedBox(height: 10),
                  TextFormField(
                    obscureText: true,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: HexColor("#EEEEEE"),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(
                          width: 0,
                          style: BorderStyle.none,
                        ),
                      ),
                      contentPadding: const EdgeInsets.only(
                          left: 14.0, bottom: 8.0, top: 8.0),
                      labelText: 'Password',
                      hintText: 'Enter your password',
                    ),
                    onChanged: (value) {
                      setState(() {
                        _password = value;
                      });
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your password';
                      }

                      return null;
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: Padding(
                      padding: const EdgeInsets.all(0),
                      child: ButtonTheme(
                        height: 60.0,
                        child: CupertinoButton(
                          color: Colors.blueGrey,
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              try {
                                setState(() {
                                  isLoading = true;
                                });

                                final account = await _accountService.login(
                                    _login ?? '', _password ?? '');
                                authStateCallback(AuthState(account, false));

                                setState(() {
                                  isLoading = false;
                                });
                              } catch (e) {
                                print("Error $e");
                              }
                            }
                          },
                          child: !isLoading
                              ? const Text('Login')
                              : const CircularProgressIndicator(),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
