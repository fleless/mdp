import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:mdp/constants/app_colors.dart';
import 'package:mdp/constants/app_constants.dart';
import 'package:mdp/constants/endpoints.dart';
import 'package:mdp/constants/routes.dart';
import 'package:mdp/constants/styles/app_styles.dart';
import 'package:mdp/models/responses/add_appointment_response.dart';
import 'package:mdp/models/responses/user_appointments_response.dart';
import 'package:mdp/ui/interventions/commande/detail_commande/intervention/steps/prise_rdv/prise_rdv_bloc.dart';
import 'package:mdp/ui/interventions/interventions_bloc.dart';

class ModifierRdvScreen extends StatefulWidget {
  ListVisitData rdv = ListVisitData();

  ModifierRdvScreen(this.rdv);

  @override
  State<StatefulWidget> createState() => _ModifierRdvScreenState();
}

class _ModifierRdvScreenState extends State<ModifierRdvScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  TextEditingController _commentaireController = TextEditingController();
  final bloc = Modular.get<InterventionsBloc>();
  final _rdvBloc = Modular.get<PriseRdvBloc>();
  DateTime _startDate;
  DateTime _endDate;
  TimeOfDay _startTime;
  TimeOfDay _endTime;
  bool _loading = false;
  bool _error = false;

  @override
  Future<void> initState() {
    _intiDates();
    super.initState();
  }

  _intiDates() {
    DateFormat format = new DateFormat("dd-MM-yyyy HH:mm");

    setState(() {
      DateTime _start = format.parse(widget.rdv.startDate);
      DateTime _end = format.parse(widget.rdv.endDate);
      _startDate = _start;
      _endDate = _end;
      _startTime = TimeOfDay(hour: _start.hour, minute: _start.minute);
      _endTime = TimeOfDay(hour: _end.hour, minute: _end.minute);
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
      resizeToAvoidBottomInset: true,
      backgroundColor: AppColors.white,
      //drawer: DrawerWidget(),
      body: SafeArea(
        child: Container(
            height: double.infinity,
            child: SingleChildScrollView(
              child: _buildContent(),
            )),
      ),
    );
  }

  Widget _buildContent() {
    return Container(
        width: double.infinity,
        child: Column(
          children: [
            _buildHeader(),
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(AppConstants.default_padding),
              child: _buildInfo(),
            ),
          ],
        ));
  }

  Widget _buildHeader() {
    return Container(
      color: AppColors.md_dark_blue,
      padding: EdgeInsets.symmetric(
          horizontal: AppConstants.default_padding,
          vertical: AppConstants.default_padding * 1.5),
      child: Stack(
        children: [
          Center(
            child: Text(
              "Modifier date intervention",
              style: AppStyles.header1WhiteBold,
            ),
          ),
          Container(
            alignment: Alignment.centerLeft,
            child: InkWell(
              onTap: () {
                Modular.to.pop();
              },
              child: Icon(
                Icons.expand_more,
                size: 25,
                color: AppColors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfo() {
    return Column(
      children: [
        Container(
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 12),
          decoration: BoxDecoration(
            color: AppColors.md_light_gray,
            borderRadius: BorderRadius.all(
              Radius.circular(2),
            ),
            border: Border.all(color: AppColors.placeHolder, width: 1),
          ),
          child: Text(widget.rdv.title,
              style: AppStyles.bodyBold, overflow: TextOverflow.ellipsis),
        ),
        SizedBox(height: 20),
        Container(
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 12),
          decoration: BoxDecoration(
            color: AppColors.md_light_gray,
            borderRadius: BorderRadius.all(
              Radius.circular(2),
            ),
            border: Border.all(color: AppColors.placeHolder, width: 1),
          ),
          child: Text(
              bloc.interventionDetail.interventionDetail.interventionAddress
                          .streetNumber ==
                      null
                  ? ""
                  : (bloc.interventionDetail.interventionDetail
                                      .interventionAddress.streetNumber +
                                  " ") +
                              bloc.interventionDetail.interventionDetail
                                  .interventionAddress.streetName ==
                          null
                      ? ""
                      : bloc.interventionDetail.interventionDetail
                          .interventionAddress.streetName,
              style: AppStyles.bodyBold,
              overflow: TextOverflow.ellipsis),
        ),
        SizedBox(height: 1),
        Container(
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 12),
          decoration: BoxDecoration(
            color: AppColors.md_light_gray,
            borderRadius: BorderRadius.all(
              Radius.circular(2),
            ),
            border: Border.all(color: AppColors.placeHolder, width: 1),
          ),
          child: Text(
              bloc.interventionDetail.interventionDetail.interventionAddress
                      .city.postcode +
                  " " +
                  bloc.interventionDetail.interventionDetail.interventionAddress
                      .city.department.name,
              style: AppStyles.bodyBold,
              overflow: TextOverflow.ellipsis),
        ),
        SizedBox(height: 20),
        Container(
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 12),
          decoration: BoxDecoration(
            color: AppColors.md_light_gray,
            borderRadius: BorderRadius.all(
              Radius.circular(2),
            ),
            border: Border.all(color: AppColors.placeHolder, width: 1),
          ),
          child: Text(
              bloc.interventionDetail.interventionDetail.clients.firstname +
                  " " +
                  bloc.interventionDetail.interventionDetail.clients.lastname,
              style: AppStyles.bodyBold,
              overflow: TextOverflow.ellipsis),
        ),
        SizedBox(height: 1),
        Container(
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 12),
          decoration: BoxDecoration(
            color: AppColors.md_light_gray,
            borderRadius: BorderRadius.all(
              Radius.circular(2),
            ),
            border: Border.all(color: AppColors.placeHolder, width: 1),
          ),
          child: Text(
              bloc.interventionDetail.interventionDetail.clients.commchannels
                  .firstWhere((element) =>
                      (element.preferred) && (element.type.name == "Phone"))
                  .name,
              style: AppStyles.bodyBold,
              overflow: TextOverflow.ellipsis),
        ),
        Container(
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 12),
          decoration: BoxDecoration(
            color: AppColors.md_light_gray,
            borderRadius: BorderRadius.all(
              Radius.circular(2),
            ),
            border: Border.all(color: AppColors.placeHolder, width: 1),
          ),
          child: Text(
              bloc.interventionDetail.interventionDetail.clients.commchannels
                          .firstWhere((element) =>
                              (element.preferred) &&
                              (element.type.name == "Email"))
                          .name ==
                      null
                  ? ""
                  : bloc.interventionDetail.interventionDetail.clients
                      .commchannels
                      .firstWhere((element) =>
                          (element.preferred) && (element.type.name == "Email"))
                      .name,
              style: AppStyles.bodyBold,
              overflow: TextOverflow.ellipsis),
        ),
        SizedBox(height: 15),
        Container(height: 1.1, color: AppColors.placeHolder),
        SizedBox(height: 15),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Début", style: AppStyles.bodyDefaultBlack),
            Container(
                width: MediaQuery.of(context).size.width * 0.55,
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 12),
                decoration: BoxDecoration(
                  color: AppColors.md_gray,
                  borderRadius: BorderRadius.all(
                    Radius.circular(8),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        _pickStartDate();
                      },
                      child: Text("  " + _formatDate(_startDate),
                          style: AppStyles.bodyBold,
                          overflow: TextOverflow.ellipsis),
                    ),
                    GestureDetector(
                      onTap: () {
                        _pickStartTime();
                      },
                      child: Text(
                          ((_startTime.hour < 10) ? "0" : "") +
                              _startTime.hour.toString() +
                              "h" +
                              ((_startTime.minute < 10) ? "0" : "") +
                              _startTime.minute.toString() +
                              " ",
                          style: AppStyles.bodyBold,
                          overflow: TextOverflow.ellipsis),
                    ),
                  ],
                )),
          ],
        ),
        SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Fin", style: AppStyles.bodyDefaultBlack),
            Container(
                width: MediaQuery.of(context).size.width * 0.55,
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 12),
                decoration: BoxDecoration(
                  color: AppColors.md_gray,
                  borderRadius: BorderRadius.all(
                    Radius.circular(8),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        _pickEndDate();
                      },
                      child: Text("  " + _formatDate(_endDate),
                          style: AppStyles.bodyBold,
                          overflow: TextOverflow.ellipsis),
                    ),
                    GestureDetector(
                      onTap: () {
                        _pickEndTime();
                      },
                      child: Text(
                          ((_endTime.hour < 10) ? "0" : "") +
                              _endTime.hour.toString() +
                              "h" +
                              ((_endTime.minute < 10) ? "0" : "") +
                              _endTime.minute.toString() +
                              " ",
                          style: AppStyles.bodyBold,
                          overflow: TextOverflow.ellipsis),
                    ),
                  ],
                )),
          ],
        ),
        _error ? SizedBox(height: 15) : SizedBox.shrink(),
        _error
            ? Container(
                width: double.infinity,
                alignment: Alignment.centerRight,
                child: Text(
                  "La date de fin doit être supérieure à la date de début",
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.right,
                  style: AppStyles.alertNormalText,
                ),
              )
            : SizedBox.shrink(),
        SizedBox(height: 15),
        Container(height: 1.1, color: AppColors.placeHolder),
        SizedBox(height: 15),
        Container(
          decoration: BoxDecoration(
            color: AppColors.md_light_gray,
            border: Border.all(
              color: AppColors.placeHolder,
              width: 1,
            ),
          ),
          width: double.infinity,
          height: 200,
          child: Align(
            alignment: Alignment.topLeft,
            child: TextFormField(
              controller: _commentaireController,
              obscureText: false,
              cursorColor: AppColors.default_black,
              keyboardType: TextInputType.multiline,
              expands: true,
              maxLines: null,
              decoration: const InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(
                    bottom: 10.0, left: 10.0, right: 10.0, top: 10.0),
                errorStyle: TextStyle(height: 0),
                hintText: "Commentaire facultatif",
                hintStyle: AppStyles.textNormalPlaceholder,
              ),
              style: AppStyles.textNormal,
              validator: (String value) {},
            ),
          ),
        ),
        SizedBox(height: 15),
        ElevatedButton(
          child: Ink(
            decoration: BoxDecoration(
              color: AppColors.md_dark_blue,
              borderRadius: BorderRadius.all(
                Radius.circular(12),
              ),
            ),
            child: Container(
              alignment: Alignment.center,
              width: double.infinity,
              height: 50,
              child: _loading
                  ? Center(
                      child: CircularProgressIndicator(color: AppColors.white),
                    )
                  : Text(
                      "MODIFIER",
                      style: AppStyles.smallTitleWhite,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
            ),
          ),
          onPressed: () {
            _loading ? null : _goAdd();
          },
          style: ElevatedButton.styleFrom(
              elevation: 5,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              onPrimary: AppColors.white,
              primary: Colors.transparent,
              padding: EdgeInsets.zero,
              textStyle: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
        ),
        SizedBox(height: 15),
        ElevatedButton(
          child: Ink(
            decoration: BoxDecoration(
              color: AppColors.white,
              border: Border.all(color: AppColors.md_dark_blue),
              borderRadius: BorderRadius.all(
                Radius.circular(12),
              ),
            ),
            child: Container(
              alignment: Alignment.center,
              width: double.infinity,
              height: 50,
              child: Text(
                "AJOUTER A MON CALENDRIER",
                style: AppStyles.buttonTextDarkBlue,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
          onPressed: () {},
          style: ElevatedButton.styleFrom(
              elevation: 5,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              onPrimary: AppColors.md_dark_blue.withOpacity(0.1),
              primary: Colors.transparent,
              padding: EdgeInsets.zero,
              textStyle: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
        ),
      ],
    );
  }

  String _formatDate(DateTime date) {
    int timeInMillis = date.millisecondsSinceEpoch;
    var date2 = DateTime.fromMillisecondsSinceEpoch(timeInMillis);
    final DateFormat format = new DateFormat("dd-MM-yyyy");
    var formattedDate = format.format(date2);
    return formattedDate.toString();
  }

  _pickStartDate() async {
    final pickedDate = await showDatePicker(
        context: context,
        initialDate: _startDate,
        firstDate: DateTime(2020),
        lastDate: DateTime(2045),
        helpText: "SÉLECTIONNER UNE DATE",
        cancelText: "ANNULER",
        confirmText: "OK",
        errorFormatText: "Entrer une date valide",
        errorInvalidText: "Entrer une date valide",
        fieldLabelText: "Saisir une date",
        fieldHintText: "Mois/Jour/Année",
        builder: (context, child) {
          return Theme(
            data: ThemeData.light(),
            child: child,
          );
        });
    if (pickedDate != null) {
      setState(() {
        _startDate = pickedDate;
      });
    }
  }

  _pickEndDate() async {
    final pickedDate = await showDatePicker(
        context: context,
        initialDate: _endDate,
        firstDate: DateTime(2020),
        lastDate: DateTime(2045),
        helpText: "SÉLECTIONNER UNE DATE",
        cancelText: "ANNULER",
        confirmText: "OK",
        errorFormatText: "Entrer une date valide",
        errorInvalidText: "Entrer une date valide",
        fieldLabelText: "Saisir une date",
        fieldHintText: "Mois/Jour/Année",
        builder: (context, child) {
          return Theme(
            data: ThemeData.light(),
            child: child,
          );
        });
    if (pickedDate != null) {
      setState(() {
        _endDate = pickedDate;
      });
    }
  }

  _pickStartTime() async {
    final pickedTime = await showTimePicker(
        context: context,
        helpText: "SÉLECTIONNER UN HORAIRE",
        cancelText: "ANNULER",
        confirmText: "OK",
        initialTime: _startTime,
        builder: (context, child) {
          return Theme(
            data: ThemeData.light(),
            child: child,
          );
        });
    if (pickedTime != null) {
      setState(() {
        _startTime = pickedTime;
      });
    }
  }

  _pickEndTime() async {
    final pickedTime = await showTimePicker(
        context: context,
        helpText: "SÉLECTIONNER UN HORAIRE",
        cancelText: "ANNULER",
        confirmText: "OK",
        initialTime: _endTime,
        builder: (context, child) {
          return Theme(
            data: ThemeData.light(),
            child: child,
          );
        });
    if (pickedTime != null) {
      setState(() {
        _endTime = pickedTime;
      });
    }
  }

  _goAdd() async {
    setState(() {
      _error = false;
    });
    FocusScope.of(context).requestFocus(new FocusNode());
    setState(() {
      _loading = true;
    });
    DateTime _start = DateTime(_startDate.year, _startDate.month,
        _startDate.day, _startTime.hour, _startTime.minute);
    DateTime _end = DateTime(_endDate.year, _endDate.month, _endDate.day,
        _endTime.hour, _endTime.minute);
    if (_start.isBefore(_end)) {
      AddAppointmentResponse response = await _rdvBloc.updateFirstAppointment(
          widget.rdv.title,
          _commentaireController.text,
          DateFormat('yyyy-MM-dd HH:mm:ss').format(_start),
          DateFormat('yyyy-MM-dd HH:mm:ss').format(_end),
          widget.rdv.id.toString());
      if (response != null) {
        setState(() {
          _loading = false;
        });
        Modular.to.popAndPushNamed(Routes.detailCommande);
      } else {
        Fluttertoast.showToast(
            msg: "Une erreur est survenue !",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: AppColors.mdAlert,
            textColor: Colors.white,
            fontSize: 16.0);
        setState(() {
          _loading = false;
        });
      }
    } else {
      setState(() {
        _error = true;
        _loading = false;
      });
    }
  }
}
