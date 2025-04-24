import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:surveypro/modules/home_screen.dart';
import 'package:surveypro/widget/text_form_field.dart';

import '../bloc/login_bloc.dart';
import '../bloc/login_event.dart';
import '../bloc/login_state.dart';

class LoginScreen extends StatefulWidget {
  static String routesName = "login_screen";

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  bool sec = true;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Scaffold(
        body: Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.purple.shade300, Colors.purple.shade700],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Card(
            color: Colors.purple.shade500,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
                side: BorderSide(color: Colors.white, width: 2)
            ),

            elevation: 8,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: BlocConsumer<LoginBloc, LoginState>(
                  listener: (context, state) {
                if (state is LoginSuccess) {
                  Navigator.pushNamed(context, HomeScreen.routeName);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                        content: Text(
                            "Login Successful! Welcome ${state.username}"),backgroundColor: Colors.purple.shade300,),
                  );
                } else if (state is LoginFailure) {
                  ScaffoldMessenger.of(context).showSnackBar(
                   const SnackBar(content: Text("Invalid Credentials!"),backgroundColor: Colors.white,),
                  );
                }
              }, builder: (context, state) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                   const Icon(Icons.admin_panel_settings,
                        size: 80, color: Colors.white),
                    const SizedBox(height: 10),
                    Text("Admin Login", style: theme.textTheme.bodySmall),
                    SizedBox(height: 10),
                    TextFormFieldStyle(
                        title: "AdminName", controller: emailController,label: "Email",logo:Icon(Icons.email, color: Colors.white)),
                   const SizedBox(height: 10),
                    TextFormFieldStyle(
                        title: "Password", controller: passwordController,label: "Password",logo: Icon(Icons.password,color: Colors.white),
                      visable: IconButton(icon: Icon(
                          sec ? Icons.visibility : Icons.visibility_off),
                        onPressed: () {
                          setState(() {
                            sec = !sec;
                          });
                        },
                      ),
                      sec: sec,),
                    const SizedBox(height: 20),
                    state is LoginLoading
                        ? const CircularProgressIndicator()
                        : ElevatedButton(
                            onPressed: () {
                              BlocProvider.of<LoginBloc>(context).add(
                                LoginRequested(
                                  emailController.text,
                                  passwordController.text,
                                ),
                              );
                            },
                            child: Text("Sign in"),
                          ),
                  ],
                );
              }),
            ),
          ),
        ),
      ),
    ));
  }
}
