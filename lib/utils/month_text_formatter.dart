import 'package:flutter/services.dart';

class MonthTextInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.text.length > 0) {
      if (newValue.text.length > oldValue.text.length &&
          oldValue.text.length != 1) {
        if (int.parse(newValue.text) > 1) {
          return TextEditingValue(
            text: '${0}${newValue.text.substring(newValue.text.length - 1)}',
            selection: TextSelection.collapsed(
              offset: newValue.selection.end + 1,
            ),
          );
        }
      }
    }
    return newValue;
  }
}
