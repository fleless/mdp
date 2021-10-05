import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mdp/constants/app_colors.dart';
import 'package:mdp/constants/app_constants.dart';
import 'package:mdp/constants/routes.dart';
import 'package:mdp/constants/styles/app_styles.dart';
import 'package:mdp/models/responses/get_devis_response.dart';
import 'package:mdp/models/responses/updateQuoteResponse.dart';
import 'package:mdp/ui/interventions/commande/detail_commande/intervention/steps/readction_devis/redaction_devis_bloc.dart';
import 'package:mdp/widgets/gradients/md_gradient_light.dart';

import '../../../../../../interventions_bloc.dart';

class RedactionDevisScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _RedactionDevisScreenState();
}

class _RedactionDevisScreenState extends State<RedactionDevisScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final bloc = Modular.get<InterventionsBloc>();
  final _redactionBloc = Modular.get<RedactionDevisBloc>();
  bool opened = false;
  TextEditingController _tvaController = TextEditingController();
  TextEditingController _remiseController = TextEditingController();
  TextEditingController _franchiseController = TextEditingController();
  TextEditingController _accompteController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  //index is the position of the designation on the quote
  int index = 0;

  bool _saveButtonLoading = false;
  bool _signButtonLoading = false;

  @override
  void initState() {
    super.initState();
    _tvaController.text = "0";
    _remiseController.text = "0";
    _franchiseController.text = "0";
    _accompteController.text = "0";
    bloc.dernierDevis == null ? null : _initData();
    bloc.changesNotifier.listen((value) {
      if (mounted) {
        setState(() {});
      }
    });
  }

  _initData() {
    _tvaController.text = bloc.dernierDevis.quoteData.quote.vat.toString();
    _remiseController.text =
        bloc.dernierDevis.quoteData.quote.reducedSum.toString();
    _franchiseController.text =
        bloc.dernierDevis.quoteData.quote.franchise == null
            ? "0"
            : bloc.dernierDevis.quoteData.quote.franchise.toString();
    _accompteController.text =
        bloc.dernierDevis.quoteData.quote.advancePaymentSum == null
            ? "0"
            : bloc.dernierDevis.quoteData.quote.advancePaymentSum.toString();
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
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
        },
        child: SafeArea(
          child: SingleChildScrollView(
            child: Container(
              width: double.infinity,
              child: _buildContent(),
            ),
          ), //LoadingIndicator(loading: _bloc.loading),
          //NetworkErrorMessages(error: _bloc.error),
        ),
      ),
    );
  }

  Widget _buildContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(gradient: MdGradientLightt()),
          child: _buildHeader(),
        ),
        Padding(
          padding: EdgeInsets.all(AppConstants.default_padding),
          child: _buildBody(),
        ),
        Padding(
          padding: EdgeInsets.all(AppConstants.default_padding),
          child: _buildSignButton(),
        ),
        Padding(
          padding:
              EdgeInsets.symmetric(horizontal: AppConstants.default_padding),
          child: _buildSaveAndContinueAfterButton(),
        ),
        SizedBox(height: 30),
      ],
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: EdgeInsets.only(
          left: AppConstants.default_padding,
          right: AppConstants.default_padding,
          bottom: AppConstants.default_padding,
          top: AppConstants.default_padding * 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          RichText(
            textAlign: TextAlign.left,
            maxLines: 10,
            overflow: TextOverflow.clip,
            text: TextSpan(
              children: [
                TextSpan(
                    text: "Rédaction du devis \nIntervention n° ",
                    style: AppStyles.header1White),
                TextSpan(
                    text: bloc.interventionDetail.interventionDetail.code,
                    style: AppStyles.header1WhiteBold),
              ],
            ),
          ),
          InkWell(
            onTap: () {
              Modular.to.pop();
            },
            child: Icon(
              Icons.close_outlined,
              size: 25,
              color: AppColors.white,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBody() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        _buildDesignation(),
        SizedBox(height: 50),
        _buildRecap(),
      ],
    );
  }

  Widget _buildDesignation() {
    return Container(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(height: 15),
        Text("Rédaction du devis",
            style: AppStyles.largeTextBoldDefaultBlack,
            overflow: TextOverflow.ellipsis,
            maxLines: 5),
        SizedBox(height: 20),
        Text("Afin d’établir le devis, veuillez ajouter des désignations",
            style: AppStyles.bodyBlack,
            overflow: TextOverflow.ellipsis,
            maxLines: 5),
        (bloc.dernierDevis != null)
            ? (bloc.dernierDevis.quoteData.quote != null
                ? (bloc.dernierDevis.quoteData.designations.isEmpty
                    ? SizedBox.shrink()
                    : _buildListeDesignations())
                : SizedBox.shrink())
            : SizedBox.shrink(),
        SizedBox(height: 20),
        ElevatedButton(
          child: Ink(
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.all(
                Radius.circular(12),
              ),
            ),
            child: Container(
              alignment: Alignment.center,
              width: double.infinity,
              height: 55,
              child: DottedBorder(
                borderType: BorderType.RRect,
                radius: Radius.circular(12),
                padding: EdgeInsets.symmetric(vertical: 6, horizontal: 20),
                color: AppColors.md_tertiary,
                child: Stack(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Icon(
                        Icons.add_circle_outline_outlined,
                        color: AppColors.md_tertiary,
                      ),
                    ),
                    Center(
                      child: Text(
                        "AJOUTER UNE DÉSIGNATION",
                        style: AppStyles.buttonTextTertiary,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          onPressed: () {
            Modular.to.pushNamed(Routes.creationDesignation,
                arguments: {"designationToUpdate": null, "isAdd": true});
          },
          style: ElevatedButton.styleFrom(
              elevation: 5,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              onPrimary: AppColors.md_tertiary,
              primary: Colors.transparent,
              padding: EdgeInsets.zero,
              textStyle: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
        ),
      ],
    ));
  }

  Widget _buildListeDesignations() {
    index = 0;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (var i in bloc.dernierDevis.quoteData.designations)
          i.quoteReference == null
              ? SizedBox.shrink()
              : _buildSingleDesignation(i),
      ],
    );
  }

  Widget _buildSingleDesignation(Designations designation) {
    index++;
    return Padding(
      padding: EdgeInsets.only(top: 20),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(AppConstants.default_Radius),
          border: Border.all(color: AppColors.md_dark_blue),
        ),
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: AppColors.md_dark_blue,
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(AppConstants.default_Radius),
                    topLeft: Radius.circular(AppConstants.default_Radius)),
                border: Border.all(color: AppColors.md_dark_blue),
              ),
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 15),
              child: RichText(
                textAlign: TextAlign.left,
                maxLines: 10,
                overflow: TextOverflow.clip,
                text: TextSpan(
                  children: [
                    TextSpan(
                        text: designation.quoteReference.designation != null
                            ? designation.quoteReference.designation + " \n"
                            : "Nom non défini\n",
                        style: AppStyles.subheadingWhiteBold),
                    TextSpan(
                        text: "Désignation n°" + index.toString(),
                        style: AppStyles.smalltinyWhite),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildListWorkchargesForDesignation(designation),
                  SizedBox(height: 30),
                  Text(
                      "Total HT: " +
                          _calculHTTPriceWorkCharge(designation) +
                          "€",
                      style: AppStyles.header2,
                      overflow: TextOverflow.visible,
                      maxLines: 2),
                  SizedBox(height: 30),
                  ElevatedButton(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(
                          Radius.circular(12),
                        ),
                        border: Border.all(color: AppColors.md_dark_blue),
                      ),
                      alignment: Alignment.center,
                      width: double.infinity,
                      height: 55,
                      child: InkWell(
                        splashColor: AppColors.md_dark_blue,
                        child: Text(
                          "MODIFIER OU VOIR LE DÉTAIL",
                          style: AppStyles.buttonTextDarkBlue,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                    onPressed: () {
                      Modular.to.pushNamed(Routes.creationDesignation,
                          arguments: {
                            "designationToUpdate": designation,
                            "isAdd": false
                          });
                    },
                    style: ElevatedButton.styleFrom(
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        onPrimary: AppColors.md_dark_blue,
                        primary: Colors.white,
                        padding: EdgeInsets.zero,
                        textStyle: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.bold)),
                  ),
                  SizedBox(height: 20),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  _calculHTTPriceWorkCharge(Designations designation) {
    num total = 0;
    designation.details.forEach((element) {
      element.priceHt == null ? total += 0 : total += element.priceHt;
    });
    return total.toString();
  }

  Widget _buildListWorkchargesForDesignation(Designations designation) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (var i in designation.details)
          Padding(
            padding: EdgeInsets.only(top: 8),
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: AppColors.md_light_gray,
                border: Border.all(color: AppColors.placeHolder),
                borderRadius: BorderRadius.all(Radius.circular(8)),
              ),
              child: Text(i.name ?? "Nom non défini",
                  style: AppStyles.workChargeMdDark,
                  overflow: TextOverflow.visible,
                  maxLines: 2),
            ),
          ),
      ],
    );
  }

  Widget _buildRecap() {
    return Form(
      key: _formKey,
      child: Container(
        width: double.infinity,
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(AppConstants.default_Radius),
                    topRight: Radius.circular(AppConstants.default_Radius)),
                color: AppColors.md_dark_blue,
              ),
              width: double.infinity,
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Récapitulatif du devis",
                    style: AppStyles.buttonTextWhite,
                  ),
                  SizedBox(height: 5),
                  Text(
                    "Fourchette tarifaire " +
                        bloc.interventionDetail.interventionDetail.totalMinPrice
                            .toString() +
                        " €" +
                        " - " +
                        bloc.interventionDetail.interventionDetail.totalMaxPrice
                            .toString() +
                        " €",
                    style: AppStyles.bodyWhite,
                  ),
                ],
              ),
            ),
            Container(
              decoration: BoxDecoration(
                border: Border(
                  left: BorderSide(color: AppColors.md_dark_blue),
                  right: BorderSide(color: AppColors.md_dark_blue),
                ),
                color: AppColors.white,
              ),
              width: double.infinity,
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                    textAlign: TextAlign.left,
                    maxLines: 10,
                    overflow: TextOverflow.clip,
                    text: TextSpan(
                      children: [
                        TextSpan(
                            text: "Montant HT :  ",
                            style: AppStyles.bodyDefaultBlack),
                        TextSpan(
                            text: bloc.dernierDevis != null
                                ? bloc.dernierDevis.quoteData.quote.totalHt
                                    .toString()
                                : "0" + "€",
                            style: AppStyles.bodyBold),
                      ],
                    ),
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "TVA (%)",
                        style: AppStyles.bodyDefaultBlack,
                      ),
                      SizedBox(width: 10),
                      Expanded(child: _tvaEditText()),
                    ],
                  ),
                  SizedBox(height: 10),
                  Divider(color: AppColors.placeHolder),
                  SizedBox(height: 10),
                  RichText(
                    textAlign: TextAlign.left,
                    maxLines: 10,
                    overflow: TextOverflow.clip,
                    text: TextSpan(
                      children: [
                        TextSpan(
                            text: "Code promo : ",
                            style: AppStyles.bodyDefaultBlack),
                        TextSpan(
                            text: bloc.dernierDevis == null
                                ? "N/A"
                                : bloc.dernierDevis.quoteData.quote.promoCode,
                            style: AppStyles.bodyBold),
                      ],
                    ),
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          "Remise du professionnel (€ HT) :",
                          style: AppStyles.bodyDefaultBlack,
                        ),
                      ),
                      SizedBox(width: 10),
                      _remiseEditText(),
                      SizedBox(width: 10),
                    ],
                  ),
                  SizedBox(height: 10),
                  RichText(
                    textAlign: TextAlign.left,
                    maxLines: 10,
                    overflow: TextOverflow.clip,
                    text: TextSpan(
                      children: [
                        TextSpan(
                            text: "Prise en charge partenaire :  ",
                            style: AppStyles.bodyDefaultBlack),
                        TextSpan(
                            text: bloc.dernierDevis == null
                                ? "0"
                                : bloc.dernierDevis.quoteData.quote.coveredSum
                                        .toString() +
                                    "€",
                            style: AppStyles.bodyBold),
                      ],
                    ),
                  ),
                  SizedBox(height: 10),
                  Divider(color: AppColors.placeHolder),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Text(
                        "Franchise (€ HT):",
                        style: AppStyles.bodyDefaultBlack,
                      ),
                      SizedBox(width: 10),
                      _franchiseEditText(),
                      SizedBox(width: 10),
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Text(
                        "Accompte à verser  (€ HT):",
                        style: AppStyles.bodyDefaultBlack,
                      ),
                      SizedBox(width: 10),
                      _accompteEditText(),
                      SizedBox(width: 10),
                    ],
                  ),
                  SizedBox(height: 30),
                ],
              ),
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(AppConstants.default_Radius),
                    bottomRight: Radius.circular(AppConstants.default_Radius)),
                color: (bloc.dernierDevis == null)
                    ? AppColors.placeHolder
                    : (bloc.dernierDevis.quoteData.quote.totalTtc <
                            bloc.interventionDetail.interventionDetail
                                .totalMaxPrice
                        ? AppColors.md_secondary
                        : AppColors.mdAlert),
              ),
              width: double.infinity,
              padding: EdgeInsets.all(20),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    Icons.euro_outlined,
                    color: AppColors.white,
                    size: 20,
                  ),
                  SizedBox(width: 10),
                  Text(
                    "Montant TTC : " +
                        (bloc.dernierDevis == null
                            ? "0"
                            : bloc.dernierDevis.quoteData.quote.totalTtc
                                .toStringAsFixed(2)) +
                        "€",
                    style: AppStyles.header1WhiteBold,
                  ),
                  SizedBox(width: 10),
                  bloc.dernierDevis == null
                      ? SizedBox.shrink()
                      : (bloc.dernierDevis.quoteData.quote.totalTtc >
                              bloc.interventionDetail.interventionDetail
                                  .totalMaxPrice)
                          ? Center(
                              child: Icon(
                                Icons.info,
                                color: AppColors.white,
                                size: 20,
                              ),
                            )
                          : SizedBox.shrink(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSignButton() {
    return ElevatedButton(
      child: Ink(
        decoration: BoxDecoration(
          color: bloc.dernierDevis == null
              ? AppColors.inactive
              : AppColors.md_dark_blue,
          borderRadius: BorderRadius.all(
            Radius.circular(12),
          ),
          border: Border.all(
              color: bloc.dernierDevis == null
                  ? AppColors.inactive
                  : AppColors.md_dark_blue),
        ),
        child: Container(
          alignment: Alignment.center,
          width: double.infinity,
          height: 55,
          child: _signButtonLoading
              ? Center(
                  child: CircularProgressIndicator(
                  color: AppColors.white,
                ))
              : Text(
                  "SIGNER ET GENERER LE DEVIS",
                  style: bloc.dernierDevis == null
                      ? AppStyles.buttonInactiveText
                      : AppStyles.buttonTextWhite,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
        ),
      ),
      onPressed: () async {
        if ((!_signButtonLoading) && (bloc.dernierDevis != null)) {
          setState(() {
            _signButtonLoading = true;
          });
          if (_formKey.currentState.validate()) {
            bool verif = await _updateQuote();
            if (verif) Modular.to.pushReplacementNamed(Routes.signatureArtisan);
          }
          setState(() {
            _signButtonLoading = false;
          });
        }
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

  Widget _buildSaveAndContinueAfterButton() {
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
          height: 55,
          child: _saveButtonLoading
              ? Center(
                  child: CircularProgressIndicator(
                    color: AppColors.md_dark_blue,
                  ),
                )
              : Text(
                  "ENREGISTRER ET CONTINUER PLUS TARD",
                  style: AppStyles.buttonTextDarkBlue,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
        ),
      ),
      onPressed: () {
        _saveButtonLoading ? null : _saveAndContinueAfterAction();
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

  _saveAndContinueAfterAction() async {
    setState(() {
      _saveButtonLoading = true;
    });
    if (!(bloc.dernierDevis == null)) await _updateQuote();
    setState(() {
      _saveButtonLoading = false;
    });
    Modular.to.pop();
  }

  Widget _tvaEditText() {
    return Container(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 60,
            height: 40,
            child: TextFormField(
              cursorColor: AppColors.default_black,
              controller: _tvaController,
              textAlign: TextAlign.center,
              style: AppStyles.textNormal,
              textAlignVertical: TextAlignVertical.center,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.allow(RegExp(r'(^\d+\.?\d?\d?)')),
              ],
              keyboardType: TextInputType.number,
              onChanged: (value) {
                if (_formKey.currentState.validate()) {
                  _updateQuote();
                }
              },
              decoration: InputDecoration(
                errorStyle: TextStyle(height: 0),
                contentPadding: EdgeInsets.zero,
                filled: true,
                fillColor: AppColors.md_light_gray,
                floatingLabelBehavior: FloatingLabelBehavior.never,
                border: OutlineInputBorder(
                  borderSide:
                      BorderSide(color: AppColors.placeHolder, width: 5.0),
                  borderRadius: BorderRadius.circular(10),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide:
                      BorderSide(color: AppColors.placeHolder, width: 1.0),
                  borderRadius: BorderRadius.circular(10),
                ),
                errorBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: AppColors.mdAlert, width: 1.0),
                  borderRadius: BorderRadius.circular(10),
                ),
                labelText: '',
              ),
              validator: (value) {
                if (value.isEmpty) {
                  return "";
                } else if (value.endsWith(".")) {
                  return "";
                } else if ((double.parse(value) > 100) ||
                    (double.parse(value) < 0)) {
                  return "";
                } else
                  return null;
              },
            ),
          ),
          SizedBox(width: 10),
          Text(
              ": " +
                  (bloc.dernierDevis == null
                      ? "0"
                      : bloc.dernierDevis.quoteData.quote.vatAmount
                          .toStringAsFixed(2)) +
                  "€",
              style: AppStyles.bodyBold),
        ],
      ),
    );
  }

  Widget _remiseEditText() {
    return Container(
      width: 60,
      height: 40,
      child: TextFormField(
        cursorColor: AppColors.default_black,
        controller: _remiseController,
        textAlign: TextAlign.center,
        style: AppStyles.textNormal,
        textAlignVertical: TextAlignVertical.center,
        inputFormatters: <TextInputFormatter>[
          FilteringTextInputFormatter.allow(RegExp(r'(^\d+\.?\d?\d?)')),
        ],
        keyboardType: TextInputType.number,
        onChanged: (value) {
          if (_formKey.currentState.validate()) {
            _updateQuote();
          }
        },
        decoration: InputDecoration(
          errorStyle: TextStyle(height: 0),
          contentPadding: EdgeInsets.zero,
          filled: true,
          fillColor: AppColors.md_light_gray,
          floatingLabelBehavior: FloatingLabelBehavior.never,
          border: OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.placeHolder, width: 5.0),
            borderRadius: BorderRadius.circular(10),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.placeHolder, width: 1.0),
            borderRadius: BorderRadius.circular(10),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.mdAlert, width: 1.0),
            borderRadius: BorderRadius.circular(10),
          ),
          labelText: '',
          labelStyle: AppStyles.textNormal,
        ),
        validator: (value) {
          if (value.isEmpty) {
            return "";
          } else if (value.endsWith(".")) {
            return "";
          } else
            return null;
        },
      ),
    );
  }

  Widget _franchiseEditText() {
    return Container(
      width: 60,
      height: 40,
      child: TextFormField(
        cursorColor: AppColors.default_black,
        controller: _franchiseController,
        textAlign: TextAlign.center,
        style: AppStyles.textNormal,
        textAlignVertical: TextAlignVertical.center,
        inputFormatters: <TextInputFormatter>[
          FilteringTextInputFormatter.allow(RegExp(r'(^\d+\.?\d?\d?)')),
        ],
        keyboardType: TextInputType.number,
        onChanged: (value) {
          if (_formKey.currentState.validate()) {
            _updateQuote();
          }
        },
        decoration: InputDecoration(
          errorStyle: TextStyle(height: 0),
          contentPadding: EdgeInsets.zero,
          filled: true,
          fillColor: AppColors.md_light_gray,
          floatingLabelBehavior: FloatingLabelBehavior.never,
          border: OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.placeHolder, width: 5.0),
            borderRadius: BorderRadius.circular(10),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.placeHolder, width: 1.0),
            borderRadius: BorderRadius.circular(10),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.mdAlert, width: 1.0),
            borderRadius: BorderRadius.circular(10),
          ),
          labelText: '',
          labelStyle: AppStyles.textNormal,
        ),
        validator: (value) {
          if (value.isEmpty) {
            return "";
          } else if (value.endsWith(".")) {
            return "";
          } else
            return null;
        },
      ),
    );
  }

  Widget _accompteEditText() {
    return Container(
      width: 60,
      height: 40,
      child: TextFormField(
        cursorColor: AppColors.default_black,
        controller: _accompteController,
        textAlign: TextAlign.center,
        style: AppStyles.textNormal,
        textAlignVertical: TextAlignVertical.center,
        inputFormatters: <TextInputFormatter>[
          FilteringTextInputFormatter.allow(RegExp(r'(^\d+\.?\d?\d?)')),
        ],
        keyboardType: TextInputType.number,
        onChanged: (value) {
          if (_formKey.currentState.validate()) {
            _updateQuote();
          }
        },
        decoration: InputDecoration(
          errorStyle: TextStyle(height: 0),
          contentPadding: EdgeInsets.zero,
          filled: true,
          fillColor: AppColors.md_light_gray,
          floatingLabelBehavior: FloatingLabelBehavior.never,
          border: OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.placeHolder, width: 5.0),
            borderRadius: BorderRadius.circular(10),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.placeHolder, width: 1.0),
            borderRadius: BorderRadius.circular(10),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.mdAlert, width: 1.0),
            borderRadius: BorderRadius.circular(10),
          ),
          labelText: '',
          labelStyle: AppStyles.textNormal,
        ),
        validator: (value) {
          if (value.isEmpty) {
            return "";
          } else if (value.endsWith(".")) {
            return "";
          } else
            return null;
        },
      ),
    );
  }

  _updateQuote() async {
    UpdateQuoteResponse quote = await _redactionBloc.updateQuote(
        bloc.dernierDevis.quoteData.quote.id,
        double.parse(_tvaController.text),
        double.parse(_remiseController.text),
        double.parse(_franchiseController.text),
        double.parse(_accompteController.text));
    if ((quote.quoteData == null) || (quote.quoteData.quote == null)) {
      Fluttertoast.showToast(msg: "Erreur lors de la mise à jour");
      return false;
    } else {
      GetDevisResponse resp = await bloc
          .getDevisDetails(bloc.dernierDevis.quoteData.quote.id.toString());
      return true;
    }
  }
}
