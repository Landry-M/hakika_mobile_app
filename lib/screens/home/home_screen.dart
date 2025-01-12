import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hakika/provider/authentication_provider.dart';
import 'package:hakika/provider/home_provider.dart';
import 'package:hakika/screens/home/components/bottom_sheet_body.dart';
import 'package:hakika/screens/home/components/card_event.dart';
import 'package:hakika/screens/home/components/date_selector.dart';
import 'package:hakika/screens/home/components/event_details_body.dart';
import 'package:hakika/screens/home/components/shimmer_card_event.dart';
import 'package:provider/provider.dart';

import '../../provider/chip_provider.dart';
import '../../provider/event_details_provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<AuthenticationProvider>().loadUserInfoInLocalVariable();
    context.read<HomeProvider>().listOfMyEvent(context);

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
                      width: 55, // Largeur du bouton rond
                      height: 55, // Hauteur du bouton rond
                      decoration: const BoxDecoration(
                        //color: Colors.white, // Couleur de fond
                        shape: BoxShape.circle, // Forme ronde
                      ),
                      child: IconButton(
                        onPressed: () {
                          // showModalBottomSheet(
                          //     context: context,
                          //     builder: (context) => const BottomSheetBody());
                          // context
                          //     .read<AuthenticationProvider>()
                          //     .logoutUser(context);
                          context.goNamed('profil');
                        },
                        icon: Image.asset('lib/assets/img/profile.png'),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 20),

                //corps en dessous du bouton deconexion

                SizedBox(
                  height: 300,
                  child:
                      Consumer<HomeProvider>(builder: (context, value, child) {
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
                        //print(event);

                        return InkWell(
                          onTap: () {
                            context.goNamed(
                              'details-event',
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
        floatingActionButton: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            const SizedBox(width: 10),
            FloatingActionButton(
              backgroundColor: const Color.fromARGB(255, 82, 20, 148),
              heroTag: "btn2",
              child: const Icon(Icons.add, color: Colors.white),
              onPressed: () {
                showModalBottomSheet(
                    // expand: true,
                    context: context,
                    builder: (context) {
                      return PageView(
                        controller: context.watch<HomeProvider>().controller,
                        children: [
                          // first page
                          SizedBox(
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 15),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  //bottom sheet tpour la selection du type d'événement
                                  const BottomSheetBody(),
                                  SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width - 70,
                                    child: context
                                            .watch<ChipProvider>()
                                            .nextButtonForChipIsVisible
                                        ? ElevatedButton(
                                            onPressed: () {
                                              // Action lorsque le bouton est pressé

                                              context
                                                  .read<HomeProvider>()
                                                  .controller
                                                  .nextPage(
                                                      duration: const Duration(
                                                          milliseconds: 500),
                                                      curve:
                                                          Curves.fastOutSlowIn);
                                            },
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor: Colors.pink,
                                              //  primary: Colors.blue, // Couleur de fond
                                              // onPrimary: Colors.white, // Couleur du texte
                                              padding: const EdgeInsets
                                                  .symmetric(
                                                  horizontal: 20,
                                                  vertical:
                                                      12), // Padding autour du texte
                                              shape: RoundedRectangleBorder(
                                                // Forme du bouton
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                              ),
                                            ),
                                            child: const Text(
                                              'Suivant',
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                          )
                                        : const SizedBox(),
                                  ),
                                ],
                              ),
                            ),
                          ),

                          //second screen
                          SizedBox(
                            // controller: ModalScrollController.of(context),
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 10),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  //body pour la saisie des informations des hotes (mairers)
                                  const EventDetailsBody(),
                                  SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width - 70,
                                    child: ElevatedButton(
                                      onPressed: () {
                                        // Action lorsque le bouton est pressé

                                        context
                                            .read<HomeProvider>()
                                            .controller
                                            .nextPage(
                                                duration: const Duration(
                                                    milliseconds: 500),
                                                curve: Curves.fastOutSlowIn);
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.pink,
                                        //  primary: Colors.blue, // Couleur de fond
                                        // onPrimary: Colors.white, // Couleur du texte
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 20,
                                            vertical:
                                                12), // Padding autour du texte
                                        shape: RoundedRectangleBorder(
                                          // Forme du bouton
                                          borderRadius:
                                              BorderRadius.circular(12),
                                        ),
                                      ),
                                      child: const Text(
                                        'Suivant',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),

                          //troisieme screen troisieme
                          SizedBox(
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 10),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  //date ete selection de la salle
                                  const DateSelector(),
                                  context.watch<HomeProvider>().isLoading
                                      ? const Padding(
                                          padding: EdgeInsets.only(bottom: 15),
                                          child: SizedBox(
                                            height: 35,
                                            width: 35,
                                            child: CircularProgressIndicator(
                                              color: Colors.pink,
                                            ),
                                          ),
                                        )
                                      : SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width -
                                              70,
                                          child: ElevatedButton(
                                            onPressed: () {
                                              // Action lorsque le bouton est pressé

                                              context
                                                  .read<HomeProvider>()
                                                  .controller
                                                  .nextPage(
                                                      duration: const Duration(
                                                          milliseconds: 500),
                                                      curve:
                                                          Curves.fastOutSlowIn);
                                            },
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor: Colors.pink,
                                              //  primary: Colors.blue, // Couleur de fond
                                              // onPrimary: Colors.white, // Couleur du texte
                                              padding: const EdgeInsets
                                                  .symmetric(
                                                  horizontal: 20,
                                                  vertical:
                                                      12), // Padding autour du texte
                                              shape: RoundedRectangleBorder(
                                                // Forme du bouton
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                              ),
                                            ),
                                            child: const Text(
                                              'Suivant',
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                          ),
                                        ),
                                ],
                              ),
                            ),
                          ),

                          //dernier screen quatrieme
                          SizedBox(
                            child: Padding(
                              padding: const EdgeInsets.all(10),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  TextFormField(
                                    maxLength: 75,
                                    controller: context
                                        .watch<EventDetailsProvider>()
                                        .adresseController,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Veuillez entrer une valeur valide';
                                      }
                                      return null;
                                    },
                                    decoration: InputDecoration(
                                      labelText: "Adresse de la salle",
                                      hintText: "Adresse de la salle",
                                      prefixIcon: const Icon(Icons.title_sharp),
                                      filled: true,
                                      fillColor: Colors.grey[200],
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: BorderSide.none,
                                      ),
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              horizontal: 20, vertical: 15),
                                    ),
                                  ),
                                  //
                                  context.watch<HomeProvider>().isLoading
                                      ? const Padding(
                                          padding: EdgeInsets.only(bottom: 15),
                                          child: SizedBox(
                                            height: 35,
                                            width: 35,
                                            child: CircularProgressIndicator(
                                              color: Colors.pink,
                                            ),
                                          ),
                                        )
                                      : SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width -
                                              70,
                                          child: ElevatedButton(
                                            onPressed: () {
                                              // Action lorsque le bouton est pressé

                                              context
                                                  .read<HomeProvider>()
                                                  .createEvent(context);
                                            },
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor: Colors.pink,
                                              //  primary: Colors.blue, // Couleur de fond
                                              // onPrimary: Colors.white, // Couleur du texte
                                              padding: const EdgeInsets
                                                  .symmetric(
                                                  horizontal: 20,
                                                  vertical:
                                                      12), // Padding autour du texte
                                              shape: RoundedRectangleBorder(
                                                // Forme du bouton
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                              ),
                                            ),
                                            child: const Text(
                                              'Terminer',
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                          ),
                                        ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      );
                    });
              },
            ),
          ],
        ));
  }
}
