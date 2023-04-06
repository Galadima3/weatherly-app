import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:email_validator/email_validator.dart';
import 'package:weatherly/src/features/auth/data/auth_repository.dart';
import 'package:weatherly/src/features/auth/presentation/screens/register_screen.dart';
import 'package:weatherly/src/features/weather/presentation/screens/home_page.dart';

import '../shared_widgets/shared_button.dart';

class LogInScreen extends ConsumerStatefulWidget {
  const LogInScreen({super.key});
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LogInScreen> {
  final _formKey = GlobalKey<FormState>();
  //submit method
  onSubmit(WidgetRef ref, String email, String password) {
    if (_formKey.currentState!.validate()) {
      return ref
          .read(authRepositoryProvider)
          .signInWithEmailAndPassword(email, password)
          .then((value) => Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return const HomePage();
                  },
                )
              ));
    }
  }

  @override
  build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final emailController = TextEditingController();
    final passwordController = TextEditingController();

    //disposing all text controllers

    return SafeArea(
      child: Scaffold(
        body: Container(
          width: size.width,
          height: size.height,
          color: Colors.white,
          child: SingleChildScrollView(
            child: Column(
              //mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Log In Screen'),
                const Icon(
                  Icons.android,
                  size: 100,
                ),

                //email textfield
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Form(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    key: _formKey,
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          border: Border.all(color: Colors.white),
                          borderRadius: BorderRadius.circular(12)),
                      child: TextFormField(
                        validator: (text) => EmailValidator.validate(text!)
                            ? null
                            : "Please enter a valid email",
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Email',
                            prefixIcon: Icon(Icons.email)),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                //password textfield
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        border: Border.all(color: Colors.white),
                        borderRadius: BorderRadius.circular(12)),
                    child: TextField(
                      controller: passwordController,
                      keyboardType: TextInputType.visiblePassword,
                      obscureText: true,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Password',
                        prefixIcon: Icon(Icons.password),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 15),

                //submit button
                GestureDetector(
                  onTap: () => onSubmit(
                      ref, emailController.text, passwordController.text),
                  child: const SharedButton(
                    buttonText: 'Log in',
                  ),
                ),

                const SizedBox(
                  height: 15,
                ),
                //not a member? register now
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Not a registered user?',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    GestureDetector(
                      onTap: () => Navigator.push(context, MaterialPageRoute(
                        builder: (context) {
                          return const RegisterScreen();
                        },
                      )),
                      child: const Text(
                        'Sign up',
                        style: TextStyle(
                            color: Color(0xFF427dde),
                            fontWeight: FontWeight.bold),
                      ),
                    )
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
