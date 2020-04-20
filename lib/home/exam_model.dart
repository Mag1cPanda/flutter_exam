class ExamTypeModel {
  String examtype;
  String examtypename;
  List subjectList = [];

  ExamTypeModel(this.examtype, this.examtypename);

  ExamTypeModel.fromJson(Map<String, dynamic> json) {
    examtype = json['examtype'];
    examtypename = json['examtypename'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['examtype'] = this.examtype;
    data['examtypename'] = this.examtypename;
    return data;
  }
}

class ExamSubjectModel {
  String examsubject;
  String examtypename;
  String examid;
  String exampic;
  bool selected = false;

  ExamSubjectModel(this.examsubject, this.examtypename, this.examid, this.exampic);

  ExamSubjectModel.fromJson(Map<String, dynamic> json) {
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