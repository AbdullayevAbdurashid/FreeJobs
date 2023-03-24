import 'package:fluttertoast/fluttertoast.dart';
import 'package:demandium/core/core_export.dart';

const kLOG_TAG = "[demandium]";
const kLOG_ENABLE = true;
DateTime? loginClickTime;

printLog(dynamic data) {
  if (kLOG_ENABLE) {
    print("$kLOG_TAG${data.toString()}");
  }
}

bool isRedundentClick(DateTime currentTime){
  if(loginClickTime==null){
    loginClickTime = currentTime;
    return false;
  }
  if(currentTime.difference(loginClickTime!).inSeconds<3){//set this difference time in seconds
    return true;
  }

  loginClickTime = currentTime;
  return false;
}

onDemandToast(String message,Color color){
  return  Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      timeInSecForIosWeb: 1,
      backgroundColor: color,
      textColor: Colors.white,
      fontSize: 16.0
  );
}