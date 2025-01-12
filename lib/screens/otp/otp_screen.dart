import 'package:flutter/material.dart';
import 'package:otp_text_field/otp_text_field.dart';
import 'package:otp_text_field/style.dart';
import 'package:provider/provider.dart';

import '../../provider/authentication_provider.dart';

class OtpScreen extends StatelessWidget {
  final String action;
  const OtpScreen({super.key, required this.action});

  @override
  Widget build(BuildContext context) {
    context.read<AuthenticationProvider>().setUserInfoInVariable();

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  height: 200,
                  decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 82, 20, 148),
                    image: DecorationImage(
                      image: AssetImage('lib/assets/img/6.jpeg'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),

                //
                Container(
                  height: 200,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.4),
                  ),
                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: 20),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Vérification de votre adresse email",
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 15),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Form(
                // key: context.watch<AuthenticationProvider>().formKey,
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // SizedBox(
                        //   height: 75,
                        //   child: Image.asset(
                        //     'lib/assets/imgs/insurance.png',
                        //   ),
                        // ),
                        const SizedBox(height: 20),
                        // const Text(
                        //   'Bienvenue',
                        //   style: TextStyle(fontWeight: FontWeight.bold),
                        // ),
                        Text(
                          "${context.watch<AuthenticationProvider>().userName}, Rassurez-nous que vous n'etes pas un robot. Entrez le code a 4 chiffres transmis par email.",
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            InkWell(
                              onTap: () {
                                context
                                    .read<AuthenticationProvider>()
                                    .resendOtp();
                              },
                              child: const Text(
                                "Renvoyer le code",
                                style: TextStyle(
                                  color: Color.fromARGB(255, 82, 20, 148),
                                ),
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 29),

                        OTPTextField(
                          controller: context
                              .watch<AuthenticationProvider>()
                              .otpController,
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
                                .verifyOtp(context, pin, action);
                          },
                        ),

                        const SizedBox(height: 20),

                        ElevatedButton.icon(
                          icon: context
                                  .watch<AuthenticationProvider>()
                                  .loginEnCours
                              ? const SizedBox(
                                  height: 20,
                                  width: 20,
                                  child: CircularProgressIndicator())
                              : const Icon(Icons.lock_open_rounded),
                          onPressed: () {
                            FocusManager.instance.primaryFocus?.unfocus();
                            if (Provider.of<AuthenticationProvider>(context,
                                        listen: false)
                                    .otpController !=
                                null) {
                              context.read<AuthenticationProvider>().verifyOtp(
                                  context,
                                  context
                                      .watch<AuthenticationProvider>()
                                      .otpCode,
                                  action);
                              // Ici, vous effectuerez la logique de connexion
                              // Par exemple, en appelant une API pour vérifier les identifiants
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content:
                                      Text("Veuillez remplir tous les champs"),
                                ),
                              );
                            }
                          },
                          label: const Text("Valider"),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
