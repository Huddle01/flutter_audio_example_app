import 'package:flutter/material.dart';

class LeaveScreen extends StatelessWidget {
  const LeaveScreen({super.key});

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
                'you left the spaces 😔',
                textAlign: TextAlign.center,
              ),
              // TextButton(
              //     onPressed: () {
              //       Navigator.push(
              //         context,
              //         MaterialPageRoute(
              //             builder: (context) => const TwitterSpaceHome()),
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
