class InserModel {
  String? firstName;
  String? lastName;
  int? age;

  InserModel({this.firstName, this.lastName, this.age});

  InserModel.fromJson(Map<String, dynamic> json) {
    firstName = json['firstName'];
    lastName = json['lastName'];
    age = json['age'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['first'] = firstName;
    data['last'] = lastName;
    data['age'] = age;
    return data;
  }
}
