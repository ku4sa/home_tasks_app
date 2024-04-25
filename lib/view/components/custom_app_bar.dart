import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:home_tasks_app/theme/src/colors.dart';
import 'package:home_tasks_app/theme/src/textstyle.dart';

class MyAppBar extends StatelessWidget {
  const MyAppBar({
    super.key,
    this.canGoBack = false,
    this.onTapSettings,
    this.onTapStatistic,
    this.valuesOfSearchBar,
    this.haveButtons = false,
    required this.title,
    this.haveAddButton = false,
    this.onExit,
    this.style,
    this.underTitle,
    this.onExitWithSave,
  });
  final bool haveAddButton;
  final bool canGoBack;
  final TextStyle? style;
  final bool haveButtons;
  final void Function()? onExit;
  final void Function()? onExitWithSave;
  final void Function()? onTapSettings;
  final void Function()? onTapStatistic;
  final List<String>? valuesOfSearchBar;
  final Widget? underTitle;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      color: AppColors.lightBlue,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (canGoBack)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: IconButton(
                onPressed: onExit,
                icon: Icon(
                  Icons.arrow_back,
                  color: AppColors.white,
                ),
              ),
            ),
          if (haveButtons)
            Expanded(
              flex: 1,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: onTapSettings,
                    icon: SvgPicture.asset('assets/icons/settings_fill.svg'),
                  ),
                  IconButton(
                      onPressed: onTapStatistic,
                      icon: Icon(
                        Icons.stacked_bar_chart,
                        color: AppColors.white,
                      ))
                ],
              ),
            ),
          Expanded(
            flex: 4,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: style ?? AppTextStyles.headerStyle.copyWith(height: 1),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 20.0, top: 8),
                  child: underTitle ?? const SizedBox(),
                ),
              ],
            ),
          ),
          if (haveAddButton)
            Expanded(
              flex: 1,
              child: Container(
                color: AppColors.green,
                child: IconButton(
                  onPressed: onExitWithSave,
                  icon: Icon(
                    Icons.check,
                    color: AppColors.white,
                  ),
                ),
              ),
            )
        ],
      ),
    );
  }
}
