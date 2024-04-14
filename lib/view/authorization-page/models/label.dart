import 'package:formz/formz.dart';

final class Label extends FormzInput<String, String> {
  const Label.pure([super.value = '']) : super.pure();
  const Label.dirty([super.value = '']) : super.dirty();

  static final RegExp regex = RegExp(
      r'''^[А-Яа-яa-zA-ZЁё0-9][ А-Яа-яa-zA-ZЁё0-9_.!'"#$%&(),+-:;/<\=>?@`{|}~^*\/\[\]\\]*$''');

  @override
  String? validator(String? value) {
    if (value == null || value.isEmpty) {
      return "Название слишком короткое";
    } else if (value.length > 50) {
      return "Название слишком длинное слишком длинное";
    } else if (regex.hasMatch(value)) {
      return null;
    } else {
      return "Может содержать только латинницу, кириллицу и специальные символы";
    }
  }
}
