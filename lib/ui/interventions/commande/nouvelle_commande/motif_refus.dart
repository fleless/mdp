import 'dart:async';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mdp/constants/app_colors.dart';
import 'package:mdp/constants/app_constants.dart';
import 'package:mdp/constants/app_images.dart';
import 'package:mdp/constants/endpoints.dart';
import 'package:mdp/constants/routes.dart';
import 'package:mdp/constants/styles/app_styles.dart';
import 'package:mdp/models/requests/delete_notifications_request.dart';
import 'package:mdp/models/responses/show_intervention_response.dart';
import 'package:mdp/ui/notifications/notifications_bloc.dart';
import 'package:mdp/utils/shared_preferences.dart';
import 'package:mdp/widgets/gradients/md_gradient.dart';

import '../../interventions_bloc.dart';

class MotifRefusWidget extends StatefulWidget {
  ShowInterventionResponse _intervention;
  String uuidCompetition;
  String idNotification;

  MotifRefusWidget(
      this._intervention, this.uuidCompetition, this.idNotification);

  @override
  State<StatefulWidget> createState() => _MotifRefusWidgetState();
}

class _MotifRefusWidgetState extends State<MotifRefusWidget> {
  final bloc = Modular.get<InterventionsBloc>();
  final sharedPref = Modular.get<SharedPref>();
  final notifBloc = Modular.get<NotificationsBloc>();
  bool loading = false;
  String _refusText = " ";

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 380,
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  "Souhaitez-vous ajouter un motif de refus ?",
                  style: AppStyles.header1,
                  textAlign: TextAlign.left,
                  overflow: TextOverflow.clip,
                  maxLines: 3,
                ),
              ),
              SizedBox(width: 20),
              InkWell(
                onTap: () {
                  Modular.to.pop();
                },
                child: Align(
                  alignment: Alignment.topRight,
                  child: Icon(
                    Icons.close_outlined,
                    size: 25,
                    color: AppColors.closeDialogColor,
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 80),
            child: Container(
              child: Theme(
                // Create a unique theme with "ThemeData"
                data: ThemeData(
                  primarySwatch: AppColors.defaultColorMaterial,
                ),
                child: DropdownSearch<String>(
                    searchBoxDecoration: null,
                    dropdownSearchDecoration: null,
                    mode: Mode.MENU,
                    showSelectedItem: true,
                    popupSafeArea: PopupSafeArea(top: false),
                    items: [
                      "Je ne suis pas disponible",
                      "C'est trop loin",
                      "C'est hors de mes comp??tences",
                      "Il n'y a pas assez d'informations",
                      "C'est un doublon"
                    ],
                    label: "Motif de refus",
                    hint: "S??lectionner un motif",
                    onChanged: (value) {
                      _refusText = value;
                    }),
              ),
            ),
          ),
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
                height: 55,
                child: loading
                    ? Center(
                        child: CircularProgressIndicator(
                        color: AppColors.white,
                      ))
                    : Text(
                        "VALIDER",
                        style: AppStyles.smallTitleWhite,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
              ),
            ),
            onPressed: () {
              loading ? null : _validAction();
            },
            style: ElevatedButton.styleFrom(
                elevation: 5,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                onPrimary: AppColors.white,
                primary: Colors.transparent,
                padding: EdgeInsets.zero,
                textStyle:
                    TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }

  _validAction() async {
    Intervention _intervention = widget._intervention.intervention;
    setState(() {
      loading = true;
    });
    String _subcontractorId =
        await sharedPref.read(AppConstants.SUBCONTRACTOR_ID_KEY);
    int response = await bloc.refuseIntervention(_intervention.code, _refusText,
        _intervention.id, widget.uuidCompetition, _subcontractorId);
    if (response == 200) {
      await _supprimerUneNotif();
      Modular.to.pushNamedAndRemoveUntil(
          Routes.notifications, ModalRoute.withName(Routes.home),
          arguments: {"uuidIntervention": null, "uuidCompetition": null});
      Timer timer =
          Timer(Duration(milliseconds: AppConstants.TIMER_DIALOG), () {
        Modular.to.pop();
      });
      showDialog(
          context: context,
          builder: (context) {
            return StatefulBuilder(
                builder: (BuildContext context, StateSetter setState) {
              return Dialog(
                backgroundColor: AppColors.md_light_gray,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: _popUpMotifRefus(),
              );
            });
          }).then((value) {
        // dispose the timer in case something else has triggered the dismiss.
        timer?.cancel();
        timer = null;
      });
    } else {
      Fluttertoast.showToast(
        msg: "La commande n'est plus disponible",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
      );
    }
    setState(() {
      loading = false;
    });
  }

  Widget _popUpMotifRefus() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text("Nous avons bien pris en compte votre refus.",
              style: AppStyles.header3,
              textAlign: TextAlign.center,
              maxLines: 10,
              overflow: TextOverflow.ellipsis),
          SvgPicture.asset(AppImages.refus),
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
                  "FERMER",
                  style: AppStyles.buttonTextDarkBlue,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
            onPressed: () {
              Modular.to.popAndPushNamed(Routes.notifications, arguments: {
                "uuidIntervention": null,
                "uuidCompetition": null
              });
            },
            style: ElevatedButton.styleFrom(
                elevation: 5,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                onPrimary: AppColors.md_dark_blue.withOpacity(0.1),
                primary: Colors.transparent,
                padding: EdgeInsets.zero,
                textStyle:
                    TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }

  _supprimerUneNotif() async {
    /// we avoid calling this function when we come from push notifs
    /// cause idNotification is null
    if (widget.idNotification != null) {
      List<DeleteNotificationsRequest> lista = <DeleteNotificationsRequest>[];
      lista.add(
          DeleteNotificationsRequest(id: num.parse(widget.idNotification)));
      await notifBloc.deleteNotifications(lista);
    }
  }
}
