import 'package:auth_buttons/auth_buttons.dart';
import 'package:chat_try_3/blocs/chat_bloc/chat_cubit.dart';
import 'package:chat_try_3/screens/login_screen.dart';
import 'package:chat_try_3/screens/users_screen.dart';
import 'package:flutter/material.dart';

import '../colors.dart';
import '../widgets/textfield_widget.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    ChatCubit cubit = ChatCubit.get(context);
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            width: double.infinity,
            height: h,
            color: first,
            child: Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                Text(
                  "Register",
                  style: TextStyle(
                      color: forth, fontSize: 30, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFieldWidget(
                    secure: false,
                    controller: nameController,
                    suffixIcon: Icons.drive_file_rename_outline,
                    hintText: "Full Name",
                    keyBoardType: TextInputType.text),
                const SizedBox(
                  height: 20,
                ),
                TextFieldWidget(
                    secure: false,
                    controller: phoneController,
                    suffixIcon: Icons.phone_android,
                    hintText: "Phone",
                    keyBoardType: TextInputType.number),
                const SizedBox(
                  height: 20,
                ),
                TextFieldWidget(
                    secure: false,
                    controller: emailController,
                    suffixIcon: Icons.email_outlined,
                    hintText: "Email",
                    keyBoardType: TextInputType.emailAddress),
                const SizedBox(
                  height: 20,
                ),
                TextFieldWidget(
                    secure: true,
                    controller: passwordController,
                    suffixIcon: Icons.lock,
                    hintText: "Password",
                    keyBoardType: TextInputType.text),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                    onPressed: () {
                      cubit.pickImage("cam");
                    },
                    child: const Text("Choose Image")),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  width: w * .7,
                  child: ElevatedButton(
                    onPressed: () {
                      cubit.registerByEmailAndPassword(
                          emailController.text.trim(),
                          nameController.text,
                          passwordController.text);
                    },
                    child: const Text("Register"),
                    style: ElevatedButton.styleFrom(
                      primary: forth,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  width: w * .7,
                  child: GoogleAuthButton(
                      onPressed: () async {
                        await cubit.signInByGoogle();
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const AllUsers(),
                            ));
                      },
                      //text:"SignIn with Google",

                      style: const AuthButtonStyle(
                        textStyle: TextStyle(color: Colors.black54),
                        buttonType: AuthButtonType.secondary,
                        iconType: AuthIconType.secondary,
                        buttonColor: Colors.white,
                        borderRadius: 20,
                        iconSize: 15,
                        splashColor: Colors.white,
                      )),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("already have an account"),
                    TextButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const LoginScreen(),
                              ));
                        },
                        child: const Text(
                          "Login",
                          style: TextStyle(color: Colors.black87),
                        )),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
