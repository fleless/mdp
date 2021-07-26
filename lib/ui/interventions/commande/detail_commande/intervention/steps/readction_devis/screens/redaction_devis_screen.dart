import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mdp/constants/app_colors.dart';
import 'package:mdp/constants/app_constants.dart';
import 'package:mdp/constants/routes.dart';
import 'package:mdp/constants/styles/app_styles.dart';
import 'package:mdp/widgets/gradients/md_gradient_light.dart';

import '../../../../../../interventions_bloc.dart';

class RedactionDevisScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _RedactionDevisScreenState();
}

class _RedactionDevisScreenState extends State<RedactionDevisScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final bloc = Modular.get<InterventionsBloc>();
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
    return Scaffold(
      key: _scaffoldKey,
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.white,
      //drawer: DrawerWidget(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            width: double.infinity,
            child: _buildContent(),
          ),
        ), //LoadingIndicator(loading: _bloc.loading),
        //NetworkErrorMessages(error: _bloc.error),
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
            Modular.to.pushNamed(Routes.creationDesignation);
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

  Widget _buildRecap() {
    return Container(
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
                  "Fourchette tarifaire 600€ - 1200€",
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
                      TextSpan(text: "00€", style: AppStyles.bodyBold),
                    ],
                  ),
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    Text(
                      "TVA",
                      style: AppStyles.bodyDefaultBlack,
                    ),
                    SizedBox(width: 10),
                    _customContainer("10%"),
                    SizedBox(width: 10),
                    Text(": 00€", style: AppStyles.bodyBold),
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
                      TextSpan(text: "00%/€", style: AppStyles.bodyBold),
                    ],
                  ),
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    Text(
                      "Remise :",
                      style: AppStyles.bodyDefaultBlack,
                    ),
                    SizedBox(width: 10),
                    _customContainer("00%/€"),
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
                      TextSpan(text: "00€", style: AppStyles.bodyBold),
                    ],
                  ),
                ),
                SizedBox(height: 10),
                Divider(color: AppColors.placeHolder),
                SizedBox(height: 10),
                Row(
                  children: [
                    Text(
                      "Franchise :",
                      style: AppStyles.bodyDefaultBlack,
                    ),
                    SizedBox(width: 10),
                    _customContainer("00€ HT"),
                    SizedBox(width: 10),
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    Text(
                      "Accompte à verser :",
                      style: AppStyles.bodyDefaultBlack,
                    ),
                    SizedBox(width: 10),
                    _customContainer("00€ HT"),
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
              color: AppColors.placeHolder,
            ),
            width: double.infinity,
            padding: EdgeInsets.all(20),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  Icons.euro_outlined,
                  color: AppColors.white,
                  size: 20,
                ),
                SizedBox(width: 10),
                Text(
                  "Montant TTC : 00€",
                  style: AppStyles.header1WhiteBold,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSignButton() {
    return ElevatedButton(
      child: Ink(
        decoration: BoxDecoration(
          color: AppColors.inactive,
          borderRadius: BorderRadius.all(
            Radius.circular(12),
          ),
          border: Border.all(color: AppColors.inactive),
        ),
        child: Container(
          alignment: Alignment.center,
          width: double.infinity,
          height: 55,
          child: Text(
            "SIGNER ET GENERER LE DEVIS",
            style: AppStyles.buttonInactiveText,
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
          child: Text(
            "ENREGISTRER ET CONTINUER PLUS TARD",
            style: AppStyles.buttonTextDarkBlue,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
      onPressed: () {},
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

  Widget _customContainer(String item) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(15)),
          color: AppColors.md_light_gray,
          border: Border.all(color: AppColors.placeHolder)),
      child: Center(
        child: Text(
          item,
          style: AppStyles.bodyBold,
        ),
      ),
    );
  }
}
