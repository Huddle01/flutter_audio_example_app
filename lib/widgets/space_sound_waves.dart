import 'package:flutter/material.dart';

import '../constants/colors.dart';

class SpaceSoundWaves extends StatefulWidget {
  const SpaceSoundWaves({Key? key}) : super(key: key);

  @override
  State<SpaceSoundWaves> createState() => _SpaceSoundWavesState();
}

class _SpaceSoundWavesState extends State<SpaceSoundWaves>
    with TickerProviderStateMixin {
  late AnimationController ctrlSide;
  late AnimationController ctrlMiddle;

  @override
  void initState() {
    super.initState();

    ctrlSide = AnimationController(
        vsync: this,
        lowerBound: 2,
        upperBound: 10,
        duration: const Duration(milliseconds: 250))
      ..repeat(reverse: true);

    ctrlSide.addListener(() {
      setState(() {});
    });

    ctrlMiddle = AnimationController(
        vsync: this,
        lowerBound: 2,
        upperBound: 10,
        duration: const Duration(milliseconds: 250))
      ..repeat(reverse: false);
  }

  @override
  void dispose() {
    ctrlSide.dispose();
    ctrlMiddle.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 2),
      child: Row(
        children: List.generate(5, (index) {
          return Container(
              margin: const EdgeInsets.only(left: 1, right: 1),
              width: 3,
              height: index % 2 == 0 ? ctrlMiddle.value : ctrlSide.value,
              decoration: BoxDecoration(
                  color: SpacesColors.micOffColor,
                  borderRadius: BorderRadius.circular(20)));
        }),
      ),
    );
  }
}