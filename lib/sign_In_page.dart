import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:survey_collect/sign_Up_page.dart';
import 'package:email_validator/email_validator.dart';

class sign_In_page extends StatefulWidget {
  const sign_In_page({Key? key}) : super(key: key);

  @override
  State<sign_In_page> createState() => _sign_In_pageState();
}

class _sign_In_pageState extends State<sign_In_page> {
  final passwordController = TextEditingController();
  final emailController = TextEditingController();
  @override
  void dispose() {
    // TODO: implement dispose
    passwordController.dispose();
    emailController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.grey[100],
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 80,
              ),
              const Text(
                'Welcome Back',
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.green),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                "Survey Collect",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                'Log in',
                style: TextStyle(
                  fontSize: 29,
                  fontWeight: FontWeight.w500,
                  color: Color(0xff01b2ee),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: EmailEditor(),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Password_Editor(),
              ),
              const SizedBox(
                height: 20,
              ),
              const SizedBox(
                height: 30,
              ),
              ElevatedButton(
                  onPressed: () {
                    Login(context);
                  },
                  child: const Text(
                    'Log in',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  )),
              const SizedBox(
                height: 25,
              ),
              const Text(
                'Forgot password?',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                    color: Color(0xff567b99)),
              ),
              const SizedBox(
                height: 15,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Row(
                  children: [
                    const Text("Don't have an account yet?",
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.lightGreen,
                          fontWeight: FontWeight.w400,
                        )),
                    const SizedBox(
                      width: 8,
                    ),
                    GestureDetector(
                      child: const Text("Sign Up",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w400,
                            color: Colors.green
                          )),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => sign_Up_Page()),
                        );
                      },
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget EmailEditor() {
    return Form(
      key: GlobalKey<FormState>(),
      child: TextFormField(
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
              hintText: 'example@gmai.com',
              //errorText: 'Enter a Valid Email',
              prefixIcon: Icon(Icons.email),
              contentPadding: EdgeInsets.all(12),
              labelText: 'Email',
              border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
          controller: emailController,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          validator: (email) {
            return email != null && !EmailValidator.validate(email)
                ? 'Enter a valid email'
                : null;
          }),
    );
  }

  Widget Password_Editor() {
    return Form(
      key: GlobalKey<FormState>(),
      child: TextFormField(
          decoration: InputDecoration(
              hintText: 'Enter your password',
              //errorText: 'Enter a Valid Email',
              prefixIcon: Icon(Icons.vpn_key_sharp),
              contentPadding: EdgeInsets.all(12),
              labelText: 'Password',
              border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
          controller: passwordController,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          validator: (value) => value != null && value.length < 6
              ? 'Password should be more than 6 characters'
              : null),
    );
  }

  Widget User_name_Editor() {
    return TextField(
      decoration: InputDecoration(
          hintText: 'Username',
          //errorText: 'Enter a Valid Email',
          prefixIcon: Icon(Icons.person),
          filled: false,
          fillColor: Colors.blue.shade200,
          contentPadding: const EdgeInsets.all(12),
          label: const Text('Username'),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
    );
  }

  Future Login(context) async {
    showDialog(
        context: context,
        builder: (context) => const Center(
          child: CircularProgressIndicator(),
        ));

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim());
    } on FirebaseAuthException catch (e) {
      print(e);
    }
    Navigator.of(context).pop();
  }
}
