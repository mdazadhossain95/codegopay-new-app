import 'package:codegopay/utils/validator.dart';
import 'package:flutter/material.dart';

class inputselectsource extends StatefulWidget {
  final TextEditingController controller;
  final String label, hint, selectString;

  final String? variable;

  final List listitems;

  final ontap;

  const inputselectsource(
      {super.key,
      required this.controller,
      this.ontap,
      required this.label,
      required this.hint,
      required this.listitems,
      required this.selectString,
      this.variable});

  @override
  State<inputselectsource> createState() => _inputselectsourceState();
}

class _inputselectsourceState extends State<inputselectsource> {
  FocusNode myFocusNode = FocusNode();
  int inn = 222;
  bool bordershoww = false;

  @override
  void initState() {
    super.initState();
    myFocusNode.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.label,
          style: TextStyle(
            fontSize: 12,
            fontFamily: 'pop',
            color: myFocusNode.hasFocus || bordershoww
                ? const Color(0xff10245C)
                : const Color(0xffC4C4C4),
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        TextFormField(
          controller: widget.controller,
          focusNode: myFocusNode,
          readOnly: true,
          onTap: () {
            showModalBottomSheet(
                context: context,
                isDismissible: true,
                enableDrag: true,
                isScrollControlled: true,
                backgroundColor: Colors.transparent,
                barrierColor: Colors.black.withOpacity(0.7),
                useRootNavigator: true,
                builder: (context) {
                  return StatefulBuilder(builder: (buildContext,
                      StateSetter setStater /*You can rename this!*/) {
                    return Container(
                        height: MediaQuery.of(context).size.height / 2,
                        padding: EdgeInsets.only(
                            top: 10,
                            right: 10,
                            left: 10,
                            bottom: MediaQuery.of(context).viewInsets.bottom),
                        margin: const EdgeInsets.only(
                            right: 10, left: 10, bottom: 0),
                        decoration: const BoxDecoration(
                          color: Color(0xffC4C4C4),
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(11),
                              topRight: Radius.circular(11)),
                        ),
                        child:
                            Column(mainAxisSize: MainAxisSize.max, children: [
                          Container(
                            alignment: Alignment.center,
                            child: Container(
                              width: 130,
                              color: const Color(0xff10245C),
                              height: 2,
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Text(
                            widget.selectString,
                            style: const TextStyle(
                              color: Color(0xff10245C),
                              fontFamily: 'pop',
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Expanded(
                            child: ListView.builder(
                              itemCount: widget.listitems.length,
                              itemBuilder: (BuildContext context, int index) {
                                return InkWell(
                                  onTap: () {
                                    Navigator.pop(context);
                                    inn = index;

                                    widget.ontap();

                                    widget.controller.text =
                                        widget.listitems[index].type;

                                    bordershoww = true;
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 20),
                                    decoration: const BoxDecoration(
                                        border: Border(
                                            bottom: BorderSide(
                                                color: Colors.white,
                                                width: 1))),
                                    child: Text(
                                      widget.listitems[index].type,
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontFamily: 'pop',
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                );
                              },
                            ),
                          )
                        ]));
                  });
                });
          },
          maxLines: 2,
          minLines: 1,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          validator: (value) {
            return Validator.validateValues(
              value: value,
            );
          },
          onChanged: (v) {
            setState(() {
              v == '' ? bordershoww = false : bordershoww = true;
            });
          },
          style: const TextStyle(
              fontFamily: 'pop',
              fontSize: 12,
              height: 2,
              fontWeight: FontWeight.w500,
              color: Color(0xff10245C)),
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.all(20),
            hintText: widget.hint,
            hintStyle: const TextStyle(
                fontFamily: 'pop',
                fontSize: 12,
                height: 2,
                fontWeight: FontWeight.w500,
                color: Color(0xffC4C4C4)),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: bordershoww
                      ? const Color(0xff10245C)
                      : const Color(0xffC4C4C4),
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(11)),
            errorBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: Colors.red,
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(11)),
            errorMaxLines: 1,
            focusedErrorBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: Colors.red,
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(11)),
            errorStyle: const TextStyle(
                fontFamily: 'pop', fontSize: 12, color: Colors.red),
            focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: Color(0xff10245C),
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(11)),
            border: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: Color(0xff10245C),
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(11)),
            disabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: Color(0xff10245C),
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(11)),
            enabled: true,
          ),
        ),
        const SizedBox(
          height: 15,
        ),
        inn == 222
            ? Container()
            : Text(
              widget.listitems[inn].showmsg,
              style: const TextStyle(fontSize: 13, color: Colors.black45),
            ),
        const SizedBox(
          height: 15,
        ),
      ],
    );
  }
}
