import 'package:flutter/material.dart';
import '_login_box.dart';
import '_login_text_field.dart';
import '_purplebutton.dart';
import '_events_page_student.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("BG.png"),
              fit: BoxFit.cover,
            ),
          ),
          child: Container(
            alignment: Alignment.center,
            child: LoginBox(
              fieldArray: [
                const LoginTextField(hinttext: 'Email', obscure: false),
                const LoginTextField(hinttext: 'Password', obscure: true),
                const SizedBox(height: 10),
                Center(
                    child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(
                      context,
                      '/signup',
                    );
                  },
                  child: const Text('No account? Sign up'),
                )),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text('Go back'),
                    ),
                    const SizedBox(width: 10),
                    FilledButton(
                        onPressed: () {
                          //Api call here probably
                          Navigator.pushReplacementNamed(context, "/event");
                        },
                        child: const Text('Login')),
                  ],
                ),
              ],
              title: "Login",
            ),
          )),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: 60,
        leading: Image.asset('assets/logo.png'),
        leadingWidth: 60,
        backgroundColor: Color.fromRGBO(35, 60, 145, 1.0),
        title: const Text(
          'Big Ticket',
          style: TextStyle(color: Color.fromRGBO(255, 255, 255, 1)),
        ),
      ),
    );
  }
}

class StudentSignUp extends StatelessWidget {
  const StudentSignUp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: 60,
        leading: Image.asset('assets/logo.png'),
        leadingWidth: 60,
        backgroundColor: Color.fromRGBO(35, 60, 145, 1.0),
        title: const Text(
          'Big Ticket',
          style: TextStyle(color: Color.fromRGBO(255, 255, 255, 1)),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("BG.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
          alignment: Alignment.center,
          child: LoginBox(
            fieldArray: [
              Row(mainAxisAlignment: MainAxisAlignment.center, children: const [
                LoginTextField(hinttext: 'First Name', obscure: false),
                LoginTextField(hinttext: 'Last Name', obscure: false),
              ]),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  LoginTextField(hinttext: 'Email', obscure: false),
                  LoginTextField(hinttext: 'Password', obscure: true),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  LoginTextField(hinttext: 'Confirm Password', obscure: true),
                  LoginTextField(hinttext: 'Student ID', obscure: false),
                ],
              ),
              const SizedBox(
                height: 40,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, '/login');
                    },
                    child: const Text('Go back'),
                  ),
                  const SizedBox(width: 10),
                  FilledButton(
                      onPressed: () {
                        //Api call here probably
                        Navigator.pushReplacementNamed(context, '/event');
                      },
                      child: const Text('Sign Up')),
                ],
              ),
              const SizedBox(height: 40),
            ],
            title: "Student Sign Up",
          ),
        ),
      ),
    );
  }
}
