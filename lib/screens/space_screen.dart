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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: SpacesColors.mainBgColor,
        body: Center(child: GlowingEffect(
          onTap: () async {
            await huddleClient.joinRoom();
            if (!context.mounted) return;
            showModalBottomSheet(
                isScrollControlled: true,
                isDismissible: false,
                backgroundColor: Colors.transparent,
                context: context,
                builder: (context) {
                  return SpaceModal(
                    huddleClient: huddleClient,
                  );
                }).whenComplete(() {});
          },
        )));
  }
}
