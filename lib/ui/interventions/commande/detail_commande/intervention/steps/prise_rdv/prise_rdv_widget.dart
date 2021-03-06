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

import '../../../../../interventions_bloc.dart';

class PriseRdvWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _PriseRdvWidgetState();
}

class _PriseRdvWidgetState extends State<PriseRdvWidget> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final bloc = Modular.get<InterventionsBloc>();
  final _rdvBloc = Modular.get<PriseRdvBloc>();
  bool opened = false;

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
                  ? AppColors.white
                  : AppColors.md_gray,
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
                color: _rdvBloc.userOrderAppointmentsResponse.length > 0
                    ? AppColors.white
                    : AppColors.md_dark_blue,
                shape: BoxShape.circle,
                border: Border.all(
                    color: _rdvBloc.userOrderAppointmentsResponse.length > 0
                        ? AppColors.md_primary
                        : AppColors.md_dark_blue,
                    width: 1.5),
              ),
              child: Icon(
                _rdvBloc.userOrderAppointmentsResponse.length > 0
                    ? Icons.done
                    : Icons.calendar_today,
                color: _rdvBloc.userOrderAppointmentsResponse.length > 0
                    ? AppColors.md_primary
                    : AppColors.white,
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
                      color: bloc.dernierDevis != null
                          ? AppColors.md_secondary
                          : (_rdvBloc.userOrderAppointmentsResponse.length > 0
                              ? AppColors.travaux
                              : AppColors.mdAlert),
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                    ),
                    child: Text(
                        bloc.dernierDevis != null
                            ? "Valid??"
                            : (_rdvBloc.userOrderAppointmentsResponse.length > 0
                                ? "Planifi??"
                                : "  ?? r??aliser "),
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
                    color: _rdvBloc.userOrderAppointmentsResponse.length > 0
                        ? AppColors.md_primary
                        : AppColors.md_dark_blue,
                    size: 12)),
          ],
        ),
      ],
    );
  }

  Widget _buildExpansion() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 0),
      color: _rdvBloc.userOrderAppointmentsResponse.length > 0
          ? AppColors.white
          : AppColors.md_gray,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: _rdvBloc.userOrderAppointmentsResponse.length > 0
                  ? AppColors.md_light_gray
                  : AppColors.white,
              borderRadius: BorderRadius.all(
                  Radius.circular(AppConstants.default_Radius)),
            ),
            child: Column(
              children: [
                Text(
                    _rdvBloc.userOrderAppointmentsResponse.length > 0
                        ? "Date du rendez-vous"
                        : "Date souhait??e du rendez-vous",
                    style: AppStyles.bodyMdTextLight,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis),
                SizedBox(height: 10),
                Text(
                  _rdvBloc.userOrderAppointmentsResponse.length > 0
                      ? DateFormatter.formatSecondDate(_rdvBloc
                          .userOrderAppointmentsResponse.first.startDate)
                      : (bloc.interventionDetail.interventionDetail
                                  .preferredVisitDate ==
                              null
                          ? "Non renseign??e"
                          : (DateFormatter.formatDate(bloc.interventionDetail
                              .interventionDetail.preferredVisitDate.date))),
                  style: AppStyles.header2,
                ),
              ],
            ),
          ),
          bloc.dernierDevis == null ? SizedBox(height: 15) : SizedBox.shrink(),
          bloc.dernierDevis == null
              ? ElevatedButton(
                  child: Ink(
                    decoration: BoxDecoration(
                      color: _rdvBloc.userOrderAppointmentsResponse.length > 0
                          ? AppColors.white
                          : AppColors.md_dark_blue,
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
                        _rdvBloc.userOrderAppointmentsResponse.length > 0
                            ? "MODIFIER LE RENDEZ-VOUS"
                            : "PLANIFIER LE RENDEZ-VOUS",
                        style: _rdvBloc.userOrderAppointmentsResponse.length > 0
                            ? AppStyles.buttonTextDarkBlue
                            : AppStyles.smallTitleWhite,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                  onPressed: () {
                    Modular.to.pushNamed(Routes.calendrierPriseRDV, arguments: {
                      'rdv': _rdvBloc.userOrderAppointmentsResponse.length > 0
                          ? _rdvBloc.userOrderAppointmentsResponse.first
                          : ListVisitData()
                    });
                  },
                  style: ElevatedButton.styleFrom(
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      onPrimary:
                          _rdvBloc.userOrderAppointmentsResponse.length > 0
                              ? AppColors.md_dark_blue
                              : AppColors.white,
                      primary: Colors.transparent,
                      padding: EdgeInsets.zero,
                      textStyle:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
                )
              : SizedBox.shrink(),
          SizedBox(height: 15),
        ],
      ),
    );
  }
}
