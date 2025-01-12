import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../provider/authentication_provider.dart';

dropDownForRole(BuildContext context) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 16.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.3),
          spreadRadius: 2,
          blurRadius: 8,
          offset: const Offset(0, 4), // Change position of shadow
        ),
      ],
    ),
    child: DropdownButton<String>(
      hint: const Text(
        'Votre rôle',
        style: TextStyle(color: Colors.teal),
      ),
      value: context.watch<AuthenticationProvider>().selectedRole,
      isExpanded: true,
      onChanged: (String? newValue) {
        //  print(newValue);
        context.read<AuthenticationProvider>().setSelectedRole(newValue!);
      },
      items: context
          .watch<AuthenticationProvider>()
          .rolesList
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(
            value,
            style: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w600,
            ),
          ),
        );
      }).toList(),
      icon: const Icon(
        Icons.arrow_drop_down,
        color: Color.fromARGB(255, 82, 20, 148),
      ),
      dropdownColor: Colors.white,
      underline: Container(), // Enlève la ligne sous le Dropdown
    ),
  );
}
