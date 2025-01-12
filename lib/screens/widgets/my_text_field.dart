import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../provider/qr_gen_provider.dart';

myTextFormField(hintText, prefixIcon, controller, BuildContext context) {
  //final qrGenProvider = Provider.of<QrGenProvider>(context);
  return TextFormField(
    onChanged: (value) =>
        context.read<QrGenProvider>().setNewDataInQrCode(value),
    controller: controller,
    obscureText: context.watch<QrGenProvider>().obscurText,
    validator: (value) {
      if (value == null || value.isEmpty) {
        return 'Veuillez entrer une valeur valide';
      }
      return null;
    },
    decoration: InputDecoration(
      hintText: hintText,
      prefixIcon: Icon(prefixIcon),
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
