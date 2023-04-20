import 'package:flutter/material.dart';

class LoginBox extends StatelessWidget {
  const LoginBox({
    super.key,
    required this.fieldArray,
    required this.title,
  });

  final List<Widget> fieldArray;
  final String title;
    @override
  Widget build(BuildContext context){
    return SizedBox(
      height: 400,
      width: 460,
      child: DecoratedBox(
        decoration: BoxDecoration(border: Border.all(color: (Colors.black), width: 7), color: Colors.white),
        child: Column(
          children: [
            const SizedBox(height: 7),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("⎯⎯ ", maxLines: 1, style: TextStyle(color: Colors.black, fontSize: 50, fontWeight: FontWeight.w800),),
                Text(title, maxLines: 1, style: TextStyle(color: const Color.fromARGB(255, 147, 39, 143), fontSize: 50-2.0*title.length, fontWeight: FontWeight.w800)),
                const Text(" ⎯⎯", maxLines: 1, style: TextStyle(color: Colors.black, fontSize: 50, fontWeight: FontWeight.w800),),
              ],
            ),
            Column(
              children: fieldArray,
            ),
          ],
        ),
      ),
    );
  }
}