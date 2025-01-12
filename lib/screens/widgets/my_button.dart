import 'package:flutter/material.dart';

myButton(BuildContext context, double buttonWidth, String textButton) {
  return InkWell(
    child: Container(
      height: 45,
      width: buttonWidth,
      decoration: const BoxDecoration(
        color: Color.fromARGB(255, 82, 20, 148),
        borderRadius: BorderRadius.all(
          Radius.circular(12.0),
        ),
      ),
      child: Center(
        child: Text(
          textButton,
          style: const TextStyle(color: Colors.white, fontSize: 17),
        ),
      ),
    ),
  );
}
