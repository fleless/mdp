import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mdp/constants/app_colors.dart';
import 'package:mdp/constants/routes.dart';
import 'package:mdp/constants/styles/app_styles.dart';
import 'package:mdp/ui/interventions/commande/detail_commande/intervention/intervention_bloc.dart';
import 'package:mdp/ui/interventions/commande/detail_commande/intervention/recap_dialog.dart';
import 'package:mdp/ui/interventions/commande/detail_commande/intervention/steps/finalisation_intervention/finalisation_intervention_widget.dart';
import 'package:mdp/ui/interventions/commande/detail_commande/intervention/steps/prise_rdv/prise_rdv_widget.dart';
import 'package:mdp/ui/interventions/commande/detail_commande/intervention/steps/readction_devis/redaction_devis_widget.dart';
import 'package:mdp/ui/interventions/commande/detail_commande/intervention/steps/realisation_travaux/realisation_travaux_widget.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class InterventionWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _InterventionWidgetState();
}

class _InterventionWidgetState extends State<InterventionWidget> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final bloc = Modular.get<InterventionBloc>();

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
    return Scaffold(
      key: _scaffoldKey,
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Container(
          height: double.infinity,
          child: _buildContent(),
        ),
      ),
    );
  }

  Widget _buildContent() {
    return Stack(
      children: [
        SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Container(
            child: Column(mainAxisSize: MainAxisSize.min, children: [
              PriseRdvWidget(),
              Container(height: 1, color: AppColors.md_gray),
              //TODO : remove gesture detector
              GestureDetector(
                onTap: () {
                  Modular.to.pushNamed(Routes.redactionDevis);
                },
                child: RedactionDevisWidget(),
              ),
              Container(height: 1, color: AppColors.md_gray),
              RealisationTravauxWidget(),
              Container(height: 1, color: AppColors.md_gray),
              FinalisationInterventionWidget(),
              SizedBox(height: 60),
            ]),
          ),
        ),
        _buildBottomRecap()
      ],
    );
  }

  Widget _buildBottomRecap() {
    return Positioned(
        bottom: 0.0,
        left: 0.0,
        right: 0.0,
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              decoration: BoxDecoration(
                  color: AppColors.closeDialogColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  )),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Récapitulatif", style: AppStyles.subTitleWhite),
                  IconButton(
                    onPressed: () {
                      showCupertinoModalBottomSheet(
                        context: context,
                        expand: false,
                        enableDrag: true,
                        builder: (context) => RecapDialog(),
                      );
                    },
                    icon: FaIcon(FontAwesomeIcons.chevronUp,
                        color: AppColors.white, size: 13),
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}
