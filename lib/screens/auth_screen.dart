// ignore_for_file: constant_identifier_names, prefer_final_fields

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

enum AuthMode { Login, Register }

class _AuthScreenState extends State<AuthScreen> {
  GlobalKey<FormState> _formKey = GlobalKey();
  var _loading = false;

  AuthMode _authMode = AuthMode.Login;

  Map<String, String> _authData = {
    'email': '',
    'password': '',
  };

  final _controller = TextEditingController();

  void _switchAuthMode() {
    if (_authMode == AuthMode.Login) {
      setState(() {
        _authMode = AuthMode.Register;
      });
    } else {
      setState(() {
        _authMode = AuthMode.Login;
      });
    }
  }

  // ignore: unused_element
  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text("Xatolik:"),
        content: Text(message),
        actions: [
          ElevatedButton(
            onPressed: () {
              Navigator.of(ctx).pop();
            },
            child: const Text("ok"),
          ),
        ],
      ),
    );
  }

  Future<void> _submit() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
    }
    //   setState(() {
    //     _loading = true;
    //   });
    //   try {
    //     if (_authMode == AuthMode.Login) {
    //       await Provider.of<Auth>(context, listen: false)
    //           .signIn(_authData['email']!, _authData['password']!);
    //       // ...
    //     } else {
    //       await Provider.of<Auth>(context, listen: false)
    //           .signUp(_authData['email']!, _authData['password']!);
    //     }
    //   } on HttpException catch (error) {
    //     var errorMessage = "Xatol mavjud";
    //     if (error.message.contains('EMAIL_EXISTS')) {
    //       errorMessage = "Bu email ishlatilinmoqda!";
    //     } else if (error.message.contains('EMAIL_NOT_FOUND')) {
    //       errorMessage = "Email topilmadi";
    //     } else if (error.message.contains('INVALID_PASSWORD')) {
    //       errorMessage = 'Parol xaro';
    //     } else if (error.message.contains('USER_DISABLED')) {
    //       errorMessage = 'Foydalanuvchi bloklangan';
    //     } else if (error.message.contains('INVALID_LOGIN_CREDENTIALS')) {
    //       errorMessage = 'Email yoki parol xato!';
    //     }
    //     _showErrorDialog(errorMessage);
    //   } catch (e) {
    //     var errorMessage = "Xatolik bor qayta urining!";
    //     _showErrorDialog(errorMessage);
    //   }
    //   setState(() {
    //     _loading = false;
    //   });
    // }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 20),
                  Center(
                    child: Image.asset(
                      "assets/img.png",
                      width: 150,
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    decoration: const InputDecoration(
                      label: Text("Email manzili"),
                    ),
                    validator: (email) {
                      if (email == null || email.isEmpty) {
                        return "Iltimos email kiriting!";
                      } else if (!email.contains("@") || !email.contains(".")) {
                        return "Email xato!";
                      }
                      return null;
                    },
                    onSaved: (newValue) {
                      _authData['email'] = newValue!;
                    },
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    decoration: const InputDecoration(
                      label: Text("Parol"),
                    ),
                    obscureText: true,
                    controller: _controller,
                    validator: (parol) {
                      if (parol == null || parol.isEmpty) {
                        return "Iltimos parol kiriting!";
                      } else if (parol.length < 6) {
                        return "Parol juda qisqa! Kamida 6 ta belgi bo'lishi shar.";
                      }
                      return null;
                    },
                    onSaved: (newValue) {
                      _authData['password'] = newValue!;
                    },
                  ),
                  if (_authMode == AuthMode.Register)
                    Column(
                      children: [
                        const SizedBox(height: 20),
                        TextFormField(
                          decoration: const InputDecoration(
                            label: Text("Parol"),
                          ),
                          obscureText: true,
                          validator: (parol) {
                            if (parol == null || parol.isEmpty) {
                              return 'Parol kiriting!';
                            } else if (_controller.text != parol) {
                              return "Parolar bir-biriga mos kelmadi!";
                            }
                            return null;
                          },
                        ),
                      ],
                    ),
                  const SizedBox(height: 60),
                  _loading
                      ? const Center(
                          child: CupertinoActivityIndicator(
                            color: CupertinoColors.activeBlue,
                            radius: 20,
                          ),
                        )
                      : ElevatedButton(
                          onPressed: _submit,
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(
                              vertical: 20,
                            ),
                            shape: const RoundedRectangleBorder(),
                          ),
                          child: _authMode == AuthMode.Login
                              ? const Text("KIRISH")
                              : const Text("RO'YXATDAN O'TISH"),
                        ),
                  const SizedBox(height: 30),
                  TextButton(
                    onPressed: _switchAuthMode,
                    child: Text(
                      _authMode == AuthMode.Login
                          ? 'Ro\'yxatdan o\'tish'
                          : 'Kirish',
                      style: TextStyle(
                        color: Colors.grey.shade600,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
