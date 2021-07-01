import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mdp/constants/app_colors.dart';
import 'package:mdp/constants/app_constants.dart';
import 'package:mdp/constants/routes.dart';
import 'package:mdp/constants/styles/app_styles.dart';
import 'package:mdp/ui/interventions/commande/detail_commande/intervention/intervention_bloc.dart';
import 'package:mdp/ui/interventions/commande/detail_commande/intervention/steps/prise_rdv/screens/calendrier_prise_rdv_screen.dart';

class PriseRdvWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _PriseRdvWidgetState();
}

class _PriseRdvWidgetState extends State<PriseRdvWidget> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final bloc = Modular.get<InterventionBloc>();
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
              color: AppColors.md_gray,
              child: _buildHeader(),
            ),
            opened ? _buildExpansion() : SizedBox.shrink()
          ],
        ));
  }

  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 30.0,
              height: 30.0,
              alignment: Alignment.center,
              decoration: new BoxDecoration(
                color: AppColors.md_dark_blue,
                shape: BoxShape.circle,
                border: Border.all(color: AppColors.placeHolder, width: 1.5),
              ),
              child: Icon(
                Icons.calendar_today,
                color: AppColors.white,
                size: 16,
              ),
            ),
            SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Prise de RDV", style: AppStyles.header2DarkBlue),
                  SizedBox(height: 5),
                  Container(
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
                  ),
                ],
              ),
            ),
            IconButton(
                onPressed: () {
                  setState(() {
                    opened = !opened;
                  });
                },
                iconSize: 12,
                alignment: Alignment.topCenter,
                icon: FaIcon(
                    opened
                        ? FontAwesomeIcons.chevronUp
                        : FontAwesomeIcons.chevronDown,
                    color: AppColors.md_dark_blue,
                    size: 12)),
          ],
        ),
      ],
    );
  }

  Widget _buildExpansion() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 0),
      color: AppColors.md_gray,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.all(
                  Radius.circular(AppConstants.default_Radius)),
            ),
            child: Column(
              children: [
                Text("Date souhaitée du rendez-vous",
                    style: AppStyles.bodyMdTextLight,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis),
                SizedBox(height: 10),
                Text(
                  "mardi 30 mars, 17h",
                  style: AppStyles.header2,
                ),
              ],
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
                height: 55,
                child: Text(
                  "PLANIFIER LE RENDEZ-VOUS",
                  style: AppStyles.smallTitleWhite,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
            onPressed: () {
              Modular.to.pushNamed(Routes.calendrierPriseRDV);
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
          SizedBox(height: 15),
        ],
      ),
    );
  }
}
