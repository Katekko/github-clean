import 'package:ekko/domain/core/exceptions/default.exception.dart';

class InternetFailedException extends DefaultException {
  InternetFailedException({
    String message = 'Falha na conexão, verifique sua internet!',
  }) : super(message: message);
}
