import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:letutor/core/shared_widgets/button.dart';

BuildContext _context = Modular.navigatorKey.currentState.overlay.context;

Future _dialogBox({
  String title,
  Widget content,
  Widget confirmButton,
  Widget cancelButton,
}) {
  return showDialog(
      context: Modular.navigatorKey.currentState.overlay.context,
      builder: (context) => Dialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            child: Container(
              width: 500,
              margin: EdgeInsets.all(16),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      title,
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    content,
                    SizedBox(
                      height: 20,
                    ),
                    ButtonBar(children: [confirmButton, cancelButton]),
                    SizedBox(
                      height: 20,
                    ),
                  ]),
            ),
          ));
}

Future showDialogBox({String title, String description}) {
  return _dialogBox(
      title: title,
      content: Text(
        description,
        textAlign: TextAlign.center,
      ),
      confirmButton: raisedButton(
          btnText: "OK",
          onPressed: () {
            Modular.to.pop();
          }));
}
