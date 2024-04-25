import 'package:flutter/material.dart';
import 'package:formz/formz.dart';
import 'package:home_tasks_app/theme/src/colors.dart';
import 'package:home_tasks_app/theme/src/textstyle.dart';
import 'package:home_tasks_app/view/components/custom_app_bar.dart';
import 'package:home_tasks_app/view/components/custom_text_field.dart';
import 'package:home_tasks_app/view/components/text_button.dart';

import '../authorization_page/models/username.dart';

class FindUser extends StatefulWidget {
  const FindUser({super.key});

  @override
  State<FindUser> createState() => _FindUserState();
}

class _FindUserState extends State<FindUser> {
  Username input = Username.pure();
  String? user;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      titlePadding: EdgeInsets.zero,
      title: Container(
        height: 75,
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
            color: AppColors.lightBlue),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: MyAppBar(
            style: AppTextStyles.nameForGroup,
            canGoBack: true,
            title: 'Предоставление доступа',
            onExit: () => Navigator.pop(context, null),
          ),
        ),
      ),
      content: CustomTextField(
        label: "Имя пользователя",
        formzInput: input,
        hInt: "",
        onChanged: (p0) {
          user = p0;
          input = Username.dirty(p0);
          Formz.validate([input]);
          setState(() {});
        },
        onTapSuffixIcon: (p0) {
          user = "";
          input = Username.pure(user!);
          Formz.validate([input]);
          setState(() {});
        },
      ),
      actionsAlignment: MainAxisAlignment.center,
      actions: [
        MyTextButton(
          text: 'Ок',
          onPressed: user != null && user!.isNotEmpty && Formz.validate([input])
              ? () => Navigator.pop(context, user)
              : null,
        )
      ],
    );
  }
}
