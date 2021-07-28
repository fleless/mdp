import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_absolute_path/flutter_absolute_path.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mdp/constants/app_colors.dart';
import 'package:mdp/constants/app_constants.dart';
import 'package:mdp/constants/routes.dart';
import 'package:mdp/constants/styles/app_styles.dart';
import 'package:mdp/ui/interventions/commande/detail_commande/intervention/steps/readction_devis/redaction_devis_bloc.dart';
import 'package:mdp/ui/interventions/commande/detail_commande/intervention/steps/readction_devis/screens/fournitures/fournitures_dialogs.dart';
import 'package:mdp/widgets/gradients/md_gradient_light.dart';
import 'package:multi_image_picker/multi_image_picker.dart';

import '../../../../../../interventions_bloc.dart';

class CreationDesignationScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _CreationDesignationScreenState();
}

class _CreationDesignationScreenState extends State<CreationDesignationScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final bloc = Modular.get<InterventionsBloc>();
  final redaction_devis_bloc = Modular.get<RedactionDevisBloc>();
  bool opened = false;
  GlobalKey<FormState> formKey = new GlobalKey();
  TextEditingController _designationTitleController = TextEditingController();
  List<Asset> resultList;
  List<Asset> images = <Asset>[];
  List<String> imagesPath = <String>[];

  //this boolean used to make dotted border of pictures in red color whent it's empty
  bool _pictureError = false;

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
        _buildBloc(),
        Padding(
          padding: EdgeInsets.all(AppConstants.default_padding),
          child: _buildBody(),
        ),
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

  Widget _buildBloc() {
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
            "Création d'une désignation",
            style: AppStyles.largeTextBoldDefaultBlack,
          ),
          SizedBox(height: 15),
          Form(
            key: formKey,
            child: TypeAheadField(
              textFieldConfiguration: TextFieldConfiguration(
                  controller: _designationTitleController,
                  cursorColor: AppColors.md_dark_blue,
                  autofocus: false,
                  style: AppStyles.textNormal,
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: AppColors.white,
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: AppColors.md_dark_blue),
                      ),
                      border: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: AppColors.md_dark_blue)),
                      focusColor: AppColors.md_dark_blue,
                      labelText: 'Nom de la désignation',
                      labelStyle: AppStyles.bodyHint)),
              keepSuggestionsOnLoading: true,
              suggestionsCallback: (pattern) => bloc.liste_names
                  .where((element) => element.designation
                      .toUpperCase()
                      .contains(pattern.toUpperCase()))
                  .toList(),
              noItemsFoundBuilder: (value) {
                var localizedMessage = "Aucun résultat trouvé ";
                return Container(
                    height: 40,
                    child: Center(
                      child: Text(localizedMessage),
                    ));
              },
              itemBuilder: (context, suggestion) {
                return Container(
                  padding: EdgeInsets.all(10),
                  child: Text(suggestion.designation,
                      style: AppStyles.textNormal,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 3),
                );
              },
              errorBuilder: (context, value) {},
              onSuggestionSelected: (suggestion) {
                this._designationTitleController.text = suggestion.designation;
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBody() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          textAlign: TextAlign.left,
          maxLines: 10,
          overflow: TextOverflow.clip,
          text: TextSpan(
            children: [
              TextSpan(text: "Photos ", style: AppStyles.uniformRoundedHeader),
              WidgetSpan(
                alignment: PlaceholderAlignment.middle,
                child: Icon(
                  Icons.info,
                  color: AppColors.md_dark_blue,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 3),
        Text("Max. 9 photos, téléchargeables jusqu’à 3 par 3",
            style: AppStyles.textNormalPlaceholder,
            overflow: TextOverflow.ellipsis,
            maxLines: 3),
        SizedBox(height: 10),
        _buildPhotos(),
        SizedBox(height: 40),
        _builFirstBloc(),
        SizedBox(height: 40),
        _buildSecondBloc(),
        SizedBox(height: 70),
        _buildValidButton(),
        SizedBox(height: 40),
      ],
    );
  }

  Widget _buildPhotos() {
    return Container(
      height: 250,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: images.length == 9 ? images.length : images.length + 1,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () async {
                String path = await FlutterAbsolutePath.getAbsolutePath(
                    images[index].identifier);
                ((images.length != 9) && (index == images.length))
                    ? null
                    : Modular.to.pushNamed(Routes.photoView,
                        arguments: {'image': images[index], 'path': path});
              },
              child: ((images.length != 9) && (index == images.length))
                  ? GestureDetector(
                      onTap: () {
                        loadAssets();
                      },
                      child: DottedBorder(
                        borderType: BorderType.RRect,
                        color: AppColors.md_tertiary,
                        radius: Radius.circular(12),
                        padding: EdgeInsets.all(6),
                        child: ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(12)),
                          child: Container(
                              width: 180,
                              padding: EdgeInsets.all(40),
                              alignment: Alignment.center,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    Icons.photo_camera,
                                    color: AppColors.md_tertiary,
                                  ),
                                  SizedBox(height: 12),
                                  Text(
                                    "PRENDRE UNE PHOTO",
                                    style: AppStyles.buttonTextTertiary,
                                    maxLines: 4,
                                    textAlign: TextAlign.center,
                                    overflow: TextOverflow.ellipsis,
                                  )
                                ],
                              )),
                        ),
                      ),
                    )
                  : Card(
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      elevation: 4,
                      child: Container(
                        width: 180,
                        child: AssetThumb(
                          asset: images[index],
                          width: 300,
                          height: 300,
                        ),
                      ),
                    ),
            );
          }),
    );
  }

  Widget _builFirstBloc() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Main d'oeuvre et déplacement",
            style: AppStyles.uniformRoundedHeader,
            overflow: TextOverflow.ellipsis,
            maxLines: 2),
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
                        "AJOUTER",
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
          onPressed: () {},
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
    );
  }

  Widget _buildSecondBloc() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          textAlign: TextAlign.left,
          maxLines: 10,
          overflow: TextOverflow.clip,
          text: TextSpan(
            children: [
              TextSpan(
                  text: "Fournitures ", style: AppStyles.uniformRoundedHeader),
              WidgetSpan(
                alignment: PlaceholderAlignment.middle,
                child: Icon(
                  Icons.info,
                  color: AppColors.md_dark_blue,
                ),
              ),
            ],
          ),
        ),
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
                        "AJOUTER",
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
            showDialog(
                context: context,
                builder: (context) {
                  return StatefulBuilder(
                      builder: (BuildContext context, StateSetter setState) {
                    return Dialog(
                      backgroundColor: AppColors.md_light_gray,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: FournituresDialogWidget(),
                    );
                  });
                });
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
    );
  }

  Widget _buildValidButton() {
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
            "VALIDER LA DESIGNATION",
            style: AppStyles.buttonInactiveText,
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

  Future<void> loadAssets() async {
    try {
      resultList = await MultiImagePicker.pickImages(
        maxImages: images.length == 8 ? 1 : (images.length == 7 ? 2 : 3),
        enableCamera: true,
        selectedAssets: images,
        materialOptions: MaterialOptions(
            actionBarTitle: "Galerie",
            actionBarColor: "",
            lightStatusBar: true),
      );
    } on Exception catch (e) {}
    setState(() {
      resultList == null ? null : images = resultList;
    });
  }
}
