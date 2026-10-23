import 'package:bab3/provider/app_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const new({super.key});

  @override
  State <LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State <LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Consumer<AppProvider>(
      builder: (context, appProvider, child) {
        return Scaffold(
          backgroundColor: appProvider.backgroundColor,
          appBar: AppBar(
            backgroundColor: appProvider.backgroundColor,
            title: Text(
              "Authentication Apps",
              style: appProvider.titleFontStyle,
            ),
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
                        color: Colors.black.withOpacity(0.3),
                        blurRadius: 7,
                        offset: const Offset(0, 15),
                      ),
                    ]
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(15),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Form(
                          key: appProvider.formKey,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Email",
                                style: appProvider.universalFontStyle,
                              ),
                              SizedBox(height: 10),
                              TextFormField(
                                controller: appProvider.usernameController,
                                keyboardType: TextInputType.emailAddress,
                                style: appProvider.universalFontStyle,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15), 
                                  ),
                                  hintText: appProvider.hintUsernameText,
                                  hintStyle: appProvider.hintTextFontStyle,
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
                                    color: appProvider.iconColor,
                                  ),
                                ),
                                autovalidateMode: 
                                    AutovalidateMode.onUserInteraction,
                                validator: (value){
                                  if (value!.isEmpty){
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
                              Text(
                                "Password",
                                style: appProvider.universalFontStyle,
                              ),
                              TextFormField(
                                controller: appProvider.passController,
                                obscureText: appProvider.visibiliyIcon == true
                                    ? true
                                    : false,
                                style: appProvider.universalFontStyle,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  hintText: appProvider.hintUsernameText,
                                  hintStyle: appProvider.hintTextFontStyle,
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15),
                                    borderSide: BorderSide(color: Colors.black),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15),
                                    borderSide: BorderSide(color: Colors.black),
                                  ),
                                  prefix: Icon(Icons.lock_outline),
                                  prefixIconColor: appProvider.iconColor,
                                  suffixIcon: GestureDetector(
                                    child: appProvider.visibiliyIcon == true
                                        ? Icon(
                                          Icons.visibility_off,
                                          color: appProvider.iconColor,
                                        )
                                        : Icon(
                                          Icons.visibility,
                                          color: appProvider.iconColor,
                                        ),
                                    onTap: () {
                                      setState(() {
                                        appProvider.visibiliyIcon = !appProvider.visibiliyIcon;
                                      });
                                    },
                                  ),
                                ),
                                autovalidateMode: AutovalidateMode.onUnfocus,
                                validator: (value){
                                  if (value!.isEmpty){
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
                                appProvider.loginButtonText,
                                style: appProvider.buttonFontStyle,
                                textAlign: TextAlign.center,
                              ), 
                            ),
                          ),
                          onTap: () {
                            appProvider.validationForm(context);
                          },
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
            ),
        );
      }
    );
  }
}