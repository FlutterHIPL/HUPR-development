class DriverProfileModel {
  DriverProfileModel({
    bool? status,
    String? message,
    Data? data,
    bool? success,
  }) {
    _status = status;
    _message = message;
    _data = data;
    _success = success;
  }

  DriverProfileModel.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
    _success = json['success'];
  }
  bool? _status;
  String? _message;
  Data? _data;
  bool? _success;
  DriverProfileModel copyWith({
    bool? status,
    String? message,
    Data? data,
    bool? success,
  }) =>
      DriverProfileModel(
        status: status ?? _status,
        message: message ?? _message,
        data: data ?? _data,
        success: success ?? _success,
      );
  bool? get status => _status;
  String? get message => _message;
  Data? get data => _data;
  bool? get success => _success;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['message'] = _message;
    if (_data != null) {
      map['data'] = _data?.toJson();
    }
    map['success'] = _success;
    return map;
  }
}

class Data {
  Data({
    num? id,
    num? languageId,
    String? firstName,
    String? lastName,
    String? role,
    String? email,
    String? mobileNumber,
    dynamic otp,
    dynamic emailVerifiedAt,
    String? status,
    String? createdAt,
    String? updatedAt,
    dynamic deletedAt,
    Profile? profile,
    List<Kyc>? kyc,
    List<Vehicle>? vehicle,
  }) {
    _id = id;
    _languageId = languageId;
    _firstName = firstName;
    _lastName = lastName;
    _role = role;
    _email = email;
    _mobileNumber = mobileNumber;
    _otp = otp;
    _emailVerifiedAt = emailVerifiedAt;
    _status = status;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _deletedAt = deletedAt;
    _profile = profile;
    _kyc = kyc;
    _vehicle = vehicle;
  }

