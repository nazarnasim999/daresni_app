import 'package:darasni/theme_data.dart';
import 'package:flutter/material.dart';

class AppInputField extends StatelessWidget {
  final bool readonly;
  final String label;
  final ValueChanged<String?>? onChange;
  final TextEditingController? controller;
  final TextInputType? inputType;
  const AppInputField({
    this.readonly = false,
    this.controller,
    this.label = "",
    this.onChange,
    this.inputType,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      readOnly: readonly,
      controller: controller,
      onChanged: onChange,
      keyboardType: inputType,
      decoration: InputDecoration(
        label: Text(
          label,
          style: AppTStyle.primaryStyle12,
        ),
      ),
    );
  }
}
