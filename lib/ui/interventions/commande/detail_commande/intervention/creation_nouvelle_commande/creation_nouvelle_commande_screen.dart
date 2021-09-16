import 'dart:ui';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mdp/constants/app_colors.dart';
import 'package:mdp/constants/app_constants.dart';
import 'package:mdp/constants/routes.dart';
import 'package:mdp/constants/styles/app_styles.dart';
import 'package:mdp/models/responses/creation_nouvelle_commande_response.dart';
import 'package:mdp/models/responses/get_types_commandes_response.dart';
import 'package:mdp/utils/flushbar_utils.dart';
import 'package:mdp/widgets/gradients/md_gradient_light.dart';

import '../../../../interventions_bloc.dart';

class CreationNouvelleCommandeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _CreationNouvelleCommandeScreenState();
}

class _CreationNouvelleCommandeScreenState
    extends State<CreationNouvelleCommandeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final bloc = Modular.get<InterventionsBloc>();
  String _searchText = "";
  List<String> _listeCommandes = <String>[];
  bool _loading = false;
  GetTypesCommandesResponse response;

  @override
  void initState() {
    super.initState();
    _loadDatas();
  }

  _loadDatas() async {
    response = await bloc.getListesTypesCommandes();
    List<String> lista = response.orderCases.map((e) => e.name).toList();
    setState(() {
      _listeCommandes = lista;
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
    return Scaffold(
      key: _scaffoldKey,
      resizeToAvoidBottomInset: true,
      backgroundColor: AppColors.white,
      //drawer: DrawerWidget(),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
        child: SafeArea(
          child: Container(
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
                SizedBox(height: 30),
                Spacer(),
                _buildButton(),
                SizedBox(height: 50),
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
          Expanded(
            child: Text(
              "Création d'une nouvelle commande",
              style: AppStyles.header1White,
            ),
          ),
          SizedBox(width: 50),
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
            "Une autre commande ?",
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
        color: AppColors.white,
        borderRadius:
            BorderRadius.all(Radius.circular(AppConstants.default_Radius)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Sélectionnez le type de commande",
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
                  items: _listeCommandes,
                  label: "Type de commande",
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
                    "CONTINUER",
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
                  ? _goAddCommande()
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

  _validButton() {
    return _searchText.isNotEmpty;
  }

  _goAddCommande() async {
    setState(() {
      _loading = true;
    });
    CreationNouvelleCommandeResponse resp = await bloc.creationNouvelleCommande(
        bloc.interventionDetail.interventionDetail.uuid,
        response.orderCases
            .firstWhere((element) => element.name == _searchText)
            .uuid);
    if (resp.orderCreated) {
      Modular.to.pushNamedAndRemoveUntil(
          Routes.mesInterventions, ModalRoute.withName(Routes.home));
    } else {
      showErrorToast(context, "Une erreur est survenue");
    }
    setState(() {
      _loading = false;
    });
  }
}
