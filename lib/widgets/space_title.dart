import 'package:flutter/material.dart';

class SpaceTitle extends StatelessWidget {
  const SpaceTitle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 10),
        Text.rich(
          TextSpan(children: [
            TextSpan(
                text: '@Huddle01',
                style: TextStyle(
                    color: Colors.blueAccent, fontWeight: FontWeight.bold)),
            TextSpan(
                text: ' Spaces',
                style: TextStyle(
                    color: Colors.white, fontWeight: FontWeight.bold)),
          ]),
          style: TextStyle(fontSize: 20),
          textAlign: TextAlign.left,
        ),
        SizedBox(height: 30)
      ],
    );
  }
}
