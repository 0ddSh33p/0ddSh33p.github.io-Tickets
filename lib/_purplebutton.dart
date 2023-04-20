import 'package:flutter/material.dart';

class CallButton extends StatelessWidget {
  const CallButton({
    super.key,
    required this.onPressed,
    required this.text,
  });

  final String text;
  final VoidCallback onPressed;
    @override
  Widget build(BuildContext context){
    return SizedBox(
      height: 30,
      width: 9.0*(text.length)+100,
      child: Padding(
        padding: const EdgeInsets.all(5),
        child: Row(
            children: [
              Image.asset('assets/check.png'),
              const SizedBox(width: 2),
              FilledButton(
                style: ButtonStyle(
                  backgroundColor: const MaterialStatePropertyAll<Color>(Color.fromARGB(255, 147, 39, 143)),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(topRight: Radius.circular(18), bottomRight: Radius.circular(18)),
                    )
                  ),
                  padding: MaterialStateProperty.all(const EdgeInsets.only(left: 3, right: 8)),
                  alignment: Alignment.topLeft,
                  minimumSize: MaterialStateProperty.all(const Size.fromWidth(5)),
                ),
                onPressed: onPressed,
                child: Text(text,style: const TextStyle(fontSize: 15),),
              ),
            ],
          ),
      ),
    );
  }
}