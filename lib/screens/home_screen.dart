import 'dart:io';

import 'package:flutter/material.dart';
import 'package:huddle01_flutter_client/huddle01_flutter_client.dart';
import 'package:permission_handler/permission_handler.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String projectId = 'XBQsbfXdUWW7YlkyF9Yb7BSft6aILeOW';
  String roomId = "ccj-qpde-xvb";

  // getPermissions() async {
  //   if (Platform.isIOS) return;
  //   await Permission.camera.request();
  //   await Permission.microphone.request();
  //   await Permission.bluetooth.request();
  //   await Permission.bluetoothConnect.request();
  // }
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

  @override
  void initState() {
    huddleClient.huddleEventListeners();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  HuddleClient huddleClient = HuddleClient();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          title: const Text(
            "Huddle01\nFlutter Audio App 🎵",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          )),
      body: Column(
        children: [
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                  child: Column(
                children: [
                  TextButton.icon(
                      onPressed: () async {
                        await getPermissions();
                        huddleClient.initialize(projectId);
                      },
                      icon: const Icon(Icons.start_sharp),
                      label: const Text("INITIALIZE")),
                  const SizedBox(
                    height: 5,
                  ),
                  TextButton.icon(
                      onPressed: () {
                        huddleClient.joinLobby(roomId);
                      },
                      icon: const Icon(Icons.room_service),
                      label: const Text("JOIN LOBBY")),
                  const SizedBox(
                    height: 5,
                  ),
                  TextButton.icon(
                      onPressed: () async {
                        await huddleClient.joinRoom();
                        setState(() {});
                      },
                      icon: const Icon(Icons.room_preferences),
                      label: const Text("JOIN ROOM")),
                ],
              )),
              Expanded(
                child: Column(
                  children: [
                    TextButton.icon(
                        onPressed: () async {
                          await huddleClient.fetchAudioStream();
                        },
                        icon: const Icon(Icons.audiotrack),
                        label: const Text("FETCH AUDIO")),
                    TextButton.icon(
                        onPressed: () async {
                          await huddleClient
                              .produceAudio(huddleClient.getAudioStream());
                          setState(() {});
                        },
                        icon: const Icon(Icons.mic),
                        label: const Text("START MIC")),
                    const SizedBox(
                      height: 5,
                    ),
                    TextButton.icon(
                        onPressed: () {
                          huddleClient.stopProducingAudio();
                          setState(() {});
                        },
                        icon: const Icon(Icons.mic_off),
                        label: const Text("STOP MIC")),
                    const SizedBox(
                      height: 5,
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 5,
          ),
          TextButton.icon(
              onPressed: () async {
                await huddleClient.leaveRoom();
              },
              icon: const Icon(Icons.door_back_door),
              label: const Text("LEAVE ROOM")),
          const SizedBox(
            height: 15,
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: ValueListenableBuilder(
              valueListenable: peersList,
              builder: (ctx, val, _) {
                return Container(
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.blueGrey.shade100),
                  child: Column(
                    children: [
                      const Text(
                        "peers in the room 🧑‍🤝‍🧑",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        val.isNotEmpty ? "${val.keys}" : '',
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            fontSize: 15, color: Colors.blueGrey),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
