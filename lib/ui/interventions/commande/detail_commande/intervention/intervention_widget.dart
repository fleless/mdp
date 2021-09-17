import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mdp/constants/app_colors.dart';
import 'package:mdp/constants/app_constants.dart';
import 'package:mdp/constants/app_images.dart';
import 'package:mdp/constants/endpoints.dart';
import 'package:mdp/constants/routes.dart';
import 'package:mdp/constants/styles/app_styles.dart';
import 'package:mdp/ui/interventions/commande/detail_commande/intervention/recap_dialog.dart';
import 'package:mdp/ui/interventions/commande/detail_commande/intervention/steps/finalisation_intervention/finalisation_intervention_widget.dart';
import 'package:mdp/ui/interventions/commande/detail_commande/intervention/steps/prise_rdv/prise_rdv_bloc.dart';
import 'package:mdp/ui/interventions/commande/detail_commande/intervention/steps/prise_rdv/prise_rdv_widget.dart';
import 'package:mdp/ui/interventions/commande/detail_commande/intervention/steps/readction_devis/redaction_devis_widget.dart';
import 'package:mdp/ui/interventions/commande/detail_commande/intervention/steps/realisation_travaux/realisation_travaux_widget.dart';
import 'package:mdp/utils/shared_preferences.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import '../../../interventions_bloc.dart';

class InterventionWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _InterventionWidgetState();
}

