import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:home_tasks_app/theme/src/colors.dart';
import 'package:home_tasks_app/theme/src/textstyle.dart';

class MyCustomTextField extends StatefulWidget {
  final bool readOnly;
  final bool isPassword;
  final Color? filledColor;
  final bool isSearch;
  final bool obscureText;
  final TextEditingController controller;
  final String? label;
  final String? initialValue;
  final int maxLines;
  final TextAlign textAlign;
  final String hInt;
  final String? icon;
  final String suffixIcon;
  final String? text;
  final String? secondSuffixIcon;
  final void Function(String?)? onTapSuffixIcon;
  final void Function(String) onChanged;
  final String? Function(String?)? validator;

  const MyCustomTextField({
    super.key,
    this.textAlign = TextAlign.start,
    this.icon,
    this.readOnly = true,
    required this.controller,
    this.label,
    this.text,
    this.isPassword = false,
    this.isSearch = false,
    this.obscureText = false,
    this.secondSuffixIcon,
    this.initialValue,
    this.maxLines = 1,
    required this.hInt,
    this.suffixIcon = 'assets/icons/clear.svg',
    this.onTapSuffixIcon,
    required this.onChanged,
    this.filledColor,
    this.validator,
  });

  @override
  State<MyCustomTextField> createState() => _MyCustomTextFieldState();
}

class _MyCustomTextFieldState extends State<MyCustomTextField> {
  String value = "";
  String? error;
  late bool obscureText;
  Timer? _timer;
  String? showError;

  void validate() {
    if (widget.validator != null) {
      setState(() {
        error = widget.validator!(widget.controller.text);
      });
    }
  }

  void changeValue(String v) {
    validate();
    _timer?.cancel();
    _timer = Timer.periodic(
      const Duration(milliseconds: 500),
      (timer) {
        widget.onChanged(widget.controller.text);
        _timer?.cancel();
      },
    );
  }

  @override
  void initState() {
    obscureText = widget.obscureText;
    super.initState();
  }

  @override
  void dispose() {
    _timer?.cancel();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      readOnly: widget.readOnly,
      controller: widget.controller,
      style: AppTextStyles.bigText.copyWith(height: 1.5),
      maxLines: widget.maxLines,
      textAlign: widget.textAlign,
      obscureText: obscureText,
      onChanged: (value) {
        changeValue(value);
      },
      
      decoration: InputDecoration(
        fillColor: widget.filledColor,
        filled: widget.filledColor != null,
        errorText: error,
        errorMaxLines: 3,
        helperMaxLines: 3,
        hintText: widget.text,
     
        labelText: widget.label,
        labelStyle: AppTextStyles.smallText,
        prefixIcon: widget.icon != null
            ? Padding(
                padding: const EdgeInsets.only(
                  bottom: 8,
                  top: 8,
                  left: 10,
                  right: 20,
                ),
                child: SvgPicture.asset(
                  widget.icon!,
                ),
              )
            : null,
        errorBorder: border(AppColors.red, 1.5),
        focusedBorder: border(AppColors.darkBlue, 2),
        enabledBorder: border(AppColors.lightBlue, 1.5),
        focusedErrorBorder: border(AppColors.red, 2),
        suffixIcon: widget.isPassword || value.isNotEmpty
            ? IconButton(
                isSelected: obscureText,
                selectedIcon: widget.secondSuffixIcon != null
                    ? SvgPicture.asset(
                        widget.secondSuffixIcon!,
                        fit: BoxFit.fill,
                      )
                    : null,
                onPressed: () {
                  if (widget.isPassword) {
                    setState(() {
                      obscureText = !obscureText;
                    });
                  } else {
                    setState(() {
                      widget.controller.clear();
                      _timer?.cancel();
                    });
                  }
                },
                icon: SvgPicture.asset(widget.suffixIcon),
                tooltip: widget.isPassword
                    ? obscureText
                        ? "Показать пароль"
                        : "Скрыть пароль"
                    : "Отчистить",
              )
            : null,
      ),
    );
  }

  OutlineInputBorder border(
    Color color,
    double width,
  ) {
    return OutlineInputBorder(
      borderRadius: const BorderRadius.all(Radius.circular(
        5,
      )),
      borderSide: BorderSide(
        color: color,
        width: width,
      ),
    );
  }
}
