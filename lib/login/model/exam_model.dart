class ExamModel {
  String examsubject;
  String examtypename;
  String examid;
  String exampic;

  ExamModel({this.examsubject, this.examtypename, this.examid, this.exampic});

  ExamModel.fromJson(Map<String, dynamic> json) {
    examsubject = json['examsubject'];
    examtypename = json['examtypename'];
    examid = json['examid'];
    exampic = json['exampic'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['examsubject'] = this.examsubject;
    data['examtypename'] = this.examtypename;
    data['examid'] = this.examid;
    data['exampic'] = this.exampic;
    return data;
  }
}