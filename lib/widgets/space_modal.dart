import 'package:flutter/material.dart';
import 'package:huddle01_flutter_client/huddle01_flutter_client.dart';

import 'space_conversation.dart';
import 'space_footer.dart';
import 'space_header.dart';
import 'space_title.dart';

class SpaceModal extends StatelessWidget {
  final HuddleClient huddleClient;
  const SpaceModal({Key? key, required this.huddleClient}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    huddleClient.fetchAudioStream();
    return Container(
        height: MediaQuery.of(context).size.height -
            (MediaQuery.of(context).size.height * 0.25),
        padding: const EdgeInsets.all(24),
        decoration: const BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20))),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SpaceHeader(huddleClient: huddleClient),
            const SpaceTitle(),
            Expanded(
              child: SpaceConversation(
                huddleClient: huddleClient,
              ),
            ),
            SpaceFooter(
              huddleClient: huddleClient,
            )
          ],
        ));
  }
}
