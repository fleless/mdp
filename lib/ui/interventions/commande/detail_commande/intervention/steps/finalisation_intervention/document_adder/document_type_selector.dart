import 'dart:ui';

import 'package:dotted_border/dotted_border.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mdp/constants/app_colors.dart';
import 'package:mdp/constants/app_constants.dart';
import 'package:mdp/constants/styles/app_styles.dart';
import 'package:mdp/models/responses/get_types_documents_response.dart';
import 'package:mdp/ui/interventions/commande/detail_commande/intervention/steps/finalisation_intervention/document_adder/add_type_dialog.dart';
import 'package:mdp/ui/interventions/commande/detail_commande/intervention/steps/finalisation_intervention/document_adder/show_document_uploader_widget.dart';
import 'package:mdp/ui/interventions/commande/detail_commande/intervention/steps/finalisation_intervention/document_adder/show_pv_finTravaux.dart';
import 'package:mdp/widgets/gradients/md_gradient_light.dart';

import '../../../../../../interventions_bloc.dart';
import '../finalisation_intervention_bloc.dart';

class DocumentTypeSelectorScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _DocumentTypeSelectorScreenState();
}

class _DocumentTypeSelectorScreenState
    extends State<DocumentTypeSelectorScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final bloc = Modular.get<InterventionsBloc>();
  final _finalisationInterventionBloc =
      Modular.get<FinalisationInterventionBloc>();
  String _searchText = "";

  // if 0 don't show any interface; 1 show for upload PV fin de travaux; 2 show for other docs
  int showSelectedType = 0;

  @override
  void initState() {
    super.initState();
    _finalisationInterventionBloc.docChangesNotifier.listen((value) {
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
    return Scaffold(
      key: _scaffoldKey,
      resizeToAvoidBottomInset: true,
      backgroundColor: AppColors.white,
      //drawer: DrawerWidget(),
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
                showSelectedType == 0
                    ? Container()
                    : showSelectedType == 1
                        ? ShowPvFinTravauxWidget()
                        : ShowDocumentUploaderWidget(_searchText),
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
            "Ajouter un document",
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
            "Ajout d’un document",
            style: AppStyles.bodyBoldMdDarkBlue,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(height: 18),
          Text(
            "Veuillez ajouter les documents fin d’intervention",
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
                  popupItemBuilder: _customDropDown,
                  dropdownSearchDecoration: null,
                  mode: Mode.MENU,
                  showSelectedItem: true,
                  popupSafeArea: PopupSafeArea(top: false),
                  items: _filterDocumentTypes(),
                  label: "Type de documents",
                  onChanged: (value) {
                    _searchText = value;
                    if (value == " ") {
                      setState(() {
                        showSelectedType = 0;
                      });
                      showDialog(
                          context: context,
                          builder: (context) {
                            return StatefulBuilder(builder:
                                (BuildContext context, StateSetter setState) {
                              return Dialog(
                                backgroundColor: AppColors.md_light_gray,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                                child: AddTypeDialog(),
                              );
                            });
                          });
                    } else if (value == "PV fin de travaux") {
                      setState(() {
                        showSelectedType = 0;
                        showSelectedType = 1;
                      });
                    } else {
                      setState(() {
                        showSelectedType = 0;
                        showSelectedType = 2;
                      });
                    }
                  },
                  selectedItem: ""),
            ),
          ),
        ],
      ),
    );
  }

  List<String> _filterDocumentTypes() {
    List<String> lista = bloc.liste_documents
        .map((e) => e.name)
        .where((element) => ((element != "Photo client") &&
            (element != "Photo après") &&
            (element != "Photo avant")))
        .toList();
    //remove redundant types (types that already exist in intervention)
    lista.removeWhere((element) =>
        bloc.interventionDetail.interventionDetail.documents
            .where((el) => el.documentType == element)
            .toList()
            .length >
        0);
    // We add a space to show the button of adding a new type in the dropDown Search PopUp
    lista.add(" ");
    return lista;
  }

  Widget _customDropDown(BuildContext context, String item, bool ddd) {
    // we check the space added to show the button
    if (item == " ") {
      return Ink(
        decoration: BoxDecoration(
          color: AppColors.white,
        ),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          alignment: Alignment.center,
          width: double.infinity,
          child: DottedBorder(
            borderType: BorderType.RRect,
            radius: Radius.circular(12),
            padding: EdgeInsets.symmetric(vertical: 6, horizontal: 20),
            color: AppColors.md_tertiary,
            child: Row(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Icon(
                    Icons.add_circle_outline_outlined,
                    color: AppColors.md_tertiary,
                  ),
                ),
                Expanded(
                  child: Center(
                    child: Text(
                      "AJOUTER UN AUTRE ÉLÉMENT",
                      style: AppStyles.buttonTextTertiary,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      child: Text(
        item,
        style: AppStyles.bodyDefaultBlack,
      ),
    );
  }
}
