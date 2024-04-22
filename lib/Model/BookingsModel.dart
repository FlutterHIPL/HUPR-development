

import 'dart:ffi';

class BookinsModel {

bool? status;
bool? success;
List<Data> data;


 BookinsModel({required this.status, required this.success,required this.data}); 


 factory BookinsModel.fromJson(Map<String, dynamic> json) => BookinsModel(
    status: json["status"],
    success: json["success"],
    data: List<Data>.from(json["data"].map((x) => Data.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "success": success,
    "data": data,

  };

}

class Data{

 int? id;
 int? customer_id;
 String? pickup_date;
 String? pickup_time;
 String?pickup_location;
 var  pickup_latitude;
 var pickup_longitude;
 String  dropoff_location;
 var  dropoff_latitude;
 var dropoff_longitude;
 int ?duration_minutes;
 String? distance_km;
 int? duration_on_map_minutes;
 String? currency;
 String?fare_price;
 String?comment;
 String?status;
 String? created_at;
 String? updated_at;
 String? deleted_at;
 User ?user;


Data({required this.id,
required this.customer_id,
required this.pickup_date,
required this.pickup_time,
required this.pickup_location,
required this.pickup_latitude,
required this.pickup_longitude,
required this.dropoff_location,
required this.dropoff_latitude,
required this.dropoff_longitude,
required this.duration_minutes,
required this.distance_km,
required this.duration_on_map_minutes,
required this.currency,
required this.fare_price,
required this.comment,
required this.status,
required this.created_at,
required this.updated_at,
required this.deleted_at,
required this.user,

}); 
factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"],
    customer_id: json["customer_id"],
    pickup_date: json["pickup_date"],
    pickup_time: json["pickup_time"],
      pickup_location: json["pickup_location"], 
      pickup_latitude: json["pickup_latitude"],
       pickup_longitude: json["pickup_longitude"], 
       dropoff_location: json["dropoff_location"], 
       dropoff_latitude: json["dropoff_latitude"], 
       dropoff_longitude: json["dropoff_longitude"], 
       duration_minutes: json["duration_minutes"], 
       distance_km: json["distance_km"], 
       duration_on_map_minutes: json["duration_on_map_minutes"], 
       currency: json["currency"],
        fare_price: json["fare_price"], 
        comment: json["comment"], 
        status: json["status"], 
        created_at: json["created_at"], 
        updated_at: json["updated_at"], 
        deleted_at: json["deleted_at"], 
        user: User.fromJson(json["user"]),
);

Map<String, dynamic> toJson() => {
    "id": id,
    "customer_id": customer_id,
    "pickup_date": pickup_date,
    "pickup_time": pickup_time,
    "pickup_location": pickup_location,
    "pickup_latitude": pickup_latitude,
    "pickup_longitude": pickup_longitude,
    "dropoff_location": dropoff_location,
    "dropoff_latitude": dropoff_latitude,
    "duration_minutes": duration_minutes,
    "distance_km": distance_km,
    "duration_on_map_minutes": duration_on_map_minutes,
    "currency": currency,
    "fare_price": fare_price,
    "comment": comment,
    "status": status,
    "created_at": created_at,
    "updated_at": updated_at,
    "deleted_at": deleted_at,
    "user": user,

  };

}

class User{
int? id;
String?first_name;
String?last_name;
String?mobile_number;


 User({required this.id, required this.first_name,required this.last_name,required this.mobile_number}); 


 factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"],
    first_name: json["first_name"],
    last_name: json["last_name"],
    mobile_number: json["mobile_number"],
   
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "first_name": first_name,
    "last_name": last_name,
    "mobile_number":mobile_number

  };


}