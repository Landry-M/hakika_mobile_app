import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../provider/authentication_provider.dart';

myPasswordTextFormField(
    hintText, prefixIcon, controller, BuildContext context) {
  //final qrGenProvider = Provider.of<QrGenProvider>(context);
  return TextFormField(
    controller: controller,
    obscureText: context.watch<AuthenticationProvider>().obscurText,
    validator: (value) {
      if (value == null || value.isEmpty || value.length < 4) {
        return 'Mot de passe superieur ou egal a 4 caracteres requis.';
      }
      return null;
    },
    decoration: InputDecoration(
      hintText: hintText,
      prefixIcon: Icon(prefixIcon),
      suffixIcon: IconButton(
        icon: Icon(
          context.watch<AuthenticationProvider>().obscurText
              ? Icons.visibility
              : Icons.visibility_off,
        ),
        onPressed: () {
          context.read<AuthenticationProvider>().setPasswordObscured();
        },
      ),
      filled: true,
      fillColor: Colors.grey[200],
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide.none,
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
    ),
  );
}
