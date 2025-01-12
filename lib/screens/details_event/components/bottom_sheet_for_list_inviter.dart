import 'package:flutter/material.dart';
import 'package:hakika/provider/details_screen_event_provider.dart';
import 'package:provider/provider.dart';

bottomSheetForListInviter(BuildContext context) {
  return showModalBottomSheet(
    isScrollControlled: true,
    // backgroundColor: Colors.transparent,
    context: context,
    builder: (context) => Container(
        padding: const EdgeInsets.all(15),
        height: MediaQuery.of(context).size.height - 150,
        child: Column(
          children: [
            // Barre de recherche
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  PopupMenuButton<int>(
                    icon: const Icon(Icons.filter_list),
                    onSelected: (int result) {
                      // Gérer l'action sélectionnée
                      switch (result) {
                        case 0:
                          // Action 1
                          break;
                      }
                    },
                    itemBuilder: (BuildContext context) => [
                      PopupMenuItem<int>(
                        onTap: () {
                          context
                              .read<DetailsSreenEventProvider>()
                              .setFilterBy('nom');
                        },
                        value: 0,
                        child: const Text('Nom'),
                      ),
                      PopupMenuItem<int>(
                        onTap: () {
                          context
                              .read<DetailsSreenEventProvider>()
                              .setFilterBy('table');
                        },
                        value: 1,
                        child: const Text('Table'),
                      ),
                    ],
                  ),
                  Text(
                    context.read<DetailsSreenEventProvider>().filteredInvitesBy,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  //
                  SizedBox(
                    height: 50,
                    width: MediaQuery.of(context).size.width - 180,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            spreadRadius: 1,
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: TextField(
                        controller: context
                            .watch<DetailsSreenEventProvider>()
                            .searchController,
                        decoration: InputDecoration(
                          labelText:
                              "Filtre par ${context.read<DetailsSreenEventProvider>().filteredInvitesBy}",
                          prefixIcon: const Icon(Icons.search),
                          filled: true,
                          fillColor: Colors.grey[200],
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: BorderSide.none,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: BorderSide.none,
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: const BorderSide(
                                color: Color.fromARGB(255, 82, 20, 148),
                                width: 2),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            //

            Expanded(
              child: ListView.builder(
                itemCount: context
                    .read<DetailsSreenEventProvider>()
                    .filteredInvites
                    .length,
                itemBuilder: (context, index) {
                  return Card(
                    margin: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    elevation: 5,
                    child: ListTile(
                      contentPadding: const EdgeInsets.all(16),
                      leading: CircleAvatar(
                        backgroundColor: context
                                    .read<DetailsSreenEventProvider>()
                                    .filteredInvites[index]['etat'] ==
                                "present"
                            ? Colors.green
                            : Colors.red,
                        child: const Icon(
                          Icons.person,
                          color: Colors.white,
                        ),
                      ),
                      title: Text(
                        context
                            .watch<DetailsSreenEventProvider>()
                            .filteredInvites[index]['nom'],
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                      subtitle: Text(
                        "Table: ${context.read<DetailsSreenEventProvider>().filteredInvites[index]['table'].toString()} ",
                        style: TextStyle(color: Colors.grey[600], fontSize: 14),
                      ),
                      trailing: IconButton(
                        onPressed: () {
                          // context.read<DetailsSreenEventProvider>().deleteProtocole(
                          //     context,
                          //     Provider.of<DetailsSreenEventProvider>(context,
                          //             listen: false)
                          //         .listInviter[index]['\$id'],
                          //     Provider.of<DetailsSreenEventProvider>(context,
                          //             listen: false)
                          //         .listInviter[index]['event_id']);
                        },
                        icon: context
                                    .read<DetailsSreenEventProvider>()
                                    .filteredInvites[index]['etat'] ==
                                "present"
                            ? const Text(
                                'Présent',
                                style: TextStyle(color: Colors.green),
                              )
                            : const Text(
                                'Absent',
                                style: TextStyle(
                                  color: Colors.red,
                                ),
                              ),
                      ),
                      onTap: () {
                        // Action au tap
                        // print('click sur un inviter');
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        )),
  );
}
