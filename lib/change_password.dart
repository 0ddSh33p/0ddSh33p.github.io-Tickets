import 'package:flutter/material.dart';
import '_purplebutton.dart';

class UpdatePassword extends StatefulWidget {
  const UpdatePassword({super.key});

  @override
  State<UpdatePassword> createState() => _UpdatePasswordState();
}

class _UpdatePasswordState extends State<UpdatePassword> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _username = TextEditingController();
  final TextEditingController _oldPassword = TextEditingController();
  final TextEditingController _newPassword = TextEditingController();
  final TextEditingController _confirmPassword = TextEditingController();

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
            'Deep Run Ticket Manager',
            style: TextStyle(color: Color.fromRGBO(255, 255, 255, 1)),
          ),
          bottom: PreferredSize(
              preferredSize: const Size.fromHeight(30.0),
              child: Container(
                color: Color.fromRGBO(230, 230, 230, 1.0),
                child: Row(
                  children: [
                    CallButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/osp');
                        },
                        text: 'Online Payment'),
                    CallButton(onPressed: () {}, text: 'Submit Paperwork'),
                    CallButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/forms');
                        },
                        text: 'Forms For Event'),
                    CallButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const UpdatePassword()),
                          );
                        },
                        text: 'Update Password'),
                    Padding(
                      padding: const EdgeInsets.all(5),
                      child: SizedBox(
                        height: 20,
                        child: FilledButton(
                            style: ButtonStyle(
                                backgroundColor:
                                    MaterialStatePropertyAll<Color>(
                                        Color.fromARGB(255, 147, 39, 143))),
                            onPressed: () {
                              Navigator.pushNamed(context, '/admin');
                            },
                            child: Text('Admin Portal')),
                      ),
                    ),
                  ],
                ),
              )),
        ),
        body: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _email,
                decoration: InputDecoration(
                  hintText: 'Email',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter an email';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _username,
                decoration: InputDecoration(
                  hintText: 'Username',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter an username';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _oldPassword,
                decoration: InputDecoration(
                  hintText: 'Old Password',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter old pasword';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _newPassword,
                decoration: InputDecoration(
                  hintText: 'New Password',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter new password';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _confirmPassword,
                decoration: InputDecoration(
                  hintText: 'Confirm Password',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter an event title';
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  FilledButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text("Back")),
                  SizedBox(width: 10),
                  FilledButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          setState(() {
                            //Api call
                          });
                        }
                      },
                      child: Text('Submit')),
                ],
              ),
            ],
          ),
        ));
  }
}
