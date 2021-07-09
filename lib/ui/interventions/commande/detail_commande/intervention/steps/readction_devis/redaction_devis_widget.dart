import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mdp/constants/app_colors.dart';
import 'package:mdp/constants/routes.dart';
import 'package:mdp/constants/styles/app_styles.dart';
import 'package:mdp/ui/interventions/commande/detail_commande/intervention/intervention_bloc.dart';
import 'package:mdp/ui/interventions/commande/detail_commande/intervention/steps/prise_rdv/prise_rdv_bloc.dart';

class RedactionDevisWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _RedactionDevisWidgetState();
}

class _RedactionDevisWidgetState extends State<RedactionDevisWidget> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final bloc = Modular.get<InterventionBloc>();
  final _rdvBloc = Modular.get<PriseRdvBloc>();
  bool opened = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _buildContent();
  }

  Widget _buildContent() {
    return Container(
        width: double.infinity,
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              color: _rdvBloc.userOrderAppointmentsResponse.length > 0
                  ? AppColors.md_gray
                  : AppColors.white,
              child: _buildHeader(),
            ),
            opened ? _buildExpansion() : SizedBox.shrink()
          ],
        ));
  }

  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _rdvBloc.userOrderAppointmentsResponse.length > 0
                ? Container(
                    width: 30.0,
                    height: 30.0,
                    alignment: Alignment.center,
                    decoration: new BoxDecoration(
                      color: AppColors.md_dark_blue,
                      shape: BoxShape.circle,
                      border:
                          Border.all(color: AppColors.md_dark_blue, width: 1.5),
                    ),
                    child: Icon(
                      Icons.edit,
                      color: AppColors.white,
                      size: 16,
                    ),
                  )
                : Container(
                    width: 30.0,
                    height: 30.0,
                    alignment: Alignment.center,
                    decoration: new BoxDecoration(
                      color: Colors.transparent,
                      shape: BoxShape.circle,
                      border:
                          Border.all(color: AppColors.placeHolder, width: 1.5),
                    ),
                    child: Text(
                      "2",
                      style: AppStyles.header2Gray,
                    ),
                  ),
            SizedBox(width: 10),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 3),
                  Text("Rédaction du devis",
                      style: _rdvBloc.userOrderAppointmentsResponse.length > 0
                          ? AppStyles.header2DarkBlue
                          : AppStyles.header2Gray),
                  !(_rdvBloc.userOrderAppointmentsResponse.length > 0)
                      ? SizedBox.shrink()
                      : SizedBox(height: 5),
                  _rdvBloc.userOrderAppointmentsResponse.length > 0
                      ? Container(
                          padding: EdgeInsets.all(7),
                          decoration: BoxDecoration(
                            color: AppColors.mdAlert,
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                          ),
                          child: Text("  À réaliser ",
                              style: AppStyles.tinyTitleWhite,
                              textAlign: TextAlign.center,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis),
                        )
                      : SizedBox.shrink(),
                ],
              ),
            ),
            Container(
              height: 10,
              child: IconButton(
                onPressed: () {
                  _rdvBloc.userOrderAppointmentsResponse.length > 0
                      ? setState(() {
                          opened = !opened;
                        })
                      : null;
                },
                iconSize: 12,
                alignment: Alignment.topCenter,
                icon: FaIcon(
                    opened
                        ? FontAwesomeIcons.chevronUp
                        : FontAwesomeIcons.chevronDown,
                    color: _rdvBloc.userOrderAppointmentsResponse.length > 0
                        ? AppColors.md_dark_blue
                        : AppColors.placeHolder,
                    size: 12),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildExpansion() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      color: _rdvBloc.userOrderAppointmentsResponse.length > 0
          ? AppColors.md_gray
          : AppColors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 10),
          ElevatedButton(
            child: Ink(
              decoration: BoxDecoration(
                color: AppColors.md_dark_blue,
                borderRadius: BorderRadius.all(
                  Radius.circular(12),
                ),
                border: Border.all(color: AppColors.md_dark_blue),
              ),
              child: Container(
                alignment: Alignment.center,
                width: double.infinity,
                height: 55,
                child: Text(
                  "RÉALISER LE DEVIS",
                  style: AppStyles.buttonTextWhite,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
            onPressed: () {
              Modular.to.pushNamed(Routes.redactionDevis);
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
          SizedBox(height: 10),
        ],
      ),
    );
  }
}
