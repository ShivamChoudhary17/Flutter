import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:ghadee/theme_data.dart';
import 'package:intl/intl.dart';
import 'alarm_helper.dart';
import 'data.dart';
import 'data.dart';
import 'data.dart';
import 'listview_model.dart';
import 'main.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

class AlarmPage extends StatefulWidget {
  const AlarmPage({Key? key}) : super(key: key);

  @override
  _AlarmPageState createState() => _AlarmPageState();
}

class _AlarmPageState extends State<AlarmPage> {
  late DateTime _alarmTime;
  late String _alarmTimeString;
  late AlarmHelper _alarmHelper = AlarmHelper();
  late Future<List<AlarmInfo>> _alarms;
  late List<AlarmInfo> _currentAlarms;

  @override
  void initState() {
    _alarmHelper = DateTime.now() as AlarmHelper ;
    initializeSetting();
    tz.initializeTimeZones();
    _alarmHelper.initializeDatabase().then((value) {
      //print('------------Database Initialized-----------');
      //_alarms = _alarmHelper.getAlarm();
      loadAlarms();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 32, vertical: 64),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(
          'Alarm',
          style: TextStyle(
              fontFamily: 'avenir',
              fontWeight: FontWeight.w700,
              color: CustomColors.primaryTextColor,
              fontSize: 24),
        ),
        Expanded(
          child: FutureBuilder<List<AlarmInfo>>(
            future: _alarms,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                _currentAlarms = snapshot.data!;
                return ListView(
                    children: snapshot.data!.map<Widget>((alarm) {
                  var alarmTime =
                      DateFormat('hh:mm aa').format(alarm.alarmDateTime);
                  var gradientColor = GradientTemplate
                      .gradientTemplate[alarm.gradientColorIndex].colors;
                  return Container(
                    margin: const EdgeInsets.only(bottom: 32),
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.centerLeft,
                          colors: gradientColor,
                          end: Alignment.centerRight,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color:
                                gradientColor.last.withOpacity(0.2),
                            blurRadius: 8,
                            spreadRadius: 2,
                            offset: Offset(4, 4),
                          )
                        ],
                        borderRadius: BorderRadius.all(Radius.circular(24.0))),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.label,
                                  color: Colors.white,
                                  size: 24,
                                ),
                                SizedBox(width: 8),
                                Text(
                                  'Office',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'avenir'
                                          ''),
                                ),
                              ],
                            ),
                            Switch(
                              onChanged: (bool value) {},
                              value: true,
                              activeColor: Colors.white,
                            ),
                          ],
                        ),
                        Text(
                          'Mon-Fri',
                          style: TextStyle(
                              color: Colors.white, fontFamily: 'avenir'),
                        ),
                        Text(
                          alarmTime,
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'avenir',
                            fontSize: 24,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Icon(Icons.keyboard_arrow_down,
                            size: 30, color: Colors.white),
                      ],
                    ),
                  );
                }).followedBy([
                  DottedBorder(
                    strokeWidth: 2,
                    borderType: BorderType.RRect,
                    color: CustomColors.clockOutline,
                    radius: Radius.circular(23.5),
                    dashPattern: [5, 4],
                    child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: CustomColors.clockBG,
                            borderRadius:
                                BorderRadius.all(Radius.circular(24.0))),
                        child: MaterialButton(
                          padding: EdgeInsets.symmetric(
                              horizontal: 32, vertical: 16),
                          onPressed: () {
                            _alarmTimeString =
                                DateFormat('HH:mm').format(DateTime.now());
                            showModalBottomSheet(
                              useRootNavigator: true,
                              context: context,
                              clipBehavior: Clip.antiAlias,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(24),
                                ),
                              ),
                              builder: (context) {
                                return StatefulBuilder(
                                  builder: (context, setModalState) {
                                    return Container(
                                      padding: const EdgeInsets.all(32),
                                      child: Column(
                                        children: [
                                          MaterialButton(
                                            onPressed: () async {
                                              var selectedTime =
                                                  await showTimePicker(
                                                context: context,
                                                initialTime: TimeOfDay.now(),
                                              );
                                              if (selectedTime != null) {
                                                final now = DateTime.now();
                                                var selectedDateTime = DateTime(
                                                    now.year,
                                                    now.month,
                                                    now.day,
                                                    selectedTime.hour,
                                                    selectedTime.minute);
                                                _alarmTime = selectedDateTime;
                                                setModalState(() {
                                                  _alarmTimeString = DateFormat(
                                                          'HH:mm')
                                                      .format(selectedDateTime);
                                                });
                                              }
                                            },
                                            child: Text(
                                              _alarmTimeString,
                                              style: TextStyle(fontSize: 32),
                                            ),
                                          ),
                                          ListTile(
                                            title: Text('Repeat'),
                                            trailing:
                                                Icon(Icons.arrow_forward_ios),
                                          ),
                                          ListTile(
                                            title: Text('Sound'),
                                            trailing:
                                                Icon(Icons.arrow_forward_ios),
                                          ),
                                          ListTile(
                                            title: Text('Title'),
                                            trailing:
                                                Icon(Icons.arrow_forward_ios),
                                          ),
                                          FloatingActionButton.extended(
                                            onPressed: onSaveAlarm,
                                            icon: Icon(Icons.alarm),
                                            label: Text('Save'),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                );
                              },
                            );
                            // scheduleAlarm();
                          },
                          child: Column(
                            children: [
                              Image.asset(
                                'assets/add_alarm.png',
                                scale: 1.5,
                              ),
                              SizedBox(height: 8),
                              Text(
                                'Add Alarm',
                                style: TextStyle(
                                    color: Colors.white, fontFamily: 'avenir'),
                              )
                            ],
                          ),
                        )),
                  )
                ]).toList());
              } else {
                return Center(
                  child: Text('No Alarm',
                      style: TextStyle(color: Colors.white, fontSize: 8)),
                );
              }
            },
          ),
        )
      ]),
    );
  }

  void onSaveAlarm() {
    DateTime scheduleAlarmDateTime;
    if (_alarmTime.isAfter(DateTime.now())) {
      scheduleAlarmDateTime = _alarmTime;
    } else {
      scheduleAlarmDateTime = _alarmTime.add(Duration(days: 1));
    }

    var alarmInfo = AlarmInfo(
      alarmDateTime: scheduleAlarmDateTime,
      gradientColorIndex: _currentAlarms.length,
      title: 'alarm'
    );
    _alarmHelper.insertAlarm(alarmInfo);
    displayNotifications();
    Navigator.pop(context);
    loadAlarms();
  }

  void deleteAlarm(int id) {
    _alarmHelper.delete(id);
    //unsubscribe for notification
    loadAlarms();
  }

  void loadAlarms() {
    _alarms = _alarmHelper.getAlarm();
    if (mounted) setState(() {});
  }

/*---Display_Flutter_Local_Notification--*/
  Future<void> displayNotifications() async {
    flutterLocalNotificationsPlugin.zonedSchedule(
        0,
        'Office',
        'OfficeOfficeOfficeOffice',
        tz.TZDateTime.now(tz.local).add(
          Duration(seconds: 5),
        ),
        NotificationDetails(
            android: AndroidNotificationDetails(
          'channel id',
          'channel name',
        )),
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        androidAllowWhileIdle: true);
  }
}

/*---Initialize_Flutter_Local_Notification--*/
void initializeSetting() async {
  var initializeAndroid = AndroidInitializationSettings('img');
  var initializeSettigns = InitializationSettings(android: initializeAndroid);
  await flutterLocalNotificationsPlugin.initialize(initializeSettigns);
}
