import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

TextField myTextField(
    {Key? key,
    required TextEditingController controller,
    required String label,
    required ValueChanged<String?> onChanged,
    bool? clear,
    TextInputType? textInputType,
    int? maxLength,
    bool? disable}) {
  List<TextInputFormatter> inputFormatters = [];

  if (textInputType == TextInputType.number) {
    // inputFormatters.add(FilteringTextInputFormatter.allow(RegExp(r'[0-9]')));
    inputFormatters.add(FilteringTextInputFormatter.digitsOnly);
  }
  return TextField(
    key: key, // ใช้ key ที่ได้รับ
    controller: controller,
    keyboardType: textInputType,
    inputFormatters: inputFormatters,
    maxLength: maxLength,
    enabled: disable,
    readOnly: disable ?? false,
    style: TextStyle(
        fontSize: 20,
        color: disable == true ? Colors.grey : Colors.black,
        height: clear == null || clear == true ? double.minPositive : 1),
    decoration: InputDecoration(
      labelText: label,
      suffixIcon: clear == null || clear == true
          ? IconButton(
              icon: const Icon(Icons.cancel),
              onPressed: () {
                controller.clear();
                onChanged(null);
              },
            )
          : null,
    ),
    onChanged: onChanged,
  );
}
