import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mdp/constants/app_colors.dart';
import 'package:mdp/constants/styles/app_styles.dart';
import 'package:collection/collection.dart';
import 'package:mdp/ui/interventions/commande/detail_commande/intervention/steps/finalisation_intervention/finalisation_intervention_bloc.dart';
import 'package:mdp/ui/interventions/commande/detail_commande/intervention/steps/prise_rdv/prise_rdv_bloc.dart';
import 'package:mdp/utils/date_formatter.dart';
import 'package:signature/signature.dart';

import '../../../../../../interventions_bloc.dart';

class ShowPvFinTravauxWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ShowPvFinTravauxWidgetState();
}

class _ShowPvFinTravauxWidgetState extends State<ShowPvFinTravauxWidget> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final bloc = Modular.get<InterventionsBloc>();
  final _priseRdvbloc = Modular.get<PriseRdvBloc>();
  final _finalisationInterventionbloc =
      Modular.get<FinalisationInterventionBloc>();
  bool _checkBoxFirst = false;
  bool _checkBoxSecond = false;
  final TextEditingController _messageController = TextEditingController();
  final SignatureController _controllerArtisan = SignatureController(
    penStrokeWidth: 5,
    penColor: AppColors.default_black,
    exportBackgroundColor: AppColors.white,
  );
  final SignatureController _controllerClient = SignatureController(
    penStrokeWidth: 5,
    penColor: AppColors.default_black,
    exportBackgroundColor: AppColors.white,
  );
  bool _loading = false;

  @override
  void initState() {
    super.initState();
    _controllerClient.addListener(() {
      setState(() {});
    });
    _controllerArtisan.addListener(() {
      setState(() {});
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
            padding: EdgeInsets.symmetric(horizontal: 0, vertical: 15),
            color: AppColors.white,
            child: Column(
              children: [
                _buildSociete(),
                _buildClient(),
                _buildCommande(),
                _buildIntervention(),
                _buildCheckBoxes(),
                _buildObservation(),
                _buildSingatureArtisanBloc(),
                _buildSingatureClientBloc(),
                _buildButton(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSociete() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
      color: AppColors.md_light_gray,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Société intervenante :",
            style: AppStyles.header2DarkBlue,
          ),
          SizedBox(height: 15),
          Padding(
            padding: EdgeInsets.only(left: 30, bottom: 5),
            child: Text(
                bloc.interventionDetail.interventionDetail.subcontractors ==
                        null
                    ? "Non renseignée"
                    : bloc.interventionDetail.interventionDetail.subcontractors
                                .length ==
                            0
                        ? "Non renseignée"
                        : bloc.interventionDetail.interventionDetail
                            .subcontractors.first.company.name,
                style: AppStyles.body,
                overflow: TextOverflow.ellipsis,
                maxLines: 2),
          ),
          Padding(
            padding: EdgeInsets.only(left: 30, bottom: 5),
            child: Text(
                bloc.interventionDetail.interventionDetail.subcontractors.first
                            .company.commchannels ==
                        null
                    ? "Numéro de téléphone non renseigné"
                    : bloc.interventionDetail.interventionDetail.subcontractors
                            .first.company.commchannels
                            .where((element) => element.type.name == "Phone")
                            .isEmpty
                        ? "Numéro de téléphone non renseigné"
                        : bloc.interventionDetail.interventionDetail
                            .subcontractors.first.company.commchannels
                            .firstWhere(
                                (element) => element.type.name == "Phone")
                            .name,
                style: AppStyles.body,
                overflow: TextOverflow.ellipsis,
                maxLines: 2),
          ),
          Padding(
            padding: EdgeInsets.only(left: 30, bottom: 0),
            child:
                Text(
                    bloc.interventionDetail.interventionDetail.subcontractors
                            .first.company.addresses.first.streetNumber +
                        " " +
                        bloc
                            .interventionDetail
                            .interventionDetail
                            .subcontractors
                            .first
                            .company
                            .addresses
                            .first
                            .streetName +
                        ", " +
                        bloc
                            .interventionDetail
                            .interventionDetail
                            .subcontractors
                            .first
                            .company
                            .addresses
                            .first
                            .city
                            .postcode +
                        " " +
                        bloc
                            .interventionDetail
                            .interventionDetail
                            .subcontractors
                            .first
                            .company
                            .addresses
                            .first
                            .city
                            .name,
                    style: AppStyles.body,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2),
          ),
        ],
      ),
    );
  }

  Widget _buildClient() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
      color: AppColors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Client :",
            style: AppStyles.header2DarkBlue,
          ),
          SizedBox(height: 15),
          Padding(
            padding: EdgeInsets.only(left: 30, bottom: 5),
            child: Text(
                bloc.interventionDetail.interventionDetail.clients.firstname +
                    " " +
                    bloc.interventionDetail.interventionDetail.clients.lastname,
                style: AppStyles.body,
                overflow: TextOverflow.ellipsis,
                maxLines: 2),
          ),
          Padding(
            padding: EdgeInsets.only(left: 30, bottom: 5),
            child: Text(
                bloc.interventionDetail.interventionDetail.clients.addresses
                        .first.streetNumber +
                    " " +
                    bloc.interventionDetail.interventionDetail.clients.addresses
                        .first.streetName,
                style: AppStyles.body,
                overflow: TextOverflow.ellipsis,
                maxLines: 2),
          ),
          Padding(
            padding: EdgeInsets.only(left: 30, bottom: 25),
            child: Text(
                bloc.interventionDetail.interventionDetail.clients.addresses
                        .first.city.postcode +
                    " " +
                    bloc.interventionDetail.interventionDetail.clients.addresses
                        .first.city.name,
                style: AppStyles.body,
                overflow: TextOverflow.ellipsis,
                maxLines: 2),
          ),
        ],
      ),
    );
  }

  Widget _buildCommande() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
      color: AppColors.md_light_gray,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Commande :",
            style: AppStyles.header2DarkBlue,
          ),
          SizedBox(height: 15),
          Padding(
            padding: EdgeInsets.only(left: 30, bottom: 5),
            child: Text("N° " + bloc.interventionDetail.interventionDetail.code,
                style: AppStyles.body,
                overflow: TextOverflow.ellipsis,
                maxLines: 2),
          ),
          Padding(
            padding: EdgeInsets.only(left: 30, bottom: 0),
            child: Text(
                DateFormatter.formatDateToDDMMYYYY(bloc.interventionDetail
                    .interventionDetail.quotes.first.created.date),
                style: AppStyles.body,
                overflow: TextOverflow.ellipsis,
                maxLines: 2),
          ),
        ],
      ),
    );
  }

  Widget _buildIntervention() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
      color: AppColors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Intervention réalisée :",
            style: AppStyles.header2DarkBlue,
          ),
          SizedBox(height: 15),
          Padding(
            padding: EdgeInsets.only(left: 30, bottom: 15),
            child: Text("Date de l'intervention",
                style: AppStyles.body,
                overflow: TextOverflow.ellipsis,
                maxLines: 2),
          ),
          if (_priseRdvbloc.userOrderTravauxResponse.length == 0)
            Padding(
              padding: EdgeInsets.only(left: 30, bottom: 6),
              child: Text(
                  DateFormatter.formatSecondDate(_priseRdvbloc
                      .userOrderAppointmentsResponse.first.startDate),
                  style: AppStyles.bodyBold,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2),
            ),
          if (_priseRdvbloc.userOrderTravauxResponse.length != 0)
            for (var element in _priseRdvbloc.userOrderTravauxResponse)
              Padding(
                padding: EdgeInsets.only(left: 30, bottom: 6),
                child: Text(DateFormatter.formatSecondDate(element.startDate),
                    style: AppStyles.bodyBold,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2),
              ),
          SizedBox(height: 30),
          Padding(
            padding: EdgeInsets.only(left: 30, bottom: 15),
            child: Text("Lieu",
                style: AppStyles.body,
                overflow: TextOverflow.ellipsis,
                maxLines: 2),
          ),
          Padding(
            padding: EdgeInsets.only(left: 30, bottom: 6),
            child: Text(
                bloc.interventionDetail.interventionDetail.interventionAddress
                        .streetNumber +
                    " " +
                    bloc.interventionDetail.interventionDetail
                        .interventionAddress.streetName,
                style: AppStyles.bodyBold,
                overflow: TextOverflow.ellipsis,
                maxLines: 2),
          ),
          Padding(
            padding: EdgeInsets.only(left: 30, bottom: 6),
            child: Text(
                bloc.interventionDetail.interventionDetail.interventionAddress
                        .city.postcode +
                    " " +
                    bloc.interventionDetail.interventionDetail
                        .interventionAddress.city.name,
                style: AppStyles.bodyBold,
                overflow: TextOverflow.ellipsis,
                maxLines: 2),
          ),
          SizedBox(height: 30),
          Padding(
            padding: EdgeInsets.only(left: 30, bottom: 15),
            child: Text("Nature des travaux",
                style: AppStyles.body,
                overflow: TextOverflow.ellipsis,
                maxLines: 2),
          ),
          for (var element
              in bloc.interventionDetail.interventionDetail.details)
            Padding(
              padding: EdgeInsets.only(left: 30, bottom: 6),
              child: Text(element.ordercase.name,
                  style: AppStyles.bodyBold,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2),
            ),
        ],
      ),
    );
  }

  Widget _buildCheckBoxes() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
      color: AppColors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Je, sousigné(e) ",
            style: AppStyles.header2DarkBlue,
          ),
          SizedBox(height: 20),
          _buildCheckBoxFirst(),
          SizedBox(height: 10),
          _buildCheckBoxSecond(),
        ],
      ),
    );
  }

  Widget _buildCheckBoxFirst() {
    return Theme(
      data: ThemeData(unselectedWidgetColor: AppColors.md_dark_blue),
      child: CheckboxListTile(
        contentPadding: EdgeInsets.only(left: 0),
        title: Text(
            "Reconnais que les travaux effectués me donnent entière satisfaction et sont conformes aux prestations prévues par le devis. Je donne quitus de fin travaux à l'entreprise ci-dessus et n'émets aucune réserve.",
            style: AppStyles.body),
        checkColor: AppColors.white,
        activeColor: AppColors.md_dark_blue,
        value: _checkBoxFirst,
        onChanged: (newValue) {
          setState(() {
            _checkBoxFirst = newValue;
          });
        },
        controlAffinity:
            ListTileControlAffinity.leading, //  <-- leading Checkbox
      ),
    );
  }

  Widget _buildCheckBoxSecond() {
    return Theme(
      data: ThemeData(unselectedWidgetColor: AppColors.md_dark_blue),
      child: CheckboxListTile(
        contentPadding: EdgeInsets.only(left: 0),
        title: Text(
            "Emets les réserves mentionnées ci-dessous quant à la réalisation des travaux je demande leurs levées dans les meilleurs délais.",
            style: AppStyles.body),
        checkColor: AppColors.white,
        activeColor: AppColors.md_dark_blue,
        value: _checkBoxSecond,
        onChanged: (newValue) {
          setState(() {
            _checkBoxSecond = newValue;
          });
        },
        controlAffinity:
            ListTileControlAffinity.leading, //  <-- leading Checkbox
      ),
    );
  }

  Widget _buildObservation() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
      color: AppColors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Observation client",
            style: AppStyles.body,
          ),
          SizedBox(height: 15),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 15),
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.white,
                border: Border.all(
                  color: AppColors.md_gray,
                  width: 1,
                ),
              ),
              width: double.infinity,
              height: 150,
              child: Align(
                alignment: Alignment.topLeft,
                child: TextFormField(
                  controller: _messageController,
                  obscureText: false,
                  cursorColor: AppColors.default_black,
                  keyboardType: TextInputType.multiline,
                  expands: true,
                  maxLines: null,
                  decoration: const InputDecoration(
                    filled: true,
                    fillColor: AppColors.md_light_gray,
                    border: InputBorder.none,
                    errorBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: AppColors.mdAlert, width: 1),
                    ),
                    contentPadding: EdgeInsets.only(
                        bottom: 10.0, left: 10.0, right: 10.0, top: 10.0),
                    errorStyle: TextStyle(height: 0),
                    hintText: "Commentaire facultatif",
                    hintStyle: AppStyles.textNormalPlaceholder,
                  ),
                  style: AppStyles.textNormal,
                  validator: (String value) => (value.trim().isEmpty)
                      ? 'Le message ne peut pas être vide'
                      : null,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSingatureArtisanBloc() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Signature de l'artisan",
            style: AppStyles.bodyBoldMdDarkBlue,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(height: 20),
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
              side: BorderSide(
                color: AppColors.hint,
                width: 0.3,
              ),
            ),
            clipBehavior: Clip.antiAlias,
            elevation: 4,
            child: Signature(
              controller: _controllerArtisan,
              width: double.infinity,
              height: 200,
              backgroundColor: AppColors.md_light_gray,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSingatureClientBloc() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Signature du client",
            style: AppStyles.bodyBoldMdDarkBlue,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(height: 20),
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
              side: BorderSide(
                color: AppColors.hint,
                width: 0.3,
              ),
            ),
            clipBehavior: Clip.antiAlias,
            elevation: 4,
            child: Signature(
              controller: _controllerClient,
              width: double.infinity,
              height: 200,
              backgroundColor: AppColors.md_light_gray,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildButton() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: ElevatedButton(
        child: Ink(
          decoration: BoxDecoration(
            color: _validButton() ? AppColors.md_dark_blue : AppColors.inactive,
            borderRadius: BorderRadius.all(
              Radius.circular(12),
            ),
            border: Border.all(
                color: _validButton()
                    ? AppColors.md_dark_blue
                    : AppColors.inactive),
          ),
          child: Container(
            alignment: Alignment.center,
            width: double.infinity,
            height: 55,
            child: _loading
                ? Center(
                    child: CircularProgressIndicator(
                      color: AppColors.white,
                    ),
                  )
                : Text(
                    "AJOUTER",
                    style: _validButton()
                        ? AppStyles.buttonTextWhite
                        : AppStyles.buttonInactiveText,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
          ),
        ),
        onPressed: () {
          _loading
              ? null
              : _validButton()
                  ? _generateDoc()
                  : null;
        },
        style: ElevatedButton.styleFrom(
            elevation: 5,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            onPrimary: AppColors.white,
            primary: Colors.transparent,
            padding: EdgeInsets.zero,
            textStyle: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
      ),
    );
  }

  bool _validButton() {
    return ((_checkBoxFirst) &&
        (_controllerArtisan.isNotEmpty) &&
        (_checkBoxSecond) &&
        (_controllerClient.isNotEmpty));
  }

  _generateDoc() async {
    setState(() {
      _loading = true;
    });
    bool valid = await _finalisationInterventionbloc
        .generatePVDocument(bloc.interventionDetail.interventionDetail.id);
    setState(() {
      _loading = false;
    });
    if (valid) {
      Modular.to.pop();
      await bloc.getInterventionDetail(
          bloc.interventionDetail.interventionDetail.uuid);
    } else {}
  }
}
