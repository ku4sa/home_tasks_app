import "package:flutter/material.dart";
import "package:flutter_svg/flutter_svg.dart";
import "package:home_tasks_app/repositories/models/group_of_rooms/group_of_rooms.dart";
import "package:home_tasks_app/theme/src/colors.dart";
import "package:home_tasks_app/theme/src/textstyle.dart";

class MyDropDownButton extends StatefulWidget {
  final GroupOfRooms? selectedGroupOfRoom;
  final List<GroupOfRooms> groupes;
  final void Function(GroupOfRooms) onChanged;
  const MyDropDownButton({
    super.key,
    required this.groupes,
    this.selectedGroupOfRoom,
    required this.onChanged,
  });

  @override
  State<MyDropDownButton> createState() => _MyDropDownButtonState();
}

class _MyDropDownButtonState extends State<MyDropDownButton> {
  GroupOfRooms? _selectedItem;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: AppColors.white,
          border: Border.all(
            color: AppColors.darkWhite,
            width: 2,
          )),
      child: DropdownButton<GroupOfRooms>(
        alignment: Alignment.bottomCenter,
        value: _selectedItem ?? widget.selectedGroupOfRoom,
        underline: const SizedBox(),
        selectedItemBuilder: (context) => widget.groupes.map(
          (GroupOfRooms item) {
            return DropdownMenuItem<GroupOfRooms>(
              value: item,
              child: Text(item.name, style: AppTextStyles.headerName),
            );
          },
        ).toList(),
        icon: SvgPicture.asset('assets/icons/arrow_bottom.svg'),
        elevation: 12,
        dropdownColor: AppColors.white,
        isExpanded: true,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        style: AppTextStyles.headerName,
        borderRadius: const BorderRadius.all(Radius.circular(5)),
        items: widget.groupes.map(
          (GroupOfRooms item) {
            return DropdownMenuItem<GroupOfRooms>(
              value: item,
              alignment: Alignment.centerLeft,
              child: Text(
                item.name,
                style: AppTextStyles.baseText.copyWith(
                  fontSize: 15,
                  color: _selectedItem == item
                      ? AppColors.lightBlue
                      : AppColors.black,
                ),
              ),
            );
          },
        ).toList(),
        onChanged: (value) {
          if (value != null) {
            widget.onChanged(value);
            setState(
              () {
                _selectedItem = value;
              },
            );
          }
        },
      ),
    );
  }
}
