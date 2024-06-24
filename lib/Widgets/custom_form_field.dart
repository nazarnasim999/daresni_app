import 'package:darasni/Controllers/AuthenticationController/auth_controller.dart';
import 'package:darasni/Controllers/controllers_init.dart';
import 'package:darasni/theme_data.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class AppFormField extends StatefulWidget {
  final TextEditingController? controller;
  final String? title;
  final String? hintText;
  final bool isRequiredField;
  final ValueChanged<String?>? onChange;
  final Widget? suffix;
  bool obSecure;
  final TextStyle? hintStyle;
  final bool forTutor;
  final VoidCallback? onTap;
  final bool readOnly;
  final FormFieldValidator<String>? validator;
  final bool isPasswordField;
  final TextInputType? keyboardType;
  AppFormField({
    this.controller,
    this.title,
    this.readOnly = false,
    this.onTap,
    this.obSecure = false,
    this.hintText,
    this.hintStyle,
    this.onChange,
    this.validator,
    this.isRequiredField = false,
    this.forTutor = false,
    this.isPasswordField = false,
    this.suffix,
    this.keyboardType,
    super.key,
  });

  @override
  State<AppFormField> createState() => _AppFormFieldState();
}

class _AppFormFieldState extends State<AppFormField> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            if (widget.title != null)
              Text(
                widget.title!,
                style: AppTStyle.regularStyle12.copyWith(
                  color: authController.userType == UserType.tutor
                      ? AppTheme.secondaryColor
                      : AppTheme.primaryColor,
                ),
              ),
            if (widget.isRequiredField) Text("*", style: TextStyle(color: AppTheme.primaryColor)),
          ],
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: TextFormField(
            keyboardType: widget.keyboardType,
            validator: widget.validator,
            controller: widget.controller,
            onTap: widget.onTap,
            onChanged: widget.onChange,
            cursorColor: AppTheme.primaryColor,
            obscureText: widget.obSecure,
            readOnly: widget.readOnly,
            decoration: InputDecoration(
              suffix: GestureDetector(
                onTap: () {
                  widget.obSecure = !widget.obSecure;
                  setState(() {});
                },
                child: (widget.isPasswordField)
                    ? Icon(
                        Icons.remove_red_eye,
                        color: !widget.obSecure ? AppTheme.primaryColor : Colors.grey,
                      )
                    : const SizedBox.shrink(),
              ),
              hintText: widget.hintText,
              hintStyle:
                  widget.hintStyle ?? const TextStyle(color: Color(0xffBFBFBF), fontSize: 12),
              isDense: true,
              filled: true,
              fillColor: const Color(0xffF4F4F4),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5), borderSide: BorderSide.none),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5), borderSide: BorderSide.none),
            ),
          ),
        )
      ],
    );
  }
}
