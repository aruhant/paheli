import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:paheli/models/game.dart';
import 'package:paheli/models/user_prefs.dart';
import 'package:paheli/translations/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'line_widget.dart';

class ResultWidget extends StatefulWidget {
  const ResultWidget({required this.gameResult, super.key});
  final GameResult gameResult;

  @override
  State<ResultWidget> createState() => _ResultWidgetState();
}

class _ResultWidgetState extends State<ResultWidget> {
  bool pressedShare = false;

  @override
  Widget build(BuildContext context) {
    return Material(
        color: Colors.black12,
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(18),
              border: Border.all(
                  color: widget.gameResult.win
                      ? const Color.fromRGBO(255, 181, 70, 1)
                      : const Color.fromARGB(255, 231, 255, 229),
                  width: 5),
              gradient: LinearGradient(
                  colors: widget.gameResult.win
                      ? const [
                          Color.fromRGBO(162, 79, 1, 1),
                          Color.fromRGBO(230, 154, 39, 1),
                          Color.fromRGBO(229, 130, 0, 1),
                        ]
                      : const [
                          Color.fromRGBO(130, 154, 39, 1),
                          Color.fromRGBO(198, 198, 107, 1),
                          Color.fromRGBO(62, 179, 1, 1),
                        ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight)),
          padding: const EdgeInsets.all(18),
          margin: const EdgeInsets.all(18),
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Align(
                  alignment: Alignment.topRight,
                  child: IconButton(
                    icon: const Icon(Icons.close),
                    color: Colors.black,
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ),
              ),
              Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        Icon(
                            (widget.gameResult.win
                                ? Icons.emoji_events_outlined
                                : Icons.sentiment_dissatisfied_outlined),
                            size: 140,
                            color: const Color.fromARGB(255, 6, 7, 10)),
                        Text(
                            widget.gameResult.win
                                ? LocaleKeys.gameResult_victoryMessage.tr()
                                : LocaleKeys.gameResult_defeatMessage.tr(),
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                                fontSize: 50,
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 6, 7, 10))),
                        Text(
                            LocaleKeys.gameResult_practiceMode.tr(args: [
                              (UserPrefs.instance.practiceGameIndex + 1)
                                  .toString()
                            ]),
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 6, 7, 10))),
                      ],
                    ),
                    pressedShare
                        ? // line widget with last line i the game
                        LineWidget(
                            line: widget.gameResult.lines[1],
                            group: AutoSizeGroup(),
                          )
                        : (Column(
                            children: [
                              Text(
                                widget.gameResult.answer.answer,
                                style: const TextStyle(
                                  fontSize: 40,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                              Text(
                                LocaleKeys.gameResult_meaning.tr(
                                    args: [widget.gameResult.answer.meaning]),
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          )),
                    Text(
                      LocaleKeys.gameResult_tries
                          .tr(args: [widget.gameResult.tries.toString()]),
                      style: const TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    widget.gameResult.win
                        ? (Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              IconButton(
                                  icon: const Icon(Icons.share),
                                  color: Colors.black,
                                  onPressed: () {
                                    setState(() {
                                      pressedShare = true;
                                    });
                                  }),
                              Text(
                                LocaleKeys.gameResult_share.tr(),
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ))
                        : const SizedBox(),
                  ]),
            ],
          ),
        ));
  }
}
