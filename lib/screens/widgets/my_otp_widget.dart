import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../provider/authentication_provider.dart';

myOtpWidget(BuildContext context) {
  return Container(
    padding: const EdgeInsets.only(right: 15, left: 15, top: 10),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: 100,
          width: 50,
          child: TextField(
            focusNode: context.watch<AuthenticationProvider>().focusNode1,
            maxLength: 1,
            keyboardType: TextInputType.number,
            onChanged: (value) {
              context.read<AuthenticationProvider>().setOtp(value);
              FocusScope.of(context).requestFocus(
                  Provider.of<AuthenticationProvider>(context, listen: false)
                      .focusNode2);
            },
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.grey[300],
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide.none,
              ),
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            ),
          ),
        ),
        const SizedBox(width: 10.0),
        //deuxieme champ
        SizedBox(
          height: 100,
          width: 50,
          child: TextField(
            maxLength: 1,
            focusNode: context.watch<AuthenticationProvider>().focusNode2,
            keyboardType: TextInputType.number,
            onChanged: (value) {
              context.read<AuthenticationProvider>().setOtp(value);
              FocusScope.of(context).requestFocus(
                  Provider.of<AuthenticationProvider>(context, listen: false)
                      .focusNode3);
            },
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.grey[300],
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide.none,
              ),
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            ),
          ),
        ),
        const SizedBox(width: 10.0),
        //troisieme champ
        SizedBox(
          height: 100,
          width: 50,
          child: TextField(
            maxLength: 1,
            focusNode: context.watch<AuthenticationProvider>().focusNode3,
            keyboardType: TextInputType.number,
            onChanged: (value) {
              context.read<AuthenticationProvider>().setOtp(value);
              FocusScope.of(context).requestFocus(
                  Provider.of<AuthenticationProvider>(context, listen: false)
                      .focusNode4);
            },
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.grey[300],
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide.none,
              ),
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            ),
          ),
        ),

        const SizedBox(width: 10.0),
        //quatrieme champ
        SizedBox(
          height: 100,
          width: 50,
          child: TextField(
            maxLength: 1,
            focusNode: context.watch<AuthenticationProvider>().focusNode4,
            keyboardType: TextInputType.number,
            onChanged: (value) {
              context.read<AuthenticationProvider>().setOtp(value);
            },
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.grey[300],
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide.none,
              ),
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            ),
          ),
        ),
      ],
    ),
  );
}
