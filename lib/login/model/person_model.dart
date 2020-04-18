class PersonModel {
  String cardno;
  String personname;

  PersonModel({this.cardno, this.personname});

  PersonModel.fromJson(Map<String, dynamic> json) {
    cardno = json['cardno'];
    personname = json['personname'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cardno'] = this.cardno;
    data['personname'] = this.personname;
    return data;
  }
}