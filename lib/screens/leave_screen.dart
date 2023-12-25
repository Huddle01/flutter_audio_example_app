// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_audio_example_app/screens/space_screen.dart';
import 'package:huddle01_flutter_client/huddle01_flutter_client.dart';

class LeaveScreen extends StatelessWidget {
  LeaveScreen({super.key});

  HuddleClient huddleClient = HuddleClient();
  @override
  Widget build(BuildContext context) {
    return const PopScope(
      canPop: false,
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'you left the spaces 👋',
                textAlign: TextAlign.center,
              ),
              // TextButton(
              //     onPressed: () {
              //       peersList.value.clear();
              //       Navigator.push(
              //         context,
              //         MaterialPageRoute(
              //             builder: (context) => const SpaceHome()),
              //       );
              //     },
              //     child: const Text(
              //       'tap here to go 🔙',
              //       textAlign: TextAlign.center,
              //     )),
            ],
          ),
        ),
      ),
    );
  }
}
