import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:mdp/constants/app_colors.dart';
import 'package:mdp/constants/app_constants.dart';
import 'package:mdp/constants/routes.dart';
import 'package:mdp/constants/styles/app_styles.dart';
import 'package:mdp/models/meeting.dart';
import 'package:mdp/models/responses/user_appointments_response.dart';
import 'package:mdp/ui/interventions/commande/detail_commande/intervention/intervention_bloc.dart';
import 'package:mdp/ui/interventions/commande/detail_commande/intervention/steps/prise_rdv/prise_rdv_bloc.dart';
import 'package:mdp/widgets/gradients/dark_gradient.dart';
import 'package:mdp/widgets/gradients/md_gradient_green.dart';
import 'package:mdp/widgets/gradients/md_gradient_light.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:url_launcher/url_launcher.dart';

class CalendrierPriseRdvWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _CalendrierPriseRdvWidgetState();
}

class _CalendrierPriseRdvWidgetState extends State<CalendrierPriseRdvWidget> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final bloc = Modular.get<InterventionBloc>();
  final _priseRdvBloc = Modular.get<PriseRdvBloc>();
  final List<Meeting> meetings = <Meeting>[];
  CalendarController _controller;
  UserAppointmentsResponse _userAppointmentsResponse = UserAppointmentsResponse();

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
    _userAppointmentsResponse = await _priseRdvBloc.getUserAppointments("152945");
    _convertAppointmentsToMeetings();
  }

  _convertAppointmentsToMeetings(){
    DateFormat format = new DateFormat("dd-MM-yyyy HH:mm");
    _userAppointmentsResponse.data.forEach((element) {
      setState(() {
        meetings.add(Meeting(
            element.order.code+element.client.firstName+element.client.lastName, format.parse(element.startDate), format.parse(element.startDate), AppColors.md_tertiary, false));
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
    );
  }

  Widget _buildContent() {
    return Container(
        width: double.infinity,
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(
                  horizontal: AppConstants.default_padding,
                  vertical: AppConstants.default_padding * 1.5),
              decoration: BoxDecoration(gradient: MdGradientLightt()),
              child: _buildHeader(),
            ),
            _buildCalendarHeader(),
            Expanded(
              child: mode == 1 ? _buildMonthCalendar() : _buildDayCalendar(),
            ),
            SizedBox(height: 15),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: AppConstants.default_padding),
              child: _buildCallButton(),
            ),
            SizedBox(height: 5),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: AppConstants.default_padding),
              child: Text(
                "Pensez à confirmer avec le client avant de valider ou modifier le créneau",
                style: AppStyles.textNormal,
                textAlign: TextAlign.center,
                maxLines: 5,
                overflow: TextOverflow.clip,
              ),
            ),
            SizedBox(height: 5),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: AppConstants.default_padding),
              child: _buildValidationButton(),
            ),
            SizedBox(height: 40),
          ],
        ));
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Prise de RDV intervention", style: AppStyles.header1White),
              RichText(
                textAlign: TextAlign.left,
                maxLines: 10,
                overflow: TextOverflow.clip,
                text: TextSpan(
                  children: [
                    TextSpan(text: "n° ", style: AppStyles.header1White),
                    TextSpan(
                        text: "FR-6DH3", style: AppStyles.header1WhiteBold),
                  ],
                ),
              ),
            ],
          ),
        ),
        Container(
          alignment: Alignment.center,
          child: InkWell(
            onTap: () {
              Modular.to.pop();
            },
            child: Icon(
              Icons.close_outlined,
              size: 25,
              color: AppColors.white,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCalendarHeader() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
          horizontal: AppConstants.default_padding,
          vertical: AppConstants.default_padding * 1),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          FaIcon(
            FontAwesomeIcons.chevronLeft,
            color: AppColors.md_dark_blue,
            size: 18,
          ),
          Card(
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
                      padding:
                      EdgeInsets.symmetric(horizontal: 25, vertical: 8),
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
                      padding:
                      EdgeInsets.symmetric(horizontal: 25, vertical: 8),
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
          GestureDetector(
            onTap: () {
              Modular.to.pushNamed(Routes.ajouterRDV);
            },
            child: Column(
              children: [
                Icon(
                  Icons.add_circle_outline_outlined,
                  color: AppColors.md_dark_blue,
                  size: 25,
                ),
                SizedBox(height: 3),
                Text("Ajouter",
                    style: AppStyles.miniCap,
                    maxLines: 1,
                    overflow: TextOverflow.clip)
              ],
            ),
          ),
        ],
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

  Widget _buildCallButton() {
    return ElevatedButton(
      child: Ink(
        decoration: BoxDecoration(
          gradient: MdGradientGreen(),
          borderRadius: BorderRadius.all(
            Radius.circular(12),
          ),
        ),
        child: Container(
            alignment: Alignment.center,
            width: double.infinity,
            height: 50,
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: FaIcon(FontAwesomeIcons.phoneAlt,
                        color: AppColors.white),
                  ),
                ),
                Center(
                  child: Text(
                    "APPELER LE CLIENT",
                    style: AppStyles.smallTitleWhite,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            )),
      ),
      onPressed: () {
        _callPhone("0648635422");
      },
      style: ElevatedButton.styleFrom(
          elevation: 5,
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          onPrimary: AppColors.white,
          primary: Colors.transparent,
          padding: EdgeInsets.zero,
          textStyle: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
    );
  }

  Widget _buildValidationButton() {
    return ElevatedButton(
      child: Ink(
        decoration: BoxDecoration(
          color: AppColors.inactive,
          borderRadius: BorderRadius.all(
            Radius.circular(12),
          ),
        ),
        child: Container(
          alignment: Alignment.center,
          width: double.infinity,
          height: 50,
          child: Center(
            child: Text(
              "VALIDER LE RENDEZ-VOUS",
              style: AppStyles.buttonInactiveText,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
      ),
      onPressed: () {},
      style: ElevatedButton.styleFrom(
          elevation: 5,
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          onPrimary: AppColors.white,
          primary: Colors.transparent,
          padding: EdgeInsets.zero,
          textStyle: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
    );
  }

  void _callPhone(String numero) async =>
      await canLaunch("tel:" + numero)
          ? await launch("tel:" + numero)
          : throw 'Could not launch';
}
