import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:letutor/core/shared_widgets/button.dart';
import 'package:letutor/core/utils/colors.dart';
import 'package:flushbar/flushbar.dart';

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

// Future showActionDialogBox({String title, String description}) {
//   return _dialogBox(
//       title: title,
//       content: Text(
//         description,
//         textAlign: TextAlign.center,
//       ),
//       cancelButton: FlatButton(
//         child:Text("Cancel"),
//         onPressed:(){
//           return Modular.to.pop("false");
//         }),
//       confirmButton: raisedButton(
//           btnText: "OK",
//           onPressed: () {
//             return Modular.to.pop("true");
//           }));
// }

Future showSnackBar({String desc}) {
  var context = Modular.navigatorKey.currentState.overlay.context;
  Flushbar flush;

  flush = Flushbar(
    messageText: Text(
      desc,
      style: TextStyle(
        color: Colors.white,
      ),
    ),
    mainButton: FlatButton(
        onPressed: () {
          flush.dismiss(true);
        },
        child: Text(
          "DISMISS",
          style: bodyText2.copyWith(color:Colors.white),
        )),
    backgroundColor: Colors.blue,
    flushbarPosition: FlushbarPosition.BOTTOM,
    padding: EdgeInsets.all(8),
    barBlur: 0.0001,
    borderRadius: 0,
    icon: Icon(
      Icons.info,
      color: Colors.white,
    ),
    duration: Duration(seconds: 3),
  )..show(context);
}
