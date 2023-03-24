import 'package:get/get.dart';
import 'package:demandium/core/core_export.dart';

class ScheduleController extends GetxController{
  ///Selected date of day
  DateTime _selectedDate = DateTime.now().add(Duration(hours: AppConstants.SCHEDULE_TIME));
  DateTime get selectedData => _selectedDate;


  ///Selected time of day
  // TimeOfDay _selectedTimeOfDay = TimeOfDay(hour: DateTime.now().hour + AppConstants.SCHEDULE_TIME, minute: DateTime.now().minute);
  // TimeOfDay get selectedTimeOfDay => _selectedTimeOfDay;

  // String _schedule = '';
  // String get schedule => _schedule;

  @override
  void onInit() {
    super.onInit();
    // initializeTime();
   // _buildSchedule();
  }


  ///selet date function
  Future<void> selectDate() async {
    final DateTime? picked = await showDatePicker(
        context: Get.context!,
        initialDate: _selectedDate,
        firstDate: DateTime.now().subtract(Duration(days: 0)),
        lastDate: DateTime(2101));
    if (picked != null) {
      _selectedDate = picked;
      update();
      selectTimeOfDay();
    }
  }
  ///select time function
  Future<void> selectTimeOfDay() async {
    final TimeOfDay? pickedTime = await showTimePicker(
        context: Get.context!,
        initialTime: TimeOfDay(hour: DateTime.now().hour + AppConstants.SCHEDULE_TIME, minute: DateTime.now().minute));

    if (pickedTime != null) {
      _selectedDate = DateTime(_selectedDate.year, _selectedDate.month, _selectedDate.day, pickedTime.hour, pickedTime.minute);
      update();
      ///after receive date and time we should call buildSchedule to get time and date together
     // _buildSchedule();
    }
  }


  // Future<void> _buildSchedule() async {
  //   _schedule = DateConverter.dateToDateAndTime(_selectedDate);
  //   //_schedule = "${DateConverter.dateTimeStringToDateOnly(_selectedDate.toString())} ${_selectedDate.hour.toString().padLeft(2,'0')}:${_selectedDate.minute.toString().padLeft(2,'0')}:00";
  //   update();
  // }

  bool checkScheduleTime(){
    return  _selectedDate.difference(DateTime.now()) > Duration(hours: AppConstants.SCHEDULE_TIME, minutes: -15);
  }


  ///Task Task Task
///Convert time to 24 hour format




}