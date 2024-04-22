import 'package:get_storage/get_storage.dart';

var box = GetStorage();


language() {
  return box.read('language') ?? '';
}

amount() {
  return box.read('amount') ?? '';
}

starRating() {
  return box.read('starRating') ?? '';
}

totalBookings() {
  return box.read('totalBookings') ?? '';
}

totalDistance() {
  return box.read('totalDistance') ?? '';
}

appVersion() {
  return box.read('appVersion') ?? '';
}
SwitchValues() {
  return box.read('SwitchValues') ?? '';
}

languageCode() {
  return box.read('languageCode') ?? '';
}

rideaccept() {
  return box.read('rideaccept') ?? '';
}

dravierData() {
  return box.read('dravier') ?? '';
}
rideconfirm() {
  return box.read('rideconfirm') ?? '';
}

firebase() {
  return box.read('firebase') ?? '';
}
mapType() {
  return box.read('mapType') ?? '';
}

DriverID() {
  return box.read('driver_id') ?? '';
}


languageID() {
  return box.read('language_id') ?? '';
}

