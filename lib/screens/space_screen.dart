import 'dart:io';

import 'package:flutter/material.dart';
import 'package:huddle01_flutter_client/huddle01_flutter_client.dart';
import 'package:permission_handler/permission_handler.dart';

import '../constants/colors.dart';
import '../widgets/glowing_effect.dart';
import '../widgets/space_modal.dart';

class SpaceHome extends StatefulWidget {
  const SpaceHome({Key? key}) : super(key: key);

  @override
  State<SpaceHome> createState() => _SpaceHomeState();
}

class _SpaceHomeState extends State<SpaceHome> {
  HuddleClient huddleClient = HuddleClient();

  Future<bool> getPermissions() async {
    if (Platform.isIOS) return true;
    await Permission.camera.request();
    await Permission.microphone.request();
    await Permission.bluetoothConnect.request();

    while ((await Permission.camera.isDenied)) {
      await Permission.camera.request();
    }
    while ((await Permission.microphone.isDenied)) {
      await Permission.microphone.request();
    }
    while ((await Permission.bluetoothConnect.isDenied)) {
      await Permission.bluetoothConnect.request();
    }
    return true;
  }

  initialiseSpace() async {
    huddleClient.initialize('XBQsbfXdUWW7YlkyF9Yb7BSft6aILeOW');
    await huddleClient.joinLobby('zth-aegg-lgb');
  }

  @override
  void initState() {
    getPermissions();
    initialiseSpace();
    huddleClient.huddleEventListeners();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  late bool createMeetingVisibility;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: SpacesColors.mainBgColor,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 87, 98, 196),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 50, vertical: 20),
                    textStyle: const TextStyle(
                        fontSize: 30, fontWeight: FontWeight.bold)),
                onPressed: () async {
                  await huddleClient.fetchAudioStream();
                  await huddleClient.joinRoom();
                  huddleClient.useEventListener(
                      'room:joined',
                      () => {
                            showModalBottomSheet(
                                isScrollControlled: true,
                                isDismissible: false,
                                backgroundColor: Colors.transparent,
                                context: context,
                                builder: (context) {
                                  return SpaceModal(
                                    huddleClient: huddleClient,
                                  );
                                })
                          });
                },
                child: const Text(
                  'start meeting\n📷',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                      color: Colors.amberAccent),
                ),
              ),
            ],
          ),
        ));
  }
}
