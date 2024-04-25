class Validator {
  static final RegExp _describtionAndNameRegex = RegExp(
      r'''^[А-Яа-яa-zA-ZЁё0-9][ А-Яа-яa-zA-ZЁё0-9_.!'"#$%&(),+-:;/<\=>?@`{|}~^*\/\[\]\\]*$''');

  static String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return "Название слишком короткое";
    } else if (value.length > 50) {
      return "Название слишком длинное слишком длинное";
    } else if (_describtionAndNameRegex.hasMatch(value)) {
      return null;
    } else {
      return "Может содержать только латинницу, кириллицу и специальные символы";
    }
  }

  static String? validateDescription(String? value) {
    if (value != null && value.length > 50) {
      return "Название слишком длинное слишком длинное";
    } else if (value != null && _describtionAndNameRegex.hasMatch(value)) {
      return null;
    } else if (value == null || value.isEmpty) {
      return null;
    } else {
      return "Может содержать только латинницу, кириллицу и специальные символы";
    }
  }
}
