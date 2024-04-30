import "package:flutter/material.dart";
import "package:flutter_svg/flutter_svg.dart";
import "package:home_tasks_app/repositories/models/data_model.dart";
import "package:home_tasks_app/theme/src/colors.dart";
import "package:home_tasks_app/theme/src/textstyle.dart";

class MyDropDownButton extends StatefulWidget {
  final DataModel? selectedValue;
  final bool setDefault;
  final bool haveBorder;
  final List<DataModel> content;
  final void Function(DataModel) onChanged;
  const MyDropDownButton({
    super.key,
    this.haveBorder = false,
    required this.content,
    this.setDefault = false,
    this.selectedValue,
    required this.onChanged,
  });

  @override
  State<MyDropDownButton> createState() => _MyDropDownButtonState();
}

class _MyDropDownButtonState extends State<MyDropDownButton> {
  DataModel? _selectedItem;

  @override
  void initState() {
    _selectedItem = widget.selectedValue;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(5),
          border: Border.all(
            color:
                !widget.haveBorder ? AppColors.darkWhite : AppColors.lightBlue,
            width: 2,
          )),
      child: DropdownButton<DataModel>(
        alignment: Alignment.bottomCenter,
        value:
            _selectedItem ?? (widget.setDefault ? widget.content.first : null),
        underline: const SizedBox(),
        selectedItemBuilder: (context) => widget.content.map(
          (DataModel item) {
            return DropdownMenuItem<DataModel>(
              value: item,
              child: Text(
                item.getName(),
                style: AppTextStyles.headerName,
              ),
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
        items: widget.content.map(
          (DataModel item) {
            return DropdownMenuItem<DataModel>(
              value: item,
              alignment: Alignment.centerLeft,
              child: Text(
                item.getName(),
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
