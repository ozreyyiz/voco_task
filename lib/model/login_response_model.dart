class LoginResponseModel {
  String? token;
  String? error;

  LoginResponseModel({this.token, this.error});

  LoginResponseModel.fromJson(Map<String, dynamic> json) {
    token = json['token']!= null? json['token']:"";
    error = json['error']!= null? json['error']:"";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['token'] = token;
    data['error'] = error;
    return data;
  }
}
