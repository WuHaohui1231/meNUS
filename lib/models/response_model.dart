class ResponseModel {
  bool _ifSuccess;
  String _message;
  ResponseModel(
    this._ifSuccess,
    this._message,
  );
  String get message => _message;
  bool get ifSuccess => _ifSuccess;
}
