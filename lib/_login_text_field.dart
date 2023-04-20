import 'package:flutter/material.dart';

    class LoginTextField extends StatelessWidget{
      const LoginTextField({
    super.key,
    required this.hinttext,
    required this.obscure,
  });     
    final String hinttext;
    final bool obscure; 
    @override
      Widget build(BuildContext context,) {
          return SizedBox(
            width: 200,
            height: 45,
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: TextField(
                textAlignVertical: TextAlignVertical.bottom,
                obscureText: obscure,
                style: const TextStyle(fontSize: 15),
                decoration: InputDecoration(
                  isCollapsed: true,
                  contentPadding: const EdgeInsets.fromLTRB(5.0, 10.0, 5.0, 10.0),
                  border: const OutlineInputBorder(),
                  hintText: hinttext,
                  hintStyle: const TextStyle(fontSize: 12.5),
                ),
                onSubmitted: (value) {
                  //Here is the API call
                },
              ),
            ),
          );
    }
    }