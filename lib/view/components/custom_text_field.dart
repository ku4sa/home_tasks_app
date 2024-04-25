import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:formz/formz.dart';
import 'package:home_tasks_app/theme/src/textstyle.dart';

class CustomTextField extends StatefulWidget {
  final bool isPassword;
  final Color? filledColor;
  final bool isSearch;
  final bool obscureText;
  final String label;
  final FocusNode? focusNode;
  final String? initialValue;
  final FormzInput? formzInput;
  final int maxLines;
  final String hInt;
  final String? icon;
  final String suffixIcon;
  final String? text;
  final String? secondSuffixIcon;
  final void Function(String?)? onTapSuffixIcon;
  final void Function(String) onChanged;

  const CustomTextField({
    super.key,
    this.focusNode,
    this.icon,
    required this.label,
    this.text,
    this.isPassword = false,
    this.isSearch = false,
    this.obscureText = false,
    this.secondSuffixIcon,
    this.initialValue,
    required this.formzInput,
    this.maxLines = 1,
    required this.hInt,
    this.suffixIcon = 'assets/icons/clear.svg',
    this.onTapSuffixIcon,
    required this.onChanged,
    this.filledColor,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  late bool obscureText;
  late TextEditingController controller;
  Timer? _timer;
  String? showError;

  void validate() {
    setState(() {
      if (widget.formzInput != null) {
        Formz.validate([widget.formzInput!]);
      }
    });
  }

  @override
  void initState() {
    controller = TextEditingController(
      text: widget.initialValue,
    );
    controller.addListener(
      () {
        _timer?.cancel();
        _timer = Timer.periodic(
          const Duration(milliseconds: 500),
          (timer) {
            widget.onChanged(controller.text);
            validate();
            _timer?.cancel();
          },
        );
      },
    );
    obscureText = widget.obscureText;
    super.initState();
  }

  @override
  void dispose() {
    _timer?.cancel();
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      style: AppTextStyles.bigText.copyWith(height: 1.5),
      focusNode: widget.focusNode,
      maxLines: widget.maxLines,
      obscureText: obscureText,
      onChanged: (value) {
        _timer?.cancel();
        _timer = Timer.periodic(
          const Duration(milliseconds: 500),
          (timer) {
            widget.onChanged(controller.text);

            validate();
            _timer?.cancel();
          },
        );
      },
      decoration: InputDecoration(
          fillColor: widget.filledColor,
          filled: widget.filledColor != null,
          errorText: widget.formzInput?.error,
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
          border: const OutlineInputBorder(),
          suffixIcon: widget.isPassword || controller.value.text.isNotEmpty
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
                        controller.clear();
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
              : null),
    );
  }
}
