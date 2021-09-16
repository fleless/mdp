import 'dart:ui';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mdp/constants/app_colors.dart';
import 'package:mdp/constants/app_constants.dart';
import 'package:mdp/constants/styles/app_styles.dart';
import 'package:mdp/widgets/gradients/md_gradient_light.dart';

import '../../../../../../interventions_bloc.dart';
import '../finalisation_intervention_bloc.dart';
import 'other_widgets/show_cheque_widget.dart';

class PaymentOtherOptionsScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _PaymentOtherOptionsScreenState();
}

class _PaymentOtherOptionsScreenState extends State<PaymentOtherOptionsScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final bloc = Modular.get<InterventionsBloc>();
  final _finalisationInterventionBloc =
      Modular.get<FinalisationInterventionBloc>();
  String _searchText = "";
  List<String> listePaiements = [
    "Chèque",
    "Virement",
    "TPE",
    "Aucun paiement possible",
    "Donner la main au service client"
  ];

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
    return Scaffold(
      key: _scaffoldKey,
      resizeToAvoidBottomInset: true,
      backgroundColor: AppColors.white,
      body: GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  decoration: BoxDecoration(gradient: MdGradientLightt()),
                  child: _buildHeader(),
                ),
                Container(
                  decoration: BoxDecoration(gradient: MdGradientLightt()),
                  child: _buildTitle(),
                ),
                Container(
                  padding: EdgeInsets.all(AppConstants.default_padding),
                  color: AppColors.white,
                  alignment: Alignment.center,
                  child: _buildBloc(),
                ),
                SizedBox(height: 5),
                _searchText == listePaiements[0]
                    ? ShowChequePaymentWidget()
                    : Container(),
                SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
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
                    text: "Finalisation de l'Intervention \n",
                    style: AppStyles.header1White),
                TextSpan(
                    text: " n°" +
                        bloc.interventionDetail.interventionDetail.code
                            .toString(),
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

  Widget _buildTitle() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
          horizontal: AppConstants.default_padding,
          vertical: AppConstants.default_padding * 2),
      decoration: BoxDecoration(color: AppColors.md_light_gray),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () {
              Modular.to.pop();
            },
            child: RichText(
              textAlign: TextAlign.left,
              maxLines: 10,
              overflow: TextOverflow.clip,
              text: TextSpan(
                children: [
                  WidgetSpan(
                      alignment: PlaceholderAlignment.middle,
                      child: FaIcon(
                        FontAwesomeIcons.chevronLeft,
                        color: AppColors.md_dark_blue,
                        size: 14,
                      )),
                  TextSpan(text: "   Retour", style: AppStyles.textNormalBold),
                ],
              ),
            ),
          ),
          SizedBox(height: 15),
          Text(
            "Paiement",
            style: AppStyles.largeTextBoldDefaultBlack,
          ),
        ],
      ),
    );
  }

  Widget _buildBloc() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 30),
      alignment: Alignment.center,
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.md_light_gray,
        borderRadius:
            BorderRadius.all(Radius.circular(AppConstants.default_Radius)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Autre moyens de paiement disponible",
            style: AppStyles.bodyBoldMdDarkBlue,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(height: 18),
          Text(
            "Merci de sélectionner un autre moyen de paiement : ",
            style: AppStyles.bodyDefaultBlack,
            maxLines: 5,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(height: 18),
          Container(
            height: 45,
            child: Theme(
              // Create a unique theme with "ThemeData"
              data: ThemeData(
                primarySwatch: AppColors.defaultColorMaterial,
              ),
              child: DropdownSearch<String>(
                  popupBackgroundColor: AppColors.white,
                  searchBoxDecoration: null,
                  dropdownSearchDecoration: null,
                  mode: Mode.MENU,
                  showSelectedItem: true,
                  popupSafeArea: PopupSafeArea(top: false),
                  items: listePaiements,
                  label: "Type de paiement",
                  onChanged: (value) {
                    setState(() {
                      _searchText = value;
                    });
                  },
                  selectedItem: ""),
            ),
          ),
        ],
      ),
    );
  }
}
