import 'package:flutter/material.dart';
import 'package:huddle01_flutter_client/huddle01_flutter_client.dart';

import '../constants/colors.dart';

class SpaceFooter extends StatefulWidget {
  final HuddleClient huddleClient;
  const SpaceFooter({Key? key, required this.huddleClient}) : super(key: key);

  @override
  State<SpaceFooter> createState() => _SpaceFooterState();
}

class _SpaceFooterState extends State<SpaceFooter> {
  List<MediaDeviceInfo>? audioInput;
  List<MediaDeviceInfo>? audioOutput;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      padding: const EdgeInsets.only(top: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ValueListenableBuilder(
              valueListenable: me,
              builder: (_, val, __) {
                return Material(
                    color: Colors.white.withOpacity(0.1),
                    clipBehavior: Clip.antiAlias,
                    borderRadius: BorderRadius.circular(50),
                    child: InkWell(
                        highlightColor: Colors.white.withOpacity(0.1),
                        splashColor: Colors.white.withOpacity(0.1),
                        onTap: () async {
                          if (!val['mic']) {
                            MediaStream? stream =
                                widget.huddleClient.getAudioStream();

                            if (stream == null) {
                              return print(stream);
                            }

                            await widget.huddleClient.produceAudio(stream);
                          } else {
                            await widget.huddleClient.stopProducingAudio();
                          }
                        },
                        child: Padding(
                            padding: const EdgeInsets.all(25),
                            child: !val['mic']
                                ? const Icon(Icons.mic_off,
                                    color: SpacesColors.micOffColor)
                                : const Icon(Icons.mic,
                                    color: SpacesColors.micOnColor))));
              }),
          Material(
              color: Colors.white.withOpacity(0.1),
              clipBehavior: Clip.antiAlias,
              borderRadius: BorderRadius.circular(50),
              child: InkWell(
                  highlightColor: Colors.white.withOpacity(0.1),
                  splashColor: Colors.white.withOpacity(0.1),
                  onTap: () async {
                    showDialog<void>(
                      context: context,
                      builder: (BuildContext context) => AlertDialog(
                        title: const Text("change audio options"),
                        content: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            ElevatedButton(
                              child: const Text('CHANGE INPUT AUDIO DEVICE'),
                              onPressed: () async {
                                audioInput = await widget.huddleClient
                                    .getAudioInputDevices();
                                if (!mounted) return;
                                Navigator.pop(context);
                                showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                    title:
                                        const Text("Select input Audio Device"),
                                    content: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        SingleChildScrollView(
                                          reverse: true,
                                          child: Column(
                                            children: audioInput!
                                                .map(
                                                  (e) => ElevatedButton(
                                                    child: Text(e.label),
                                                    onPressed: () => {
                                                      widget.huddleClient
                                                          .changeMic(e),
                                                      Navigator.pop(context)
                                                    },
                                                  ),
                                                )
                                                .toList(),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                            ElevatedButton(
                              child: const Text('CHANGE OUTPUT AUDIO DEVICE'),
                              onPressed: () async {
                                audioOutput = await widget.huddleClient
                                    .getAudioOutputDevices();
                                if (!mounted) return;
                                Navigator.pop(context);
                                showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                    title: const Text(
                                        "Select output Audio Device"),
                                    content: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        SingleChildScrollView(
                                          reverse: true,
                                          child: Column(
                                            children: audioOutput!
                                                .map(
                                                  (e) => ElevatedButton(
                                                    child: Text(e.label),
                                                    onPressed: () => {
                                                      widget.huddleClient
                                                          .switchAudioDevice(e),
                                                      Navigator.pop(context)
                                                    },
                                                  ),
                                                )
                                                .toList(),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                  child: const Padding(
                      padding: EdgeInsets.all(25),
                      child: Icon(Icons.audiotrack_rounded,
                          color: SpacesColors.micOffColor)))),
          // Material(
          //     color: Colors.white.withOpacity(0.1),
          //     clipBehavior: Clip.antiAlias,
          //     borderRadius: BorderRadius.circular(50),
          //     child: InkWell(
          //         highlightColor: Colors.white.withOpacity(0.1),
          //         splashColor: Colors.white.withOpacity(0.1),
          //         onTap: () async {
          //           await widget.huddleClient.stopProducingAudio();
          //         },
          //         child: const Padding(
          //             padding: EdgeInsets.all(25),
          //             child:
          //                 Icon(Icons.mic_off, color: SpacesColors.micColor)))),
        ],
      ),
    );
  }
}
