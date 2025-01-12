import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hakika/provider/authentication_provider.dart';
import 'package:hakika/provider/home_provider.dart';
import 'package:hakika/screens/home/components/card_event.dart';
import 'package:hakika/screens/home/components/shimmer_card_event.dart';
import 'package:provider/provider.dart';


class HomeScreenHote extends StatelessWidget {
  const HomeScreenHote({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<AuthenticationProvider>().loadUserInfoInLocalVariable();
    context.read<HomeProvider>().listOfMyEventHote(context);

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
                        'Bienvenue ${context.watch<AuthenticationProvider>().userName}',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
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
                            .logoutUser(context);
                      },
                      icon: const Icon(
                        Icons.power_settings_new,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              //corps en dessous du bouton deconexion

              SizedBox(
                height: 300,
                child: Consumer<HomeProvider>(builder: (context, value, child) {
                  final events = value.eventsList;

                  if (context.watch<HomeProvider>().isLoading) {
                    return shimmerCardEvent(context);
                  }

                  if (context.watch<HomeProvider>().noDataFound) {
                    return Center(
                        child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 100,
                          child: Image.asset('lib/assets/img/schedule.png'),
                        ),
                        const SizedBox(height: 20),
                        const Text("Aucun événement en votre nom trouvé(s)")
                      ],
                    ));
                  }
                  return ListView.builder(
                    itemCount: events.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      final event = events[index];

                      return InkWell(
                        onTap: () {
                          context.goNamed(
                            'details-event-hote',
                            pathParameters: {'eventId': event['\$id']},
                          );
                        },
                        child: cardEvent(
                          context,
                          Colors.pink,
                          event['title'],
                          event['type'],
                          event['nb_invite'],
                          event['event_date'],
                          event['salle'] ?? 'Salle non définie',
                        ),
                      );
                    },
                  );
                }),
              )
            ],
          ),
        ),
      ),
    );
  }
}