  Data.fromJson(dynamic json) {
    _id = json['id'];
    _languageId = json['language_id'];
    _firstName = json['first_name'];
    _lastName = json['last_name'];
    _role = json['role'];
    _email = json['email'];
    _mobileNumber = json['mobile_number'];
    _otp = json['otp'];
    _emailVerifiedAt = json['email_verified_at'];
    _status = json['status'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    _deletedAt = json['deleted_at'];
    _profile =
        json['profile'] != null ? Profile.fromJson(json['profile']) : null;
    if (json['kyc'] != null) {
      _kyc = [];
      json['kyc'].forEach((v) {
        _kyc?.add(Kyc.fromJson(v));
      });
    }
    if (json['vehicle'] != null) {
      _vehicle = [];
      json['vehicle'].forEach((v) {
        _vehicle?.add(Vehicle.fromJson(v));
      });
    }
  }
  num? _id;
  num? _languageId;
  String? _firstName;
  String? _lastName;
  String? _role;
  String? _email;
  String? _mobileNumber;
  dynamic _otp;
  dynamic _emailVerifiedAt;
  String? _status;
  String? _createdAt;
  String? _updatedAt;
  dynamic _deletedAt;
  Profile? _profile;
  List<Kyc>? _kyc;
  List<Vehicle>? _vehicle;
  Data copyWith({
    num? id,
    num? languageId,
    String? firstName,
    String? lastName,
    String? role,
    String? email,
    String? mobileNumber,
    dynamic otp,
    dynamic emailVerifiedAt,
    String? status,
    String? createdAt,
    String? updatedAt,
    dynamic deletedAt,
    Profile? profile,
    List<Kyc>? kyc,
    List<Vehicle>? vehicle,
  }) =>
      Data(
        id: id ?? _id,
        languageId: languageId ?? _languageId,
        firstName: firstName ?? _firstName,
        lastName: lastName ?? _lastName,
        role: role ?? _role,
        email: email ?? _email,
        mobileNumber: mobileNumber ?? _mobileNumber,
        otp: otp ?? _otp,
        emailVerifiedAt: emailVerifiedAt ?? _emailVerifiedAt,
        status: status ?? _status,
        createdAt: createdAt ?? _createdAt,
        updatedAt: updatedAt ?? _updatedAt,
        deletedAt: deletedAt ?? _deletedAt,
        profile: profile ?? _profile,
        kyc: kyc ?? _kyc,
        vehicle: vehicle ?? _vehicle,
      );
  num? get id => _id;
  num? get languageId => _languageId;
  String? get firstName => _firstName;
  String? get lastName => _lastName;
  String? get role => _role;
  String? get email => _email;
  String? get mobileNumber => _mobileNumber;
  dynamic get otp => _otp;
  dynamic get emailVerifiedAt => _emailVerifiedAt;
  String? get status => _status;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  dynamic get deletedAt => _deletedAt;
  Profile? get profile => _profile;
  List<Kyc>? get kyc => _kyc;
  List<Vehicle>? get vehicle => _vehicle;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['language_id'] = _languageId;
    map['first_name'] = _firstName;
    map['last_name'] = _lastName;
    map['role'] = _role;
    map['email'] = _email;
    map['mobile_number'] = _mobileNumber;
    map['otp'] = _otp;
    map['email_verified_at'] = _emailVerifiedAt;
    map['status'] = _status;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    map['deleted_at'] = _deletedAt;
    if (_profile != null) {
      map['profile'] = _profile?.toJson();
    }
    if (_kyc != null) {
      map['kyc'] = _kyc?.map((v) => v.toJson()).toList();
    }
    if (_vehicle != null) {
      map['vehicle'] = _vehicle?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class Vehicle {
  Vehicle({
    num? id,
    num? userId,
    String? plateNumber,
    num? productionYear,
    num? vehicleModelId,
    num? vehicleColorId,
    String? status,
    String? createdAt,
    String? updatedAt,
    dynamic deletedAt,
  }) {
    _id = id;
    _userId = userId;
    _plateNumber = plateNumber;
    _productionYear = productionYear;
    _vehicleModelId = vehicleModelId;
    _vehicleColorId = vehicleColorId;
    _status = status;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _deletedAt = deletedAt;
  }

  Vehicle.fromJson(dynamic json) {
    _id = json['id'];
    _userId = json['user_id'];
    _plateNumber = json['plate_number'];
    _productionYear = json['production_year'];
    _vehicleModelId = json['vehicle_model_id'];
    _vehicleColorId = json['vehicle_color_id'];
    _status = json['status'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    _deletedAt = json['deleted_at'];
  }
  num? _id;
  num? _userId;
  String? _plateNumber;
  num? _productionYear;
  num? _vehicleModelId;
  num? _vehicleColorId;
  String? _status;
  String? _createdAt;
  String? _updatedAt;
  dynamic _deletedAt;
  Vehicle copyWith({
    num? id,
    num? userId,
    String? plateNumber,
    num? productionYear,
    num? vehicleModelId,
    num? vehicleColorId,
    String? status,
    String? createdAt,
    String? updatedAt,
    dynamic deletedAt,
  }) =>
      Vehicle(
        id: id ?? _id,
        userId: userId ?? _userId,
        plateNumber: plateNumber ?? _plateNumber,
        productionYear: productionYear ?? _productionYear,
        vehicleModelId: vehicleModelId ?? _vehicleModelId,
        vehicleColorId: vehicleColorId ?? _vehicleColorId,
        status: status ?? _status,
        createdAt: createdAt ?? _createdAt,
        updatedAt: updatedAt ?? _updatedAt,
        deletedAt: deletedAt ?? _deletedAt,
      );
  num? get id => _id;
  num? get userId => _userId;
  String? get plateNumber => _plateNumber;
  num? get productionYear => _productionYear;
  num? get vehicleModelId => _vehicleModelId;
  num? get vehicleColorId => _vehicleColorId;
  String? get status => _status;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  dynamic get deletedAt => _deletedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['user_id'] = _userId;
    map['plate_number'] = _plateNumber;
    map['production_year'] = _productionYear;
    map['vehicle_model_id'] = _vehicleModelId;
    map['vehicle_color_id'] = _vehicleColorId;
    map['status'] = _status;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    map['deleted_at'] = _deletedAt;
    return map;
  }
}

class Kyc {
  Kyc({
    num? id,
    num? userId,
    String? bankName,
    String? routingNumber,
    String? accountNumber,
    String? swiftCode,
    String? status,
    String? createdAt,
    String? updatedAt,
    dynamic deletedAt,
  }) {
    _id = id;
    _userId = userId;
    _bankName = bankName;
    _routingNumber = routingNumber;
    _accountNumber = accountNumber;
    _swiftCode = swiftCode;
    _status = status;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _deletedAt = deletedAt;
  }

  Kyc.fromJson(dynamic json) {
    _id = json['id'];
    _userId = json['user_id'];
    _bankName = json['bank_name'];
    _routingNumber = json['routing_number'];
    _accountNumber = json['account_number'];
    _swiftCode = json['swift_code'];
    _status = json['status'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    _deletedAt = json['deleted_at'];
  }
  num? _id;
  num? _userId;
  String? _bankName;
  String? _routingNumber;
  String? _accountNumber;
  String? _swiftCode;
  String? _status;
  String? _createdAt;
  String? _updatedAt;
  dynamic _deletedAt;
  Kyc copyWith({
    num? id,
    num? userId,
    String? bankName,
    String? routingNumber,
    String? accountNumber,
    String? swiftCode,
    String? status,
    String? createdAt,
    String? updatedAt,
    dynamic deletedAt,
  }) =>
      Kyc(
        id: id ?? _id,
        userId: userId ?? _userId,
        bankName: bankName ?? _bankName,
        routingNumber: routingNumber ?? _routingNumber,
        accountNumber: accountNumber ?? _accountNumber,
        swiftCode: swiftCode ?? _swiftCode,
        status: status ?? _status,
        createdAt: createdAt ?? _createdAt,
        updatedAt: updatedAt ?? _updatedAt,
        deletedAt: deletedAt ?? _deletedAt,
      );
  num? get id => _id;
  num? get userId => _userId;
  String? get bankName => _bankName;
  String? get routingNumber => _routingNumber;
  String? get accountNumber => _accountNumber;
  String? get swiftCode => _swiftCode;
  String? get status => _status;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  dynamic get deletedAt => _deletedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['user_id'] = _userId;
    map['bank_name'] = _bankName;
    map['routing_number'] = _routingNumber;
    map['account_number'] = _accountNumber;
    map['swift_code'] = _swiftCode;
    map['status'] = _status;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    map['deleted_at'] = _deletedAt;
    return map;
  }
}

class Profile {
  Profile({
    num? id,
    num? userId,
    String? gender,
    String? address,
    dynamic dlNumber,
    String? createdAt,
    String? updatedAt,
  }) {
    _id = id;
    _userId = userId;
    _gender = gender;
    _address = address;
    _dlNumber = dlNumber;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
  }

  Profile.fromJson(dynamic json) {
    _id = json['id'];
    _userId = json['user_id'];
    _gender = json['gender'];
    _address = json['address'];
    _dlNumber = json['dl_number'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
  }
  num? _id;
  num? _userId;
  String? _gender;
  String? _address;
  dynamic _dlNumber;
  String? _createdAt;
  String? _updatedAt;
  Profile copyWith({
    num? id,
    num? userId,
    String? gender,
    String? address,
    dynamic dlNumber,
    String? createdAt,
    String? updatedAt,
  }) =>
      Profile(
        id: id ?? _id,
        userId: userId ?? _userId,
        gender: gender ?? _gender,
        address: address ?? _address,
        dlNumber: dlNumber ?? _dlNumber,
        createdAt: createdAt ?? _createdAt,
        updatedAt: updatedAt ?? _updatedAt,
      );
  num? get id => _id;
  num? get userId => _userId;
  String? get gender => _gender;
  String? get address => _address;
  dynamic get dlNumber => _dlNumber;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['user_id'] = _userId;
    map['gender'] = _gender;
    map['address'] = _address;
    map['dl_number'] = _dlNumber;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    return map;
  }
}
