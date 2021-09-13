import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mdp/constants/app_colors.dart';
import 'package:mdp/constants/app_constants.dart';
import 'package:mdp/constants/routes.dart';
import 'package:mdp/constants/styles/app_styles.dart';
import 'package:mdp/models/responses/user_appointments_response.dart';
import 'package:mdp/ui/interventions/commande/detail_commande/intervention/steps/prise_rdv/prise_rdv_bloc.dart';
import 'package:mdp/utils/date_formatter.dart';
import 'dart:math' as math;

import '../../../../../interventions_bloc.dart';

class RealisationTravauxWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _RealisationTravauxWidgetState();
}

class _RealisationTravauxWidgetState extends State<RealisationTravauxWidget> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final bloc = Modular.get<InterventionsBloc>();
  final _priseRdvbloc = Modular.get<PriseRdvBloc>();
  bool opened = false;
  bool _loading = false;

  @override
  void initState() {
    super.initState();
    bloc.changesNotifier.listen((value) {
      if (mounted) setState(() {});
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  _weAreInThisStep() {
    if (bloc.dernierDevis == null) {
      return false;
    }
    if (bloc.dernierDevis.quoteData == null) {
      return false;
    }
    return bloc.dernierDevis.quoteData.quote.state.code == "CLIENT_SIGNED";
  }

  _weAreBeforeThisStep() {
    if (bloc.dernierDevis == null) {
      return true;
    }
    if (bloc.dernierDevis.quoteData == null) {
      return true;
    }
    return bloc.dernierDevis.quoteData.quote.state.code != "CLIENT_SIGNED" &&
        (bloc.interventionDetail.interventionDetail.state.name !=
            "WAITING_FINISH");
  }

  _weEndedThisStep() {
    if (bloc.dernierDevis == null) {
      return false;
    }
    if (bloc.dernierDevis.quoteData == null) {
      return false;
    }
    return (bloc.dernierDevis.quoteData.quote.state.code == "CLIENT_SIGNED") &&
        (bloc.interventionDetail.interventionDetail.state.name ==
            "WAITING_FINISH");
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
              color: _weEndedThisStep()
                  ? AppColors.white
                  : _weAreInThisStep()
                      ? AppColors.md_light_gray
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
            _weAreInThisStep()
                ? Container(
                    width: 30.0,
                    height: 30.0,
                    alignment: Alignment.center,
                    decoration: new BoxDecoration(
                      color: _weEndedThisStep()
                          ? AppColors.white
                          : AppColors.md_dark_blue,
                      shape: BoxShape.circle,
                      border: Border.all(
                          color: _weEndedThisStep()
                              ? AppColors.md_primary
                              : _weAreInThisStep()
                                  ? AppColors.md_dark_blue
                                  : AppColors.md_primary,
                          width: 1.5),
                    ),
                    child: _weEndedThisStep()
                        ? Icon(
                            Icons.done,
                            color: AppColors.md_primary,
                            size: 16,
                          )
                        : Transform.rotate(
                            angle: -math.pi / 2,
                            child: FaIcon(
                              FontAwesomeIcons.hammer,
                              color: AppColors.white,
                              size: 16,
                            ),
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
                      "3",
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
                  Text("Réalisation des travaux",
                      style: _weAreInThisStep()
                          ? AppStyles.header2DarkBlue
                          : AppStyles.header2Gray),
                  _weAreInThisStep() ? SizedBox(height: 5) : SizedBox.shrink(),
                  _weAreInThisStep()
                      ? Container(
                          padding: EdgeInsets.all(7),
                          decoration: BoxDecoration(
                            color: _weEndedThisStep()
                                ? AppColors.md_secondary
                                : AppColors.mdAlert,
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                          ),
                          child: Text(
                              _weEndedThisStep()
                                  ? "  Validé "
                                  : "  À réaliser ",
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
              height: 30,
              child: IconButton(
                onPressed: () {
                  _weAreInThisStep()
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
                    color: _weEndedThisStep()
                        ? AppColors.md_primary
                        : _weAreInThisStep()
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
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      color: _weEndedThisStep()
          ? AppColors.white
          : _weAreInThisStep()
              ? AppColors.md_light_gray
              : AppColors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (_priseRdvbloc.userOrderTravauxResponse != null)
            for (var i in _priseRdvbloc.userOrderTravauxResponse)
              _buildRdvBloc(i),
          if (!_weEndedThisStep()) _buildButtons(),
        ],
      ),
    );
  }

  Widget _buildButtons() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        if (_priseRdvbloc.userOrderTravauxResponse != null)
          SizedBox(height: 12),
        _buildRealiserButton(),
        SizedBox(height: 12),
        _buildValidateButton(),
        SizedBox(height: 12),
      ],
    );
  }

  Widget _buildRdvBloc(ListVisitData i) {
    return Padding(
      padding: EdgeInsets.only(bottom: 10),
      child: Container(
        width: double.infinity,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: _weEndedThisStep() ? AppColors.md_light_gray : AppColors.white,
          borderRadius: BorderRadius.circular(AppConstants.default_Radius),
          border: Border.all(color: AppColors.md_light_gray, width: 1.5),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 20),
            Text("Date du rendez-vous",
                style: AppStyles.bodyMdTextLight,
                maxLines: 1,
                overflow: TextOverflow.ellipsis),
            SizedBox(height: 10),
            Text(
              DateFormatter.formatSecondDate(i.startDate),
              style: AppStyles.header2,
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildRealiserButton() {
    return ElevatedButton(
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
          height: 50,
          child: Text(
            "PLANIFIER L'INTERVENTION",
            style: AppStyles.buttonTextWhite,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
      onPressed: () {
        Modular.to.pushNamed(Routes.calendrierRealisationRDV);
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

  Widget _buildValidateButton() {
    return ElevatedButton(
      child: Ink(
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.all(
            Radius.circular(12),
          ),
          border: Border.all(color: AppColors.md_dark_blue),
        ),
        child: Container(
          alignment: Alignment.center,
          width: double.infinity,
          height: 50,
          child: _loading
              ? Center(
                  child: CircularProgressIndicator(
                    color: AppColors.md_dark_blue,
                  ),
                )
              : Text(
                  "TERMINER L'INTERVENTION",
                  style: AppStyles.buttonTextDarkBlue,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
        ),
      ),
      onPressed: () async {
        if (!_loading) {
          setState(() {
            _loading = true;
          });
          await bloc.changeOrderState(
              bloc.interventionDetail.interventionDetail.id,
              5,
              bloc.interventionDetail.interventionDetail.uuid);
          await bloc.getInterventionDetail(
              bloc.interventionDetail.interventionDetail.uuid);
          setState(() {
            _loading = false;
          });
        }
      },
      style: ElevatedButton.styleFrom(
          elevation: 5,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          onPrimary: AppColors.md_dark_blue,
          primary: Colors.transparent,
          padding: EdgeInsets.zero,
          textStyle: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
    );
  }
}
