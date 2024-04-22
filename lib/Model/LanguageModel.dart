class LanguageModel {
  LanguageModel({
      bool? status, 
      List<Data>? data, 
      bool? success,}){
    _status = status;
    _data = data;
    _success = success;
}

  LanguageModel.fromJson(dynamic json) {
    _status = json['status'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(Data.fromJson(v));
      });
    }
    _success = json['success'];
  }
  bool? _status;
  List<Data>? _data;
  bool? _success;
LanguageModel copyWith({  bool? status,
  List<Data>? data,
  bool? success,
}) => LanguageModel(  status: status ?? _status,
  data: data ?? _data,
  success: success ?? _success,
);
  bool? get status => _status;
  List<Data>? get data => _data;
  bool? get success => _success;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    map['success'] = _success;
    return map;
  }

}

class Data {
  Data({
      num? id, 
      String? name,}){
    _id = id;
    _name = name;
}

  Data.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
  }
  num? _id;
  String? _name;
Data copyWith({  num? id,
  String? name,
}) => Data(  id: id ?? _id,
  name: name ?? _name,
);
  num? get id => _id;
  String? get name => _name;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    return map;
  }

}