import 'package:flutter/material.dart';
import 'package:hakika/provider/authentication_provider.dart';
import 'package:hakika/provider/details_screen_event_provider.dart';
import 'package:hakika/provider/home_provider_protocole.dart';
import 'package:hakika/screens/details_event/components/bottom_sheet_for_list_inviter.dart';
import 'package:provider/provider.dart';

class HomeScreenProtocole extends StatelessWidget {
  const HomeScreenProtocole({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<AuthenticationProvider>().loadUserInfoInLocalVariable();
    context.read<DetailsSreenEventProvider>().getInviterListForEvent(
        context.watch<AuthenticationProvider>().eventId);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Hakika'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              //avatar de l'utulisasteur
              Row(
                children: [
                  const CircleAvatar(
                    backgroundImage: AssetImage('lib/assets/img/love.jpg'),
                    radius: 25,
                  ),
                  const SizedBox(width: 7),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                          'Bonjour ${context.watch<AuthenticationProvider>().userName}', style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),),
                      Text(context.watch<AuthenticationProvider>().userRole),
                    ],
                  ),
                  const Spacer(),
                  Container(
                    width: 45, // Largeur du bouton rond
                    height: 45, // Hauteur du bouton rond
                    decoration: const BoxDecoration(
                      color: Colors.pink, // Couleur de fond
                      shape: BoxShape.circle, // Forme ronde
                    ),
                    child: IconButton(
                      onPressed: () {
                        context
                            .read<AuthenticationProvider>()
                            .logoutProtocole(context);
                      },
                      icon: const Icon(
                        Icons.power_settings_new,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 220),

              //corps pour le protocole

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InkWell(
                    onTap: () {
                      context.read<HomeProviderProtocole>().scanQR(context);
                    },
                    child: Container(
                      height: 120,
                      width: 120,
                      decoration: const BoxDecoration(
                        // image: DecorationImage(
                        //   image: AssetImage('lib/assets/icons/qr1.png'),
                        // ),
                        color: Color.fromARGB(255, 237, 235, 235),
                        borderRadius: BorderRadius.all(
                          Radius.circular(15),
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Image.asset(
                            'lib/assets/icons/qr.png',
                            height: 50,
                          ),
                          const Text(
                            'Scan',
                            style: TextStyle(color: Colors.black),
                          ),
                        ],
                      ),
                    ),
                  ),

                  //
                  InkWell(
                    onTap: () {
                      context
                          .read<DetailsSreenEventProvider>()
                          .getInviterListForEvent(
                              Provider.of<AuthenticationProvider>(context,
                                      listen: false)
                                  .eventId);
                      bottomSheetForListInviter(context);
                    },
                    child: Container(
                      height: 120,
                      width: 120,
                      decoration: const BoxDecoration(
                        // image: DecorationImage(
                        //   image: AssetImage('lib/assets/icons/qr1.png'),
                        // ),
                        color: Color.fromARGB(255, 91, 45, 141),
                        borderRadius: BorderRadius.all(
                          Radius.circular(15),
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Image.asset(
                            'lib/assets/icons/checklist.png',
                            height: 50,
                          ),
                          const Text(
                            'Invités',
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
