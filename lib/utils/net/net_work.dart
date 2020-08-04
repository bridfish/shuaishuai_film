import 'dart:async';
import 'package:connectivity/connectivity.dart';


 Future isConnected() async {
  var connectivityResult = await (Connectivity().checkConnectivity());
  print(connectivityResult != ConnectivityResult.none);
  return connectivityResult != ConnectivityResult.none;
}

Future<bool> checkNetMobile() async {
  var connectivityResult = await (Connectivity().checkConnectivity());
   return connectivityResult == ConnectivityResult.mobile;
}




