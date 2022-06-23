import 'package:auth_buttons/auth_buttons.dart';
import 'package:chat_try_3/blocs/chat_bloc/chat_cubit.dart';
import 'package:chat_try_3/colors.dart';
import 'package:chat_try_3/screens/register_screen.dart';
import 'package:chat_try_3/screens/users_screen.dart';
import 'package:chat_try_3/widgets/textfield_widget.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
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
                  height: 75,
                ),
                Text(
                  "Login",
                  style: TextStyle(
                      color: forth, fontSize: 30, fontWeight: FontWeight.bold),
                ),
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
                SizedBox(
                  width: w * .7,
                  child: ElevatedButton(
                    onPressed: () async {
                      await cubit.login(
                          emailController.text, passwordController.text);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const AllUsers(),
                          ));
                    },
                    child: const Text("Login"),
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
                      onPressed: () {},
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
                TextButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const RegisterScreen(),
                          ));
                    },
                    child: const Text(
                      "Register",
                      style: TextStyle(color: Colors.black87),
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
