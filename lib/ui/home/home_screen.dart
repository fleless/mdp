import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mdp/constants/app_colors.dart';
import 'package:mdp/constants/app_images.dart';
import 'package:mdp/constants/routes.dart';
import 'package:mdp/constants/styles/app_styles.dart';
import 'package:mdp/models/meeting.dart';
import 'package:mdp/widgets/bottom_navbar_widget.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final List<Meeting> meetings = <Meeting>[];

  @override
  Future<void> initState() {
    super.initState();
    _getDataSource();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.appBackground,
      //drawer: DrawerWidget(),
      body: SafeArea(
          child: Container(
            height: double.infinity,
            child: SfCalendar(
              headerHeight: 33,
              view: CalendarView.day,
              // this commented line used to show only working days
              /*timeSlotViewSettings: TimeSlotViewSettings(
                  startHour: 9,
                  endHour: 16,
                  nonWorkingDays: <int>[DateTime.friday, DateTime.saturday]),*/
              //change first day in month view
              //firstDayOfWeek: 1,
              onTap: (event) {
                print("event is " + event.appointments.first.eventName);
                setState(() {
                  meetings.removeWhere((element) =>
                  element.eventName == event.appointments.first.eventName);
                });
              },
              //show view settings
              monthViewSettings: MonthViewSettings(showAgenda: true),
              dataSource: MeetingDataSource(meetings),
            ),
          ),
        ),
      //LoadingIndicator(loading: _bloc.loading),
      //NetworkErrorMessages(error: _bloc.error),
      bottomNavigationBar: const BottomNavbar(route: Routes.home),
    );
  }

  List<Meeting> _getDataSource() {
    final DateTime today = DateTime.now();
    DateTime startTime = DateTime(today.year, today.month, today.day, 9, 0, 0);
    DateTime endTime = startTime.add(const Duration(hours: 2));
    meetings.add(Meeting(
        'Conference', startTime, endTime, const Color(0xFF0F8644), false));
    startTime.add(Duration(hours: 3));
    endTime = startTime.add(const Duration(hours: 2));
    meetings.add(
        Meeting('Second', startTime.add(Duration(hours: 3)), endTime.add(Duration(hours: 3)), const Color(0xFF0F8644), false));
    startTime.add(Duration(hours: 3));
    endTime = startTime.add(const Duration(hours: 2));
    meetings.add(
        Meeting('Third', startTime, endTime, const Color(0xFF0F8644), false));
    return meetings;
  }
}
