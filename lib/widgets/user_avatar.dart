import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class UserAvatar extends StatefulWidget {
  const UserAvatar({
    Key? key,
  }) : super(key: key);

  @override
  State<UserAvatar> createState() => _UserAvatarState();
}

class _UserAvatarState extends State<UserAvatar> {
  List<Widget> emojiMsgWidgets = [];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 70,
      height: 70,
      child: Stack(clipBehavior: Clip.none, children: [
        ClipOval(
          child: CachedNetworkImage(
            imageUrl:
                "https://huddle-frontend-assets.s3.amazonaws.com/Avatar/00.png",
            fit: BoxFit.cover,
            placeholder: (context, url) =>
                const Center(child: CircularProgressIndicator()),
            errorWidget: (context, url, error) => const Icon(Icons.error),
          ),
        ),
      ]),
    );
  }
}
