class Global {
  String randomCode = '';
  String cardNumber = '';
  String personName = '';
  List exam = [];

  factory Global() => _getInstance();
  static Global get instance => _getInstance();
  static Global _instance;
  Global._internal() {
    // 初始化
  }
  static Global _getInstance() {
    if (_instance == null) {
      _instance = new Global._internal();
    }
    return _instance;
  }
}
