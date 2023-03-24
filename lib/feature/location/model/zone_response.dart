class ZoneResponseModel {
  bool _isSuccess;
  String _zoneId;
  String? _message;
  ZoneResponseModel(this._isSuccess, this._message, this._zoneId);

  String? get message => _message;
  String get zoneIds => _zoneId;
  bool get isSuccess => _isSuccess;
}
