import 'package:flutter/material.dart';
import 'package:huddle01_flutter_client/huddle01_flutter_client.dart';

import '../screens/leave_screen.dart';
import 'set_name_dialog.dart';

class SpaceHeader extends StatefulWidget {
  final HuddleClient huddleClient;
  const SpaceHeader({Key? key, required this.huddleClient}) : super(key: key);

  @override
  State<SpaceHeader> createState() => _SpaceHeaderState();
}

class _SpaceHeaderState extends State<SpaceHeader> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          icon: const Icon(Icons.arrow_downward_rounded,
              color: Colors.white, size: 30),
          onPressed: () {
            print(peersList.value);
          },
        ),
        Row(
          children: [
            IconButton(
                icon: const Icon(Icons.abc_rounded,
                    color: Colors.white, size: 30),
                onPressed: () async {
                  widget.huddleClient.audioLevel();
                  // await showDialog(
                  //     context: context,
                  //     builder: (BuildContext context) =>
                  //         setNameDialog(context, widget.huddleClient));
                }),
            const SizedBox(width: 15),
            TextButton(
              onPressed: () {
                widget.huddleClient.leaveRoom();
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const LeaveScreen()),
                );
              },
              child: const Text('Leave',
                  style: TextStyle(
                      fontSize: 16,
                      color: Colors.red,
                      fontWeight: FontWeight.bold)),
            )
          ],
        )
      ],
    );
  }
}
