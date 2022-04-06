import 'package:flutter/material.dart';

class PhraseButton extends StatelessWidget {
  const PhraseButton({Key? key, required this.text, required this.callback}) : super(key: key);
  final String text;
  final GestureTapCallback callback;
  //final VoidCallback press;



  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.all(15),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            gradient: const LinearGradient(
              colors: [
                Colors.green,
                Colors.lightGreen,
              ],
            ),),
        child: Center(
            child: TextButton(
          onPressed: callback,
          child: Text(
            text,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 25,
            ),
          ),
        ),),);
  }
}
