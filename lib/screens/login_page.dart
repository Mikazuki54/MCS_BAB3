import 'package:bab3/model/app_style.dart';
import 'package:bab3/provider/app_provider.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passController = TextEditingController();
  final AppStyles appStyles = AppStyles();

  Future<void> validationForm() async {
    if (formKey.currentState?.validate() != true) {
      return;
    }

    try {
      await context.read<AppProvider>().loginToApp(
        usernameController.text,
        passController.text,
      );
    } catch (e) {
      if (!mounted) {
        return;
      }
      showDialog<void>(
        context: context,
        builder: (builder) {
          return AlertDialog(
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Login Failed"),
                const SizedBox(width: 10),
                LottieBuilder.asset(
                  height: MediaQuery.of(context).size.width / 6,
                  width: MediaQuery.of(context).size.width / 6,
                  "assets/lottie_failed_animations.json",
                  repeat: true,
                ),
              ],
            ),
            content: const Text(
              "Silahkan Masukkan Username dan Password yang Benar",
              textAlign: TextAlign.center,
            ),
          );
        },
      );
    }
  }

  // METHOD RESET FIELD FORM
  void resetForm() {
    usernameController.clear();
    passController.clear();
    formKey.currentState?.reset();
    setState(() {});
  }

  // Wajib ditambahkan: Menghancurkan controller saat berpindah layar
  @override
  void dispose() {
    usernameController.dispose();
    passController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appStyles.backgroundColor,
      appBar: AppBar(
        backgroundColor: appStyles.backgroundColor,
        title: Text("Authentication Apps", style: appStyles.titleFontstyle),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              decoration: BoxDecoration(
                border: BoxBorder.all(color: Colors.black),
                borderRadius: BorderRadius.circular(20),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.3),
                    blurRadius: 7,
                    offset: const Offset(0, 15),
                  ),
                ],
              ),
              child: Padding(
                padding: EdgeInsets.all(15),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Form(
                      key: formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Email", style: appStyles.universalFontStyle),
                          SizedBox(height: 10),
                          TextFormField(
                            controller: usernameController,
                            keyboardType: TextInputType.emailAddress,
                            style: appStyles.universalFontStyle,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              hintText: appStyles.hintUsernameText,
                              hintStyle: appStyles.hintTextFontStyle,
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: BorderSide(color: Colors.black),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: BorderSide(color: Colors.black),
                              ),
                              prefixIcon: Icon(
                                Icons.mail_outline,
                                color: appStyles.iconColor,
                              ),
                            ),
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Harap Isi Kolom username";
                              }
                              RegExp emailFormat = RegExp(
                                r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                              );
                              if (emailFormat.hasMatch(value)) {
                                return null;
                              }
                              return 'Harap masukkan E-MAIL sesuai dengan format';
                            },
                          ),

                          SizedBox(height: 20),
                          Text("Password", style: appStyles.universalFontStyle),
                          TextFormField(
                            controller: passController,
                            obscureText: appStyles.visibilityIcon
                                ? true
                                : false,
                            style: appStyles.universalFontStyle,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              hintText: appStyles.hintPassText,
                              hintStyle: appStyles.hintTextFontStyle,
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: BorderSide(color: Colors.black),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: BorderSide(color: Colors.black),
                              ),
                              prefix: Icon(Icons.lock_outline),
                              prefixIconColor: appStyles.iconColor,
                              suffixIcon: GestureDetector(
                                child: appStyles.visibilityIcon
                                    ? Icon(
                                        Icons.visibility_off,
                                        color: appStyles.iconColor,
                                      )
                                    : Icon(
                                        Icons.visibility,
                                        color: appStyles.iconColor,
                                      ),
                                onTap: () {
                                  setState(() {
                                    appStyles.visibilityIcon =
                                        !appStyles.visibilityIcon;
                                  });
                                },
                              ),
                            ),
                            autovalidateMode: AutovalidateMode.onUnfocus,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Harap mengisikan kolom password";
                              }
                              return null;
                            },
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 70),
                    GestureDetector(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.green[600],
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 40,
                            vertical: 10,
                          ),
                          child: Text(
                            appStyles.loginButtonText,
                            style: appStyles.buttonFontStyle,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      onTap: () {
                        validationForm();
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
