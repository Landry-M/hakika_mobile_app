import 'package:flutter/material.dart';
import 'package:hakika/provider/details_screen_event_provider.dart';
import 'package:provider/provider.dart';

import '../../../provider/authentication_provider.dart';

bottomSheetForListProtocol(BuildContext context) {
  // print(
  //   context.read<DetailsSreenEventProvider>().listProtocole.length,
  // );

  return showModalBottomSheet(
    context: context,
    builder: (context) => Container(
      padding: const EdgeInsets.all(16),
      child: ListView.builder(
        itemCount:
            context.read<DetailsSreenEventProvider>().listProtocole.length,
        itemBuilder: (context, index) {
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            elevation: 5,
            child: ListTile(
              contentPadding: const EdgeInsets.all(16),
              leading: CircleAvatar(
                backgroundColor: Colors.green,
                child: Text(
                  context.read<DetailsSreenEventProvider>().listProtocole[index]
                      ['nom'], // Initiale du prénom

                  style: const TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
              title: Text(
                context.watch<DetailsSreenEventProvider>().listProtocole[index]
                    ['nom'],
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              subtitle: Text(
                "Pin: ${context.read<DetailsSreenEventProvider>().listProtocole[index]['pin'].toString()}",
                style: TextStyle(color: Colors.grey[600], fontSize: 14),
              ),
              trailing: context.watch<AuthenticationProvider>().userRole ==
                      'organisateur'
                  ? IconButton(
                      onPressed: () {
                        // print(Provider.of<DetailsSreenEventProvider>(context,
                        //         listen: false)
                        //     .listProtocole[index]['\$id']);

                        context
                            .read<DetailsSreenEventProvider>()
                            .deleteProtocole(
                                context,
                                Provider.of<DetailsSreenEventProvider>(context,
                                        listen: false)
                                    .listProtocole[index]['\$id'],
                                Provider.of<DetailsSreenEventProvider>(context,
                                        listen: false)
                                    .listProtocole[index]['event_id']);
                      },
                      icon: const Icon(
                        Icons.delete,
                        size: 25,
                        color: Colors.red,
                      ),
                    )
                  : const SizedBox.shrink(),
            ),
          );
        },
      ),
    ),
  );
}
