class AppException {
  final int code;
  final String? message;
  AppException(this.code, {this.message});

  String getMessage() {
    switch (code) {
      case 500:
        return message ?? "Глобавльная ошибка";
      case 401:
        return message ?? "Не авторизован";
      case 404:
        return message ?? "Не найдено";
      case 400:
        return message ?? "Некорректные данные";
      default:
        return message ?? "Ошибка без кода";
    }
  }
}
