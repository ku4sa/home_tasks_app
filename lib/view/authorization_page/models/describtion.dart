import 'package:formz/formz.dart';

final class Describtion extends FormzInput<String, String> {
  const Describtion.pure([super.value = '']) : super.pure();
  const Describtion.dirty([super.value = '']) : super.dirty();

  static final RegExp regex = RegExp(
      r'''^[А-Яа-яa-zA-ZЁё0-9][ А-Яа-яa-zA-ZЁё0-9_.!'"#$%&(),+-:;/<\=>?@`{|}~^*\/\[\]\\]*$''');

  @override
  String? validator(String? value) {
   if (value!=null && value.length > 50) {
      return "Название слишком длинное слишком длинное";
    } else if (value!=null && regex.hasMatch(value)) {
      return null;
    } else {
      return "Может содержать только латинницу, кириллицу и специальные символы";
    }
  }
}
