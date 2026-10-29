import 'package:bab3/provider/app_provider.dart';
import 'package:bab3/utils/app_style.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final formKey = GlobalKey<FormState>();
  final usernameController = TextEditingController();
  final passController = TextEditingController();
  final appStyles = AppStyles();

  InputDecoration _inputDecoration(String hint, IconData icon, [Widget? suffix]) {
    final border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(15),
      borderSide: const BorderSide(color: Colors.black),
    );
    return InputDecoration(
      hintText: hint,
      hintStyle: appStyles.hintTextFontStyle,
      prefixIcon: Icon(icon, color: appStyles.iconColor),
      suffixIcon: suffix,
      border: border,
      enabledBorder: border,
      focusedBorder: border,
    );
  }

  Future<void> validationForm() async {
    if (formKey.currentState?.validate() != true) return;

    try {
      await context.read<AppProvider>().loginToApp(
            usernameController.text,
            passController.text,
          );
    } catch (_) {
      if (!mounted) return;
      final size = MediaQuery.of(context).size.width / 6;
      showDialog<void>(
        context: context,
        builder: (_) => AlertDialog(
          title: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text("Login Failed"),
              LottieBuilder.asset(
                "assets/lottie_failed_animations.json",
                width: size,
                height: size,
              ),
            ],
          ),
          content: const Text(
            "Silahkan Masukkan Username dan Password yang Benar",
            textAlign: TextAlign.center,
          ),
        ),
      );
    }
  }

  void resetForm() {
    usernameController.clear();
    passController.clear();
    formKey.currentState?.reset();
    setState(() {});
  }

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
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black),
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
              child: Form(
                key: formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Email", style: appStyles.universalFontStyle),
                    const SizedBox(height: 10),
                    TextFormField(
                      controller: usernameController,
                      keyboardType: TextInputType.emailAddress,
                      style: appStyles.universalFontStyle,
                      decoration: _inputDecoration(
                        appStyles.hintUsernameText,
                        Icons.mail_outline,
                      ),
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Harap Isi Kolom username";
                        }
                        return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                                .hasMatch(value)
                            ? null
                            : 'Harap masukkan E-MAIL sesuai dengan format';
                      },
                    ),
                    const SizedBox(height: 20),
                    Text("Password", style: appStyles.universalFontStyle),
                    TextFormField(
                      controller: passController,
                      obscureText: appStyles.visibilityIcon,
                      style: appStyles.universalFontStyle,
                      decoration: _inputDecoration(
                        appStyles.hintPassText,
                        Icons.lock_outline,
                        GestureDetector(
                          onTap: () => setState(
                            () => appStyles.visibilityIcon =
                                !appStyles.visibilityIcon,
                          ),
                          child: Icon(
                            appStyles.visibilityIcon
                                ? Icons.visibility_off
                                : Icons.visibility,
                            color: appStyles.iconColor,
                          ),
                        ),
                      ),
                      autovalidateMode: AutovalidateMode.onUnfocus,
                      validator: (value) => (value == null || value.isEmpty)
                          ? "Harap mengisikan kolom password"
                          : null,
                    ),
                    const SizedBox(height: 70),
                    Center(
                      child: GestureDetector(
                        onTap: validationForm,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 40,
                            vertical: 10,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.green[600],
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            appStyles.loginButtonText,
                            style: appStyles.buttonFontStyle,
                          ),
                        ),
                      ),
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
