import 'package:flutter/material.dart';
import 'package:hakika/screens/widgets/my_text_field.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';
import 'package:provider/provider.dart';

import '../../../provider/authentication_provider.dart';

bottomSheetForResetPassword(BuildContext context) {
  showModalBottomSheet(
    context: context,
    // backgroundColor: Colors.transparent,
    builder: (context) {
      return PageView(
        controller: context.watch<AuthenticationProvider>().Pagecontroller,
        children: [
          SizedBox(
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                children: [
                  const Text(
                    "Veuillez entrer le code reçu par email",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 18),
                  OTPTextField(
                    controller:
                        context.watch<AuthenticationProvider>().otpController,
                    length: 4,
                    width: MediaQuery.of(context).size.width - 90,
                    fieldWidth: 50,
                    style: const TextStyle(fontSize: 17),
                    textFieldAlignment: MainAxisAlignment.spaceAround,
                    fieldStyle: FieldStyle.box,
                    onChanged: (pin) {
                      // print("Changed: " + pin);
                      context.read<AuthenticationProvider>().setOtp(pin);
                    },
                    onCompleted: (pin) {
                      // print("Completed: " + pin);
                      context
                          .read<AuthenticationProvider>()
                          .verifyOtp(context, pin, 'reset-password');
                    },
                  ),
                  const SizedBox(height: 18),
                  context.watch<AuthenticationProvider>().isOtpCorrect
                      ? ElevatedButton.icon(
                          icon: const Icon(Icons.next_plan),
                          onPressed: () {
                            FocusManager.instance.primaryFocus?.unfocus();
                            context
                                .read<AuthenticationProvider>()
                                .changeStateOfOtp(false);

                            context
                                .read<AuthenticationProvider>()
                                .Pagecontroller
                                .nextPage(
                                    duration: const Duration(milliseconds: 500),
                                    curve: Curves.fastOutSlowIn);
                          },
                          label: const Text("Suivant"),
                        )
                      : const SizedBox(),
                ],
              ),
            ),
          ),

          //

          SizedBox(
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                children: [
                  const Text(
                    "Veuillez entrer votre nouveau mot de passe",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 15),
                  myTextFormField(
                    'Votre Mot de passe',
                    Icons.lock,
                    context
                        .watch<AuthenticationProvider>()
                        .newPasswordController,
                    context,
                  ),
                  const SizedBox(height: 15),
                  ElevatedButton.icon(
                    icon: const Icon(Icons.next_plan),
                    onPressed: () {
                      FocusManager.instance.primaryFocus?.unfocus();
                    },
                    label: const Text("Terminer"),
                  )
                ],
              ),
            ),
          ),
        ],
      );
    },
  );
}
