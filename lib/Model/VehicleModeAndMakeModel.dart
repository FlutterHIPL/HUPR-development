class VehicleModeAndMakeModel {
  VehicleModeAndMakeModel({
      bool? status, 
      num? code, 
      List<Data>? data,}){
    _status = status;
    _code = code;
    _data = data;
}

  VehicleModeAndMakeModel.fromJson(dynamic json) {
    _status = json['status'];
    _code = json['code'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(Data.fromJson(v));
      });
    }
  }
  bool? _status;
  num? _code;
  List<Data>? _data;
VehicleModeAndMakeModel copyWith({  bool? status,
  num? code,
  List<Data>? data,
}) => VehicleModeAndMakeModel(  status: status ?? _status,
  code: code ?? _code,
  data: data ?? _data,
);
  bool? get status => _status;
  num? get code => _code;
  List<Data>? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['code'] = _code;
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
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