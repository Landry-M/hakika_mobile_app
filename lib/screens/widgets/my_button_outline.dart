import 'package:flutter/material.dart';

myButtonOutline(BuildContext context, double buttonWidth, String textButton) {
  return Container(
    height: 45,
    width: buttonWidth,
    decoration: BoxDecoration(
      //color: Color.fromARGB(255, 82, 20, 148),
      borderRadius: const BorderRadius.all(
        Radius.circular(12.0),
      ),
      border: Border.all(
        color: const Color.fromARGB(255, 82, 20, 148),
        width: 0.5,
      ),
    ),
    child: Center(
      child: Text(
        textButton,
        style: const TextStyle(
            color: Color.fromARGB(255, 82, 20, 148), fontSize: 17),
      ),
    ),
  );
}
