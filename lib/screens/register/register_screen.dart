import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../provider/authentication_provider.dart';
import '../widgets/my_password_text_field.dart';
import '../widgets/my_text_field.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
                      image: AssetImage('lib/assets/img/love.jpg'),
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
                  child: Column(
                    // mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 30),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          IconButton(
                            onPressed: () => GoRouter.of(context).pop(),
                            icon: const Icon(
                              Icons.arrow_back,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 40),
                      const Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "création de compte",
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
              padding: const EdgeInsets.all(5),
              child: Form(
                key: context.watch<AuthenticationProvider>().formKey,
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
                        const Text('Nous désirons en savoir plus sur vous'),
                        const SizedBox(height: 29),

                        myTextFormField(
                            'Votre nom',
                            Icons.person_add,
                            context
                                .watch<AuthenticationProvider>()
                                .nameController,
                            context),

                        const SizedBox(height: 10),

                        myTextFormField(
                            'Votre Email',
                            Icons.email,
                            context
                                .watch<AuthenticationProvider>()
                                .emailController,
                            context),

                        const SizedBox(height: 10),

                        myTextFormField(
                            'Votre Gsm',
                            Icons.phone,
                            context
                                .watch<AuthenticationProvider>()
                                .phoneController,
                            context),

                        const SizedBox(height: 10),

                        myPasswordTextFormField(
                            'Votre Mot de passe',
                            Icons.password_outlined,
                            context
                                .watch<AuthenticationProvider>()
                                .passwordController,
                            context),

                        const SizedBox(height: 20),
                        ElevatedButton.icon(
                          icon: context
                                  .watch<AuthenticationProvider>()
                                  .loginEnCours
                              ? const SizedBox(
                                  height: 20,
                                  width: 20,
                                  child: CircularProgressIndicator())
                              : const Icon(Icons.login),
                          onPressed: () {
                            FocusManager.instance.primaryFocus?.unfocus();
                            if (Provider.of<AuthenticationProvider>(context,
                                    listen: false)
                                .formKey
                                .currentState!
                                .validate()) {
                              context
                                  .read<AuthenticationProvider>()
                                  .registerUser(context);

                              // Ici, vous effectuerez la logique de connexion
                              // Par exemple, en appelant une API pour vérifier les identifiants
                            }
                          },
                          label: const Text("S'inscrire"),
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
