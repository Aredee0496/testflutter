import 'package:flutter/material.dart';
import 'package:starlightserviceapp/utils/button-style.dart';

Widget dialogInput(BuildContext context, String title) {
  TextEditingController searchController = TextEditingController();
  return AlertDialog(
    // title: Text(title, style: TextStyle(fontSize: 20)),
    content: SingleChildScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      child: Column(
        children: [
          Text(title, style: TextStyle(fontSize: 20)),
          TextField(
            textInputAction: TextInputAction.done,
            onSubmitted: (val) => Navigator.pop(context, val),
            controller: searchController,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () => Navigator.pop(context, null),
                  child: const Text('Cancel'),
                ),
                ElevatedButton(
                  style: MyStyle().elevatedButton(),
                  onPressed: () =>
                      Navigator.pop(context, searchController.text),
                  child: const Text('OK'),
                ),
              ],
            ),
          )
        ],
      ),
    ),
    // actions: <Widget>[
    //   TextButton(
    //     onPressed: () => Navigator.pop(context, null),
    //     child: const Text('Cancel'),
    //   ),
    //   ElevatedButton(
    //     style: MyStyle().elevatedButton(),
    //     onPressed: () => Navigator.pop(context, searchController.text),
    //     child: const Text('OK'),
    //   ),
    // ],
  );
}
