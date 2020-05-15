class Global {
  String randomCode = '';
  String cardNumber = '';
  String personName = '';
  List exam = [];

  List allQuestions = [];


  String selectedType = '';//选择的考试类型
  Map selectedExam = {};//选择的考试科目
//  String examId = '';
//  String examSubject = '';
//  String examName = '';
//  String examPic = '';
  Map selectedPaper = {};//选择的试卷

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
