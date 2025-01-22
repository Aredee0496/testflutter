import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:starlightserviceapp/utils/button-style.dart';
import 'package:starlightserviceapp/utils/colors-app.dart';
import 'package:widget_zoom/widget_zoom.dart';

class DialogHelper {
  static void showErrorDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.warning_rounded,
              color: Colors.red,
            ),
            Text('ERROR'),
          ],
        ),
        content: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
                child: Text(
              message,
              style: const TextStyle(fontSize: 17, fontWeight: FontWeight.normal),
            )),
          ],
        ),
        actionsAlignment: MainAxisAlignment.center,
        actions: <Widget>[
          TextButton(
            child: const Text('Back',
                style: TextStyle(fontSize: 20, color: Colors.red)),
            onPressed: () => Navigator.of(context)
              ..pop()
              ..pop(),
          ),
        ],
      ),
    );
  }

  static void showErrorMessageDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Icon(
                Icons.warning_rounded,
                color: Colors.red,
              ),
            ),
            Text('ERROR'),
          ],
        ),
        content: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
                child: Text(
              message,
              style: const TextStyle(fontSize: 17, fontWeight: FontWeight.normal),
            )),
          ],
        ),
        actionsAlignment: MainAxisAlignment.center,
        actions: <Widget>[
          ElevatedButton(
            style: MyStyle().elevatedButton(),
            child: const Text('Back'),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      ),
    );
  }

  static void showWarningDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Icon(
                Icons.warning_rounded,
                color: Color.fromARGB(255, 248, 188, 37),
              ),
            ),
            Text('Warning'),
          ],
        ),
        content: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
                child: Text(
              message,
              style: const TextStyle(fontSize: 17, fontWeight: FontWeight.normal),
            )),
          ],
        ),
        actionsAlignment: MainAxisAlignment.spaceBetween,
        actions: <Widget>[
          TextButton(
            child: const Text('Cancel'),
            onPressed: () => Navigator.of(context).pop(false), // Return false
          ),
          ElevatedButton(
            style: MyStyle().elevatedButton(),
            child: const Text('Confirm'),
            onPressed: () => Navigator.of(context).pop(true), // Return true
          ),
        ],
      ),
    );
  }

  static void showSuccessDialog(
      BuildContext context, String message, int countBack) {
    // Timer _timer;
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          // _timer = Timer(const Duration(seconds: 2), () {
          //   Navigator.of(context).pop();
          // });
          return AlertDialog(
            title: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Icon(
                    Icons.check_circle,
                    color: Colors.green,
                  ),
                ),
                Text(
                  'Complete',
                  style: TextStyle(fontSize: 32),
                ),
              ],
            ),
            actionsAlignment: MainAxisAlignment.center,
            actions: <Widget>[
              ElevatedButton(
                  style: MyStyle().elevatedButton(),
                  child: const Text('OK'),
                  onPressed: () {
                    for (var i = 0; i < countBack; i++) {
                      Navigator.of(context).pop(true);
                    }
                  } // Return false
                  ),
            ],
          );
        });
  }

  static void showLoading(BuildContext context) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return const AlertDialog(
            content: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                    padding: EdgeInsets.only(left: 8, right: 16),
                    child: CircularProgressIndicator()),
                Text(
                  'Loading...',
                  style: TextStyle(fontSize: 18),
                ),
              ],
            ),
          );
        });
  }

  static void showLoadingWithText(BuildContext context, String? text) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
            content: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircularProgressIndicator(
                  color: MyColors().primary(),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 16, right: 4),
                  child: Text(
                    text ?? 'Loading...',
                    style: const TextStyle(fontSize: 18),
                  ),
                ),
              ],
            ),
          );
        });
  }

  static void hideLoading(BuildContext context) {
    Navigator.of(context).pop();
  }

  static void showDialogViewImage(BuildContext context, String? url) {
    print(url);
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.0)),
              elevation: 0.0,
              backgroundColor: Colors.transparent,
              content: Container(
                margin: const EdgeInsets.only(left: 0.0, right: 0.0),
                child: Stack(
                  children: <Widget>[
                    Container(
                      padding: const EdgeInsets.only(
                        top: 18.0,
                      ),
                      margin: const EdgeInsets.only(top: 13.0, right: 8.0),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.circular(16.0),
                          boxShadow: const <BoxShadow>[
                            BoxShadow(
                              color: Colors.black26,
                              blurRadius: 0.0,
                              offset: Offset(0.0, 0.0),
                            ),
                          ]),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          const SizedBox(
                            height: 20.0,
                          ),
                          Center(
                              child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Image.network(
                                    url ?? "",
                                    loadingBuilder: (context, child,
                                            loadingProgress) =>
                                        Text(
                                            "${loadingProgress?.cumulativeBytesLoaded}"),
                                    errorBuilder:
                                        (context, error, stackTrace) => Text(
                                      "Sorry please try \n ${stackTrace}",
                                      style: const TextStyle(
                                          fontSize: 30.0, color: Colors.white),
                                    ),
                                  ) //
                                  ))
                        ],
                      ),
                    ),
                    Positioned(
                      right: 0.0,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: const Align(
                          alignment: Alignment.topRight,
                          child: CircleAvatar(
                            radius: 14.0,
                            backgroundColor: Colors.white,
                            child: Icon(Icons.close, color: Colors.red),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ));
        });
  }

  static void showDialogViewImageByte(BuildContext context, Uint8List body) {
    print(body);
    showDialog(
        useSafeArea: false,
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.0)),
              elevation: 0.0,
              backgroundColor: Colors.transparent,
              content: Container(
                margin: const EdgeInsets.only(left: 0.0, right: 0.0),
                child: Stack(
                  children: <Widget>[
                    Container(
                      padding: const EdgeInsets.only(
                        top: 18.0,
                      ),
                      margin: const EdgeInsets.only(top: 13.0, right: 8.0),
                      decoration: BoxDecoration(
                          color: MyColors().backgroundColor(),
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.circular(16.0),
                          boxShadow: const <BoxShadow>[
                            BoxShadow(
                              color: Colors.black26,
                              blurRadius: 0.0,
                              offset: Offset(0.0, 0.0),
                            ),
                          ]),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          const SizedBox(
                            height: 10.0,
                          ),
                          Center(
                              child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: WidgetZoom(
                                    heroAnimationTag: 'tag',
                                    zoomWidget: Image.memory(
                                      body,
                                      errorBuilder:
                                          (context, error, stackTrace) => Text(
                                        "Sorry please try \n ${stackTrace}",
                                        style: const TextStyle(
                                            fontSize: 30.0,
                                            color: Colors.white),
                                      ),
                                    ),
                                  )))
                        ],
                      ),
                    ),
                    Positioned(
                      right: 0.0,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: const Align(
                          alignment: Alignment.topRight,
                          child: CircleAvatar(
                            radius: 14.0,
                            backgroundColor: Colors.white,
                            child: Icon(Icons.close, color: Colors.red),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ));
        });
  }
}
