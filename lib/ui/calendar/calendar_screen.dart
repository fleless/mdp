import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:mdp/constants/app_colors.dart';
import 'package:mdp/constants/app_constants.dart';
import 'package:mdp/constants/endpoints.dart';
import 'package:mdp/constants/routes.dart';
import 'package:mdp/constants/styles/app_styles.dart';
import 'package:mdp/models/meeting.dart';
import 'package:mdp/models/responses/user_appointments_response.dart';
import 'package:mdp/ui/calendar/calendar_bloc.dart';
import 'package:mdp/ui/interventions/commande/detail_commande/intervention/intervention_bloc.dart';
import 'package:mdp/ui/interventions/commande/detail_commande/intervention/steps/prise_rdv/prise_rdv_bloc.dart';
import 'package:mdp/ui/interventions/interventions_bloc.dart';
import 'package:mdp/widgets/bottom_navbar_widget.dart';
import 'package:mdp/widgets/gradients/dark_gradient.dart';
import 'package:mdp/widgets/gradients/md_gradient_green.dart';
import 'package:mdp/widgets/gradients/md_gradient_light.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:url_launcher/url_launcher.dart';

class CalendarScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final bloc = Modular.get<CalendarBloc>();
  final List<Meeting> meetings = <Meeting>[];
  CalendarController _controller;
  UserAppointmentsResponse _userAppointmentsResponse =
      UserAppointmentsResponse();

  //mode is bool variable 1 for month view and 2 for day view
  int mode = 1;

  @override
  Future<void> initState() {
    super.initState();
    _getAppointments();
    _controller = CalendarController();
  }

  _getAppointments() async {
    //TODO: change user ID
    _userAppointmentsResponse =
        await bloc.getUserAppointments(Endpoints.subcontractor_id);
    _convertAppointmentsToMeetings();
  }

  _convertAppointmentsToMeetings() {
    DateFormat format = new DateFormat("dd-MM-yyyy HH:mm");
    _userAppointmentsResponse.listVisitData.forEach((element) {
      setState(() {
        meetings.add(Meeting(element.title, format.parse(element.startDate),
            format.parse(element.endDate), AppColors.md_tertiary, false));
      });
    });
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
      backgroundColor: AppColors.white,
      //drawer: DrawerWidget(),
      body: SafeArea(
        child: Container(height: double.infinity, child: _buildContent()),
      ),
      bottomNavigationBar: const BottomNavbar(route: Routes.calendar),
    );
  }

  Widget _buildContent() {
    return Container(
        width: double.infinity,
        child: Column(
          children: [
            _buildTitle(),
            _buildCalendarHeader(),
            Expanded(
              child: mode == 1 ? _buildMonthCalendar() : _buildDayCalendar(),
            ),
            SizedBox(height: 40),
          ],
        ));
  }

  Widget _buildTitle() {
    return Container(
      decoration: BoxDecoration(
        gradient: MdGradientLightt(),
      ),
      child: Padding(
        padding: EdgeInsets.only(
            left: AppConstants.default_padding,
            right: AppConstants.default_padding,
            bottom: AppConstants.default_padding * 2,
            top: AppConstants.default_padding * 2),
        child: Container(
            alignment: Alignment.centerLeft,
            child: Text(
              "Mon calendrier",
              style: AppStyles.headerWhite,
            )),
      ),
    );
  }

  Widget _buildCalendarHeader() {
    return Container(
      width: 200,
      padding: EdgeInsets.symmetric(
          horizontal: AppConstants.default_padding,
          vertical: AppConstants.default_padding),
      child: Center(
        child: Card(
          elevation: 5,
          shape: RoundedRectangleBorder(
            side: BorderSide(color: Colors.white70, width: 1),
            borderRadius: BorderRadius.circular(10),
          ),
          color: AppColors.white,
          child: Padding(
            padding: EdgeInsets.all(3),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      mode = 1;
                      _controller.view = CalendarView.month;
                    });
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 25, vertical: 8),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        gradient: mode == 1 ? DarkGradient() : null,
                        borderRadius: BorderRadius.all(Radius.circular(7))),
                    child: FaIcon(
                      FontAwesomeIcons.calendarAlt,
                      size: 20,
                      color: mode == 1 ? AppColors.white : AppColors.md_dark,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      mode = 2;
                      _controller.view = CalendarView.day;
                    });
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 25, vertical: 8),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        gradient: mode == 2 ? DarkGradient() : null,
                        borderRadius: BorderRadius.all(Radius.circular(7))),
                    child: FaIcon(
                      FontAwesomeIcons.calendarDay,
                      size: 20,
                      color: mode == 2 ? AppColors.white : AppColors.md_dark,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDayCalendar() {
    return SfCalendar(
      controller: _controller,
      headerHeight: 33,
      view: CalendarView.day,
      cellBorderColor: AppColors.md_gray,
      todayHighlightColor: AppColors.md_tertiary,
      initialDisplayDate: DateTime.now(),
      appointmentTextStyle: AppStyles.smallTitleWhite,
      onTap: (event) {
        //print("event is " + event.appointments.first.eventName);
        setState(() {
          /*meetings.removeWhere((element) =>
              element.eventName == event.appointments.first.eventName);*/
        });
      },
      //show view settings
      monthViewSettings: MonthViewSettings(showAgenda: true),
      dataSource: MeetingDataSource(meetings),
    );
  }

  Widget _buildMonthCalendar() {
    return SfCalendar(
      headerHeight: 33,
      view: CalendarView.month,
      initialDisplayDate: DateTime.now(),
      cellBorderColor: AppColors.md_gray,
      todayHighlightColor: AppColors.md_tertiary,
      appointmentTextStyle: AppStyles.smallTitleWhite,
      monthViewSettings: MonthViewSettings(
          showAgenda: true,
          dayFormat: 'EEE',
          showTrailingAndLeadingDates: true,
          agendaStyle: AgendaStyle(
            dayTextStyle: AppStyles.textNormal,
            dateTextStyle: AppStyles.textNormal,
          ),
          monthCellStyle: MonthCellStyle(
              textStyle: AppStyles.textNormal,
              trailingDatesTextStyle: AppStyles.inactiveTextNormal,
              leadingDatesTextStyle: AppStyles.inactiveTextNormal),
          appointmentDisplayMode: MonthAppointmentDisplayMode.indicator),

      // this commented line used to show only working days
      /*timeSlotViewSettings: TimeSlotViewSettings(
                  startHour: 9,
                  endHour: 16,
                  nonWorkingDays: <int>[DateTime.friday, DateTime.saturday]),*/
      //change first day in month view
      //firstDayOfWeek: 1,
      onTap: (event) {
        //print("event is " + event.appointments.first.eventName);
        setState(() {
          /*meetings.removeWhere((element) =>
          element.eventName == event.appointments.first.eventName);*/
        });
      },
      //show view settings
      dataSource: MeetingDataSource(meetings),
    );
  }
}
