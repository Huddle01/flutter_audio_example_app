import 'package:flutter/material.dart';
import 'package:huddle01_flutter_client/huddle01_flutter_client.dart';

Widget setNameDialog(BuildContext context, HuddleClient huddleClient) {
  TextEditingController setNameDialog = TextEditingController();
  return AlertDialog(
      title: const Center(
          child: Text(
        "set your name",
        style: TextStyle(fontSize: 16),
      )),
      content: SizedBox(
        height: 150,
        width: 250,
        child: Column(
          children: [
            TextField(
              controller: setNameDialog,
            ),
            Expanded(child: Container()),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () async {
                    await huddleClient
                        .setDisplayName(setNameDialog.text.trim());
                    if (!context.mounted) return;
                    Navigator.pop(context);
                  },
                  child: const Text("set name"),
                )
              ],
            )
          ],
        ),
      ));
}
