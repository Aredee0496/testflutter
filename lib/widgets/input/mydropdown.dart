import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:starlightserviceapp/models/app/dropdown-items-model.dart';
import 'package:starlightserviceapp/models/app/jobstatus/jobstatus-model.dart';
import 'package:starlightserviceapp/services/app/jobstatsus-service.dart';
import 'package:starlightserviceapp/utils/colors-app.dart';
import 'package:starlightserviceapp/utils/input-data-widget.dart';

class MyDropdown extends StatefulWidget {
  final TextEditingController controller;
  final double width;
  final String? initialValue;
  final Function onSelected;
  const MyDropdown(
      {super.key,
      required this.controller,
      this.initialValue,
      required this.onSelected,
      required this.width});

  @override
  State<MyDropdown> createState() => _MyDropdownState();
}

class _MyDropdownState extends State<MyDropdown> {
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

DropdownMenu myDropdownMenu(
    {Key? key,
    required TextEditingController controller,
    required List<DropdownMenuEntry> items,
    required String label,
    required double width,
    required bool loading,
    required bool enabled,
    String? error,
    required Function onSelected}) {
  return DropdownMenu(
    width: width,
    inputDecorationTheme: inputDecorationDropdownMenu(),
    controller: controller,
    textStyle: const TextStyle(fontSize: 18, height: double.minPositive),
    dropdownMenuEntries: items,
    trailingIcon: SizedBox(
        width: 25,
        height: 25,
        child: loading
            ? CircularProgressIndicator(
                color: MyColors().primary(),
              )
            : const Icon(
                Icons.arrow_drop_down,
              )),
    errorText: error != "" ? error : null,
    enabled: enabled,
    onSelected: (value) => onSelected(value),
  );
}

DropdownSearch<DropdownItemsModel> myDropdownMenu2(
    {Key? key,
    required List<DropdownItemsModel> items,
    required String label,
    required bool enabled,
    required List<String> selectedItems,
    DropdownItemsModel? initValue,
    String? error,
    required Function onSelected}) {
  return DropdownSearch<DropdownItemsModel>(
    itemAsString: (item) => item.text,
    items: items,
    selectedItem: initValue,
    dropdownDecoratorProps:
        DropDownDecoratorProps(baseStyle: TextStyle(fontSize: 18)),
    onChanged: (value) => onSelected(value),
    popupProps: PopupProps.menu(
      disabledItemFn: (item) => selectedItems.contains(item),
      itemBuilder: (context, item, isSelected) {
        bool isDisabled = selectedItems.contains(item.value);
        return ListTile(
          tileColor: MyColors().primary5(),
          title: Text(
            item.text,
            style: TextStyle(
                color: isDisabled ? Colors.grey : Colors.black, fontSize: 18),
          ),
          enabled: !isDisabled,
        );
      },
    ),
  );
}

DropdownSearch<DropdownItemsModel> myDropdownMenuWithClear(
    {Key? key,
    required List<DropdownItemsModel> items,
    required String label,
    required bool enabled,
    required List<String> selectedItems,
    DropdownItemsModel? initValue,
    String? error,
    required Function onSelected}) {
  return DropdownSearch<DropdownItemsModel>(
    itemAsString: (item) => item.text,
    items: items,
    selectedItem: initValue,
    clearButtonProps: ClearButtonProps(
      icon: Icon(
        Icons.cancel,
      ),
      isVisible: true,
      // onPressed: () => onSelected(null),
    ),
    dropdownDecoratorProps:
        DropDownDecoratorProps(baseStyle: TextStyle(fontSize: 18)),
    onChanged: (value) => onSelected(value),
    popupProps: PopupProps.menu(
      disabledItemFn: (item) => selectedItems.contains(item),
      itemBuilder: (context, item, isSelected) {
        bool isDisabled = selectedItems.contains(item.value);
        return ListTile(
          tileColor: MyColors().primary5(),
          title: Text(
            item.text,
            style: TextStyle(
                color: isDisabled ? Colors.grey : Colors.black, fontSize: 18),
          ),
          enabled: !isDisabled,
        );
      },
    ),
  );
}

DropdownSearch<DropdownItemsModel> myDropdownMenu3(
    {Key? key,
    required List<DropdownItemsModel> items,
    required String label,
    required bool enabled,
    required List<String> selectedItems,
    DropdownItemsModel? initValue,
    String? error,
    required Function onSelected}) {
  return DropdownSearch<DropdownItemsModel>(
    itemAsString: (item) => item.text,
    items: items,
    selectedItem: initValue,
    dropdownDecoratorProps:
        DropDownDecoratorProps(baseStyle: TextStyle(fontSize: 18)),
    onChanged: (value) => onSelected(value),
    popupProps: PopupProps.menu(
      disabledItemFn: (item) => selectedItems.contains(item),
      showSearchBox: true,
      searchDelay: Duration.zero,
      searchFieldProps: TextFieldProps(
          showCursor: true, decoration: InputDecoration(labelText: "ค้นหา")),
      itemBuilder: (context, item, isSelected) {
        bool isDisabled = selectedItems.contains(item.value);
        return ListTile(
          tileColor: MyColors().primary5(),
          title: Text(
            item.text,
            style: TextStyle(
                color: isDisabled ? Colors.grey : Colors.black, fontSize: 20),
          ),
          enabled: !isDisabled,
        );
      },
    ),
  );
}
