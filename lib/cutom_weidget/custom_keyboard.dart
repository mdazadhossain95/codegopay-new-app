import 'package:flutter/material.dart';

import '../utils/input_fields/custom_color.dart';

class KeyPad2 extends StatelessWidget {
  final TextEditingController? pinController;
  final Function? onChange;

  KeyPad2({
    this.onChange,
    this.pinController,
  });

  @override
  Widget build(BuildContext context) {
    iconButtonWidget(IconData icon, Function function) {
      return Container(
        padding: const EdgeInsets.all(1),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(0),
        ),
        child: InkWell(
          onTap: () {
            function();
          },
          child: Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(0)),
            // ignore: avoid_unnecessary_containers
            child: Container(
              child: Center(
                child: Icon(
                  icon,
                  size: 30,
                  color: CustomColor.black
                ),
              ),
            ),
          ),
        ),
      );
    }

    buttonWidget(String buttonText) {
      return Container(
        padding: const EdgeInsets.all(1),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(0),
        ),
        child: Container(
          height: 50,
          width: 50,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(0)),
          alignment: Alignment.center,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.transparent,
              backgroundColor: Colors.transparent,
              elevation: 0,
              disabledForegroundColor: Colors.transparent.withOpacity(0.38),
              disabledBackgroundColor: Colors.transparent.withOpacity(0.12),
              shadowColor: Colors.transparent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(100),
              ),
            ),
            onPressed: () {
              pinController!.text = '${pinController!.text + buttonText}';

              onChange!(pinController!.text);
            },
            child: Center(
              child: Text(
                buttonText,
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: 25),
              ),
            ),
          ),
        ),
      );
    }

    // ignore: sized_box_for_whitespace
    return Container(
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              buttonWidget('1'),
              buttonWidget('2'),
              buttonWidget('3'),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              buttonWidget('4'),
              buttonWidget('5'),
              buttonWidget('6'),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              buttonWidget('7'),
              buttonWidget('8'),
              buttonWidget('9'),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                padding: const EdgeInsets.all(1),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(0),
                ),
                child: Container(
                  height: 50,
                  width: 50,
                  alignment: Alignment.center,
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(0)),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.transparent,
                      backgroundColor: Colors.transparent,
                      elevation: 0,
                      disabledForegroundColor:
                          Colors.transparent.withOpacity(0.38),
                      disabledBackgroundColor:
                          Colors.transparent.withOpacity(0.12),
                      shadowColor: Colors.transparent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100),
                      ),
                    ),
                    onPressed: () {
                      if (pinController!.text.contains('.')) {
                      } else if (pinController!.text.length == 0) {
                        pinController!.text = pinController!.text + '0.';
                        onChange!(pinController!.text);
                      } else {
                        pinController!.text = pinController!.text + '.';
                        onChange!(pinController!.text);
                      }
                    },
                    child: const Center(
                      child: Text(
                        '.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontWeight: FontWeight.w900,
                            color: Colors.black,
                            fontSize: 25,
                            height: 0),
                      ),
                    ),
                  ),
                ),
              ),
              buttonWidget('0'),
              iconButtonWidget(Icons.arrow_back_rounded, () {
                if (pinController!.text.length > 0) {
                  pinController!.text = pinController!.text
                      .substring(0, pinController!.text.length - 1);
                }

                onChange!(pinController!.text);
              }),
            ],
          ),
        ],
      ),
    );
  }
}
