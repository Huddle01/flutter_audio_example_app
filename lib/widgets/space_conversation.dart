import 'dart:async';

import 'package:flutter/material.dart';
import 'package:huddle01_flutter_client/huddle01_flutter_client.dart';

import 'user_avatar.dart';

class SpaceConversation extends StatefulWidget {
  final HuddleClient huddleClient;
  const SpaceConversation({Key? key, required this.huddleClient})
      : super(key: key);

  @override
  State<SpaceConversation> createState() => _SpaceConversationState();
}

class _SpaceConversationState extends State<SpaceConversation> {
  Timer? timer;
  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(const Duration(milliseconds: 500),
        (Timer t) => widget.huddleClient.audioLevel());
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    peersList.value = Map.from(peersList.value)
      ..addAll({
        me.value.values.first: me.value,
      });
    return ValueListenableBuilder(
        valueListenable: peersList,
        builder: (_, val, ___) {
          return GridView.count(
              childAspectRatio: 0.5,
              crossAxisCount: 4,
              mainAxisSpacing: 25,
              children: List.generate(val.length, (index) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const UserAvatar(),
                    const SizedBox(height: 5),
                    Text(val.values.toSet().elementAt(index)['displayName'],
                        style: const TextStyle(
                            color: Color.fromRGBO(255, 255, 255, 1),
                            fontSize: 8)),
                    const SizedBox(height: 5),
                    Text(
                        val.values.toSet().elementAt(index)['audioLevel'] ?? '',
                        style: const TextStyle(
                            color: Color.fromRGBO(255, 255, 255, 1),
                            fontSize: 8)),
                    const SizedBox(height: 5),
                  ],
                );
              }));
        });
  }
}
