import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:home_tasks_app/theme/src/colors.dart';
import 'package:home_tasks_app/theme/src/textstyle.dart';

import 'package:go_router/go_router.dart';

class NavigationPage extends StatelessWidget {
  const NavigationPage({
    required this.navigationShell,
    super.key,
  });
  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    print('build ScaffoldWithBottomNavBar');
    return Scaffold(
        body: navigationShell,
        bottomNavigationBar: BottomNavigationBar(
          
          backgroundColor: AppColors.lightBlue,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Container(
                width: 85, 
                height: 75,
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                //  clipBehavior: Clip.antiAlias,
                decoration: (navigationShell.currentIndex == 0)
                    ? ShapeDecoration(
                        color: AppColors.darkBlue,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                      )
                    : null,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset('assets/icons/home.svg'),
                    Text(
                      'Главная',
                      style: navigationShell.currentIndex == 0
                          ? AppTextStyles.navBarTextStyle
                              .copyWith(color: AppColors.yellow)
                          : AppTextStyles.navBarTextStyle,
                    )
                  ],
                ),
              ),
              label: "",
            ),
            BottomNavigationBarItem(
              icon: Container(
                width: 85,
                height: 75,
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                // clipBehavior: Clip.antiAlias,
                decoration: (navigationShell.currentIndex == 1)
                    ? ShapeDecoration(
                        color: AppColors.darkBlue,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                      )
                    : null,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset('assets/icons/plans.svg'),
                    Text(
                      'План',
                      style: navigationShell.currentIndex == 1
                          ? AppTextStyles.navBarTextStyle
                              .copyWith(color: AppColors.yellow)
                          : AppTextStyles.navBarTextStyle,
                    )
                  ],
                ),
              ),
              label: "",
            ),
            BottomNavigationBarItem(
              icon: Container(
                width: 85,
                height: 75,
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                //   clipBehavior: Clip.antiAlias,
                decoration: (navigationShell.currentIndex == 2)
                    ? ShapeDecoration(
                        color: AppColors.darkBlue,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                      )
                    : null,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset('assets/icons/settings.svg'),
                    Text(
                      'Настройки',
                      style: navigationShell.currentIndex == 2
                          ? AppTextStyles.navBarTextStyle
                              .copyWith(color: AppColors.yellow)
                          : AppTextStyles.navBarTextStyle,
                    )
                  ],
                ),
              ),
              label: "",
            ),
          ],
          currentIndex: navigationShell.currentIndex,
          onTap: (int index) => _onTap(context, index),
        ));
  }

  void _onTap(BuildContext context, int index) {
    navigationShell.goBranch(
      index,
      initialLocation: index == navigationShell.currentIndex,
    );
  }
}
