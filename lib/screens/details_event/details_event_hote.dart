import 'package:flutter/material.dart';
import 'package:hakika/provider/details_screen_event_provider.dart';
import 'package:hakika/screens/details_event/components/bottom_sheet_for_list_hotes.dart';
import 'package:hakika/screens/details_event/components/bottom_sheet_for_list_inviter.dart';
import 'package:hakika/screens/details_event/components/bottom_sheet_for_list_protocol.dart';
import 'package:hakika/screens/details_event/components/bottom_sheet_for_list_task.dart';
import 'package:hakika/screens/details_event/components/shimmer_event_details.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:provider/provider.dart';

class DetailsEnventHoteScreen extends StatelessWidget {
  final String eventId;
  const DetailsEnventHoteScreen({super.key, required this.eventId});

  @override
  Widget build(BuildContext context) {
    context.read<DetailsSreenEventProvider>().getEventDetailsById(eventId);

    context.read<DetailsSreenEventProvider>().getInviterListForEvent(eventId);

    // context.read<DetailsSreenEventProvider>().getnviteInRealTime();
    //context.read<DetailsSreenEventProvider>().checkPresenceInRealTime();
    context.read<DetailsSreenEventProvider>().getListProtocoles(eventId);

    // context
    //     .read<DetailsSreenEventProvider>()
    //     .getInviterAsbsentsOrPresents(eventId, 'absent');
    return Scaffold(
      appBar: AppBar(
        title: const Text("Details de l'événement"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: FutureBuilder(
              future: context
                  .read<DetailsSreenEventProvider>()
                  .getInviterListForEvent(eventId),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return shimmerEventDetails(context);
                }
                if (snapshot.hasError) {
                  return Center(child: Text(snapshot.error.toString()));
                }
                if (snapshot.hasData) {
                  return Consumer<DetailsSreenEventProvider>(
                      builder: (context, value, child) {
                    if (value.isLoading) {
                      return shimmerEventDetails(context);
                    }

                    return Column(
                      children: [
                        Container(
                          height: MediaQuery.of(context).size.height / 2.3,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: const Color.fromARGB(255, 239, 223, 233),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(15),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width -
                                          150,
                                      child: Text(
                                        "${context.watch<DetailsSreenEventProvider>().eventType} de ${context.watch<DetailsSreenEventProvider>().eventTitle}",
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    //menu contextuel
                                    PopupMenuButton<int>(
                                      icon: const Icon(Icons
                                          .more_horiz), // Les 3 petits points
                                      onSelected: (int result) {
                                        // Gérer l'action sélectionnée
                                        switch (result) {
                                          case 0:
                                            // Action 1
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              const SnackBar(
                                                  content: Text(
                                                    "Suppression en cours ...",
                                                  ),
                                                  duration:
                                                      Duration(seconds: 1),
                                                  backgroundColor:
                                                      Colors.black),
                                            );
                                            break;
                                        }
                                      },
                                      itemBuilder: (BuildContext context) => [
                                        //
                                        PopupMenuItem<int>(
                                          onTap: () {
                                            //
                                            context
                                                .read<
                                                    DetailsSreenEventProvider>()
                                                .getListProtocoles(eventId);

                                            bottomSheetForListProtocol(context);

                                            //
                                          },
                                          value: 0,
                                          child: const Row(
                                            children: [
                                              Icon(Icons
                                                  .self_improvement_rounded),
                                              SizedBox(width: 10),
                                              Text('Lister les protocoles'),
                                            ],
                                          ),
                                        ),

                                        //
                                        PopupMenuItem<int>(
                                          onTap: () {
                                            //
                                            context
                                                .read<
                                                    DetailsSreenEventProvider>()
                                                .getListinviter(eventId);

                                            bottomSheetForListInviter(context);

                                            //
                                          },
                                          value: 1,
                                          child: const Row(
                                            children: [
                                              Icon(Icons.people),
                                              SizedBox(width: 10),
                                              Text('Lister les invités'),
                                            ],
                                          ),
                                        ),

                                        //
                                        PopupMenuItem<int>(
                                          onTap: () {
                                            //
                                            context
                                                .read<
                                                    DetailsSreenEventProvider>()
                                                .getListHotes(eventId);

                                            bottomSheetForListHotes(context);

                                            //
                                          },
                                          value: 2,
                                          child: const Row(
                                            children: [
                                              Icon(Icons.person),
                                              SizedBox(width: 10),
                                              Text('Lister les hôtes')
                                            ],
                                          ),
                                        ),

                                        //

                                        PopupMenuItem<int>(
                                          onTap: () {
                                            //
                                            context
                                                .read<
                                                    DetailsSreenEventProvider>()
                                                .getTasksList(eventId);

                                            bottomSheetForListTasks(
                                              context,
                                              eventId,
                                            );

                                            //
                                          },
                                          value: 4,
                                          child: const Row(
                                            children: [
                                              Icon(Icons.task),
                                              SizedBox(width: 10),
                                              Text('Lister les taches')
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    CircularPercentIndicator(
                                      animation: true,
                                      radius: 100.0,
                                      lineWidth: 20.0,
                                      percent: (context
                                              .watch<
                                                  DetailsSreenEventProvider>()
                                              .percentagePerson /
                                          100),
                                      header: Text(
                                          "${context.watch<DetailsSreenEventProvider>().inviterListe.length.toString()} / ${context.watch<DetailsSreenEventProvider>().nbTotalInviter} invitation créée pour ce ${context.watch<DetailsSreenEventProvider>().eventType}"),
                                      center: Text(
                                        '${(context.watch<DetailsSreenEventProvider>().percentagePerson).toStringAsFixed(2)} %',
                                        style: const TextStyle(fontSize: 20),
                                      ),
                                      backgroundColor: Colors.white,
                                      progressColor: Colors.green,
                                      circularStrokeCap: CircularStrokeCap.butt,
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 10),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Column(
                                      children: [
                                        const Text('Présent(s)'),
                                        Text(context
                                            .watch<DetailsSreenEventProvider>()
                                            .inviterPresents
                                            .length
                                            .toString()),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 20,
                                      child: VerticalDivider(
                                        color: Colors.grey,
                                      ),
                                    ),
                                    Column(
                                      children: [
                                        const Text('Absent(s)'),
                                        Text(context
                                            .watch<DetailsSreenEventProvider>()
                                            .inviterAbsents
                                            .length
                                            .toString()),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    );
                  });
                }
                return shimmerEventDetails(context);
              }),
        ),
      ),
    );
  }
}