class _InterventionWidgetState extends State<InterventionWidget> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final bloc = Modular.get<InterventionsBloc>();
  final _rdvBloc = Modular.get<PriseRdvBloc>();
  final sharedPref = Modular.get<SharedPref>();
  bool _loading = true;

  @override
  void initState() {
    _loadDatas();
    bloc.changesNotifier.listen((value) {
      if (mounted) setState(() {});
    });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  _loadDatas() async {
    setState(() {
      _loading = true;
    });
    String _subcontractorId =
        await sharedPref.read(AppConstants.SUBCONTRACTOR_ID_KEY);
    await _rdvBloc.getUserAppointmentsForSpecificOrder(_subcontractorId,
        bloc.interventionDetail.interventionDetail.id.toString());
    setState(() {
      _loading = false;
    });
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
        _loading
            ? Container(
                height: double.infinity,
                alignment: Alignment.center,
                child: SizedBox(
                  height: 50,
                  width: 50,
                  child: CircularProgressIndicator(
                    color: AppColors.md_dark_blue,
                  ),
                ),
              )
            : SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Container(
                  child: Column(mainAxisSize: MainAxisSize.min, children: [
                    PriseRdvWidget(),
                    Container(height: 1, color: AppColors.md_gray),
                    RedactionDevisWidget(),
                    Container(height: 1, color: AppColors.md_gray),
                    RealisationTravauxWidget(),
                    Container(height: 1, color: AppColors.md_gray),
                    FinalisationInterventionWidget(),
                    Container(height: 1, color: AppColors.md_gray),
                    if (bloc.interventionDetail.interventionDetail.state.name ==
                        "WORK_FINISHED")
                      _InterventionTermineWidget(),
                    SizedBox(height: 150),
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

  _InterventionTermineWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image.asset(AppImages.workEnded),
        SizedBox(height: 15),
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: AppColors.md_dark_blue,
          ),
          padding: EdgeInsets.all(AppConstants.default_padding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text("Une autre demande ?", style: AppStyles.header2White),
              Padding(
                padding: EdgeInsets.symmetric(
                    vertical: AppConstants.default_padding),
                child: ElevatedButton(
                  child: Ink(
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.all(
                        Radius.circular(12),
                      ),
                      border: Border.all(color: AppColors.white),
                    ),
                    child: Container(
                      alignment: Alignment.center,
                      margin: EdgeInsets.symmetric(horizontal: 40),
                      width: double.infinity,
                      height: 55,
                      child: Text(
                        "CRÉER UNE NOUVELLE COMMANDE POUR CE CLIENT",
                        style: AppStyles.buttonTextDarkBlue,
                        textAlign: TextAlign.center,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                  onPressed: () {
                    Modular.to.pushNamed(Routes.creationNouvelleCommande);
                  },
                  style: ElevatedButton.styleFrom(
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      onPrimary: AppColors.md_dark_blue,
                      primary: Colors.transparent,
                      padding: EdgeInsets.zero,
                      textStyle:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.all(AppConstants.default_padding),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text("Récapitulatif de l’intervention",
                style: AppStyles.largeTextBoldDefaultBlack),
            RichText(
              textAlign: TextAlign.left,
              maxLines: 10,
              overflow: TextOverflow.clip,
              text: TextSpan(
                children: [
                  TextSpan(text: "Partenaire : ", style: AppStyles.textNormal),
                  TextSpan(
                      text: bloc.interventionDetail.interventionDetail
                          .subcontractors.first.company.name,
                      style: AppStyles.textNormalBold),
                ],
              ),
            ),
            SizedBox(height: 10),
            RichText(
              textAlign: TextAlign.left,
              maxLines: 10,
              overflow: TextOverflow.clip,
              text: TextSpan(
                children: [
                  TextSpan(
                      text: "N° de référence : ", style: AppStyles.textNormal),
                  TextSpan(
                      text: bloc.interventionDetail.interventionDetail.code,
                      style: AppStyles.textNormalBold),
                ],
              ),
            ),
            SizedBox(height: 30),
            for (var i in bloc.interventionDetail.interventionDetail.details)
              Padding(
                  padding: EdgeInsets.only(top: 10),
                  child: _orderCase(i.ordercase.code, i.ordercase.name)),
          ]),
        ),
        _buildPhotos(),
        _buildFourchetteTarifiaire(),
      ],
    );
  }

  Widget _orderCase(String code, String name) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(15),
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.md_dark_blue),
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(15),
              topLeft: Radius.circular(15),
            ),
            color: AppColors.md_dark_blue,
          ),
          child: Text(code + " - " + name,
              style: AppStyles.smallTitleWhite,
              textAlign: TextAlign.start,
              maxLines: 5,
              overflow: TextOverflow.ellipsis),
        ),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(15),
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.md_dark_blue),
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(15),
              bottomRight: Radius.circular(15),
            ),
            color: AppColors.white,
          ),
          child: Text(
              ((bloc.interventionDetail.interventionDetail.indication ==
                          null) ||
                      (bloc.interventionDetail.interventionDetail.indication ==
                          ""))
                  ? "Aucun commentaire."
                  : bloc.interventionDetail.interventionDetail.indication,
              style: AppStyles.textNormal,
              textAlign: TextAlign.start,
              maxLines: 5,
              overflow: TextOverflow.ellipsis),
        ),
      ],
    );
  }

  Widget _buildPhotos() {
    return Padding(
      padding: EdgeInsets.all(AppConstants.default_padding),
      child: Container(
        width: double.infinity,
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text("Photos du client",
              style: AppStyles.header2, overflow: TextOverflow.ellipsis),
          SizedBox(height: 10),
          bloc.interventionDetail.interventionDetail.clientPhotos.length == 0
              ? Padding(
                  padding: EdgeInsets.all(AppConstants.default_padding * 2),
                  child: Center(
                    child: Text(
                      "Aucune photo",
                      style: AppStyles.bodyMdTextLight,
                    ),
                  ),
                )
              : Container(
                  height: 250,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: bloc.interventionDetail.interventionDetail
                          .clientPhotos.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () => {
                            Modular.to.pushNamed(Routes.photoView, arguments: {
                              'image': bloc.interventionDetail
                                  .interventionDetail.clientPhotos[index],
                              'path': ""
                            })
                          },
                          child: Card(
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            elevation: 4,
                            child: Container(
                              width: 180,
                              child: Hero(
                                tag: AppConstants.IMAGE_VIEWER_TAG,
                                child: Image.network(
                                    bloc.interventionDetail.interventionDetail
                                        .clientPhotos[index],
                                    fit: BoxFit.cover),
                              ),
                            ),
                          ),
                        );
                      }),
                )
        ]),
      ),
    );
  }

  Widget _buildFourchetteTarifiaire() {
    return Padding(
      padding: EdgeInsets.all(AppConstants.default_padding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Fourchette tarifaire :",
            style: AppStyles.header2,
            textAlign: TextAlign.left,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          Container(
            width: double.infinity,
            height: 50,
            child: ListTile(
              minLeadingWidth: 15,
              leading: Container(
                height: double.infinity,
                width: 30,
                child: Center(
                  child: FaIcon(
                    FontAwesomeIcons.euroSign,
                    color: AppColors.default_black,
                    size: 16,
                  ),
                ),
              ),
              title: Text(
                  "Min : " +
                      bloc.interventionDetail.interventionDetail.totalMinPrice
                          .toString() +
                      " € - Max : " +
                      bloc.interventionDetail.interventionDetail.totalMaxPrice
                          .toString() +
                      " €",
                  style: AppStyles.body,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis),
              subtitle: Text(
                  "Montant pré-bloqué " +
                      bloc.interventionDetail.interventionDetail.amountToBlock
                          .toString() +
                      " €",
                  style: AppStyles.smallGray,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis),
            ),
          ),
        ],
      ),
    );
  }
}
