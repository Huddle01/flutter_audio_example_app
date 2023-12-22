import 'package:flutter/material.dart';
import 'package:huddle01_flutter_client/huddle01_flutter_client.dart';

import '../constants/colors.dart';
import 'space_sound_waves.dart';
import 'user_avatar.dart';

class SpaceConversation extends StatefulWidget {
  final HuddleClient huddleClient;
  const SpaceConversation({Key? key, required this.huddleClient})
      : super(key: key);

  @override
  State<SpaceConversation> createState() => _SpaceConversationState();
}

class _SpaceConversationState extends State<SpaceConversation> {
  @override
  Widget build(BuildContext context) {
    me.value = Map.from(me.value)
      ..addAll({
        'mic': false,
      });
    peersList.value = Map.from(peersList.value)
      ..addAll({
        me.value.values.first: me.value,
      });
    return ValueListenableBuilder(
        valueListenable: peersList,
        builder: (_, val, ___) {
          return GridView.count(
              childAspectRatio: 0.75,
              crossAxisCount: 4,
              mainAxisSpacing: 15,
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
                            fontSize: 12)),
                    val.values.toSet().elementAt(index)['mic'] == true
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                                const SpaceSoundWaves(),
                                Text(val.values
                                        .toSet()
                                        .elementAt(index)['audioLevel'] ??
                                    '')
                              ])
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                margin: const EdgeInsets.only(right: 2),
                                child: const Icon(
                                  Icons.mic_off_rounded,
                                  size: 15,
                                  color: SpacesColors.micColor,
                                ),
                              ),
                              Text(val.values
                                      .toSet()
                                      .elementAt(index)['audioLevel'] ??
                                  '')
                            ],
                          )
                  ],
                );
              }));
        });
  }
}
