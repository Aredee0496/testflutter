import 'package:flutter/material.dart';
import 'package:starlightserviceapp/models/app/jobstatus/jobstatus-model.dart';
import 'package:starlightserviceapp/services/app/jobstatsus-service.dart';
import 'package:starlightserviceapp/utils/colors-app.dart';
import 'package:starlightserviceapp/utils/input-data-widget.dart';

class DropdownJobstatus extends StatefulWidget {
  final TextEditingController controller;
  final double width;
  final String? initialValue;
  final Function onSelected;
  const DropdownJobstatus(
      {super.key,
      required this.controller,
      this.initialValue,
      required this.onSelected,
      required this.width});

  @override
  State<DropdownJobstatus> createState() => _DropdownJobstatusState();
}

class _DropdownJobstatusState extends State<DropdownJobstatus> {
  JobStatusService jobStatusService = JobStatusService();
  List<DropdownMenuEntry<JobStatusModel>> itemsStatus = [];

  late Future<List<DropdownMenuEntry>> _dataFuture;

  @override
  void initState() {
    _dataFuture = getStatus();
    super.initState();
  }

  Future<List<DropdownMenuEntry<JobStatusModel>>> getStatus() async {
    try {
      List<JobStatusModel> data = await jobStatusService.getAll(context);
      itemsStatus = [];
      for (var i = 0; i < data.length; i++) {
        JobStatusModel item = data[i];

        itemsStatus.add(DropdownMenuEntry<JobStatusModel>(
            style: ButtonStyle(
                foregroundColor: WidgetStatePropertyAll(MyColors().primary()),
                backgroundColor: WidgetStatePropertyAll(Colors.white),
                textStyle: WidgetStateProperty.all(TextStyle(fontSize: 15))),
            value: item,
            label: item.description));
      }
      return itemsStatus;
    } catch (e) {
      return throw ("$e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _dataFuture,
        builder: (BuildContext context,
            AsyncSnapshot<List<DropdownMenuEntry>> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (widget.controller.text == "") {
              final data = snapshot.data ?? [];
              String initTemp = widget.initialValue ?? "2";
              final index =
                  data.indexWhere((e) => e.value.jobStatusCode == initTemp);
              if (index > -1) {
                widget.controller.text = data[index].label;
                widget.onSelected(data[index].value);
              }
            }
          }
          return DropdownMenu(
            width: widget.width,
            inputDecorationTheme: inputDecorationDropdownMenu(),
            controller: widget.controller,
            textStyle:
                const TextStyle(fontSize: 18, height: double.minPositive),
            dropdownMenuEntries: snapshot.data ?? [],
            trailingIcon: SizedBox(
                width: 25,
                height: 25,
                child: snapshot.connectionState != ConnectionState.done
                    ? CircularProgressIndicator(
                        color: MyColors().primary(),
                      )
                    : const Icon(
                        Icons.arrow_drop_down,
                      )),
            errorText: snapshot.hasError ? snapshot.error.toString() : null,
            enabled: snapshot.connectionState == ConnectionState.done,
            onSelected: (value) => widget.onSelected(value),
          );
        });
  }
}
