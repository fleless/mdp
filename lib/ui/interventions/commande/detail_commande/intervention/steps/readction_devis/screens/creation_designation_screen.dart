import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_absolute_path/flutter_absolute_path.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mdp/constants/app_colors.dart';
import 'package:mdp/constants/app_constants.dart';
import 'package:mdp/constants/app_images.dart';
import 'package:mdp/constants/routes.dart';
import 'package:mdp/constants/styles/app_styles.dart';
import 'package:mdp/models/requests/ajout_designation_request.dart';
import 'package:mdp/models/responses/get_designations_name.dart';
import 'package:mdp/models/responses/get_devis_response.dart'
    as getDesignationsClass;
import 'package:mdp/models/responses/upload_document_response.dart';
import 'package:mdp/models/workload_model.dart';
import 'package:mdp/ui/interventions/commande/detail_commande/intervention/steps/readction_devis/redaction_devis_bloc.dart';
import 'package:mdp/ui/interventions/commande/detail_commande/intervention/steps/readction_devis/screens/fournitures/add_update_fourniture.dart';
import 'package:mdp/ui/interventions/commande/detail_commande/intervention/steps/readction_devis/screens/fournitures/fournitures_dialogs.dart';
import 'package:mdp/ui/interventions/commande/detail_commande/intervention/steps/readction_devis/screens/mainDepacement/add_update_mainDeplacement.dart';
import 'package:mdp/ui/interventions/commande/detail_commande/intervention/steps/readction_devis/screens/mainDepacement/show_mainDeplacement_dialog.dart';
import 'package:mdp/utils/image_compresser.dart';
import 'package:mdp/widgets/gradients/md_gradient_light.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:path_provider/path_provider.dart';

import '../../../../../../interventions_bloc.dart';
import 'package:collection/collection.dart';

class CreationDesignationScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _CreationDesignationScreenState();

  getDesignationsClass.Designations designationToUpdate =
      getDesignationsClass.Designations();
  bool isAdd;

  CreationDesignationScreen(this.designationToUpdate, this.isAdd);
}

class _CreationDesignationScreenState extends State<CreationDesignationScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final bloc = Modular.get<InterventionsBloc>();
  final image_compressor = Modular.get<ImageCompressor>();
  final redaction_devis_bloc = Modular.get<RedactionDevisBloc>();
  bool opened = false;
  GlobalKey<FormState> formKey = new GlobalKey();
  TextEditingController _designationTitleController = TextEditingController();
  List<Asset> resultList;
  List<String> imagesAlreadyUploaded = <String>[];
  List<Asset> images = <Asset>[];
  List<String> imagesPath = <String>[];
  List<Asset> lastSelectedAssets = <Asset>[];

  //this boolean used to make dotted border of pictures in red color whent it's empty
  bool _pictureError = false;

  //check if we are saving and avoiding double click on button
  bool _savingLoading = false;

  @override
  void initState() {
    redaction_devis_bloc.liste_mainsDeplacement.clear();
    redaction_devis_bloc.liste_materiel.clear();
    if (!widget.isAdd) _initDatas();
    super.initState();
    redaction_devis_bloc.notifyChanges.listen((value) {
      if (mounted) setState(() {});
    });
  }

  // fill the workcharges and photos when it's update
  _initDatas() {
    _designationTitleController.text =
        widget.designationToUpdate.quoteReference.designation;
    widget.designationToUpdate.details.forEach((element) {
      if ((element.workchangeId == bloc.liste_mainDeplacement[0].id) ||
          (element.workchangeId == bloc.liste_mainDeplacement[1].id)) {
        redaction_devis_bloc.liste_mainsDeplacement.add(WorkLoadModel(
            element.workchangeId,
            element.name,
            element.quantity.toString(),
            element.priceHt.toString(),
            element.comment));
      } else {
        redaction_devis_bloc.liste_materiel.add(WorkLoadModel(
            element.workchangeId,
            element.name,
            element.quantity.toString(),
            element.priceHt.toString(),
            element.comment));
      }
    });
    imagesAlreadyUploaded.clear();
    if (widget.designationToUpdate.photos != null)
      widget.designationToUpdate.photos.forEach((element) {
        imagesAlreadyUploaded.add(element.url);
      });
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
            widget.isAdd
                ? "Création d'une désignation"
                : "Modification d'une désignation",
            style: AppStyles.largeTextBoldDefaultBlack,
          ),
          SizedBox(height: 15),
          Form(
            key: formKey,
            child: TypeAheadField(
              textFieldConfiguration: TextFieldConfiguration(
                  enabled: widget.isAdd ? true : false,
                  controller: _designationTitleController,
                  cursorColor: AppColors.md_dark_blue,
                  onChanged: (value) {
                    setState(() {});
                  },
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
              suggestionsCallback: (pattern) => _listToShow(pattern),
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
                setState(() {
                  this._designationTitleController.text =
                      suggestion.designation;
                });
              },
            ),
          ),
        ],
      ),
    );
  }

  _listToShow(String pattern) {
    List<ListQuoteReference> resp = bloc.liste_names
        .where((element) =>
            element.designation.toUpperCase().contains(pattern.toUpperCase()))
        .toList();

    if (bloc.dernierDevis != null)
      resp.removeWhere((element) => bloc.dernierDevis.quoteData.designations
          .where((el) => el.quoteReference.id == element.id)
          .isNotEmpty);
    return resp;
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
          itemCount: (images.length + imagesAlreadyUploaded.length) == 9
              ? images.length + imagesAlreadyUploaded.length
              : images.length + imagesAlreadyUploaded.length + 1,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () async {
                if (index < imagesAlreadyUploaded.length) {
                  Modular.to.pushNamed(Routes.photoView, arguments: {
                    'image': imagesAlreadyUploaded[index],
                    'path': ""
                  });
                } else {
                  String path = await FlutterAbsolutePath.getAbsolutePath(
                      images[index - imagesAlreadyUploaded.length].identifier);
                  ((images.length + imagesAlreadyUploaded.length != 9) &&
                          (index ==
                              images.length + imagesAlreadyUploaded.length))
                      ? null
                      : Modular.to.pushNamed(Routes.photoView, arguments: {
                          'image': images[index - imagesAlreadyUploaded.length],
                          'path': path
                        });
                }
              },
              child: (index < imagesAlreadyUploaded.length)
                  ? Card(
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      elevation: 4,
                      child: Container(
                        width: 180,
                        child: Image.network(imagesAlreadyUploaded[index],
                            fit: BoxFit.cover),
                      ),
                    )
                  : (((images.length + imagesAlreadyUploaded.length != 9) &&
                          (index ==
                              images.length + imagesAlreadyUploaded.length))
                      ? GestureDetector(
                          onTap: () {
                            setState(() {
                              _pictureError = false;
                            });
                            loadAssets();
                          },
                          child: DottedBorder(
                            borderType: BorderType.RRect,
                            color: _pictureError
                                ? AppColors.mdAlert
                                : AppColors.md_tertiary,
                            radius: Radius.circular(12),
                            padding: EdgeInsets.all(6),
                            child: ClipRRect(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12)),
                              child: Container(
                                  width: 180,
                                  padding: EdgeInsets.all(40),
                                  alignment: Alignment.center,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(
                                        Icons.photo_camera,
                                        color: _pictureError
                                            ? AppColors.mdAlert
                                            : AppColors.md_tertiary,
                                      ),
                                      SizedBox(height: 12),
                                      Text(
                                        "PRENDRE UNE PHOTO",
                                        style: _pictureError
                                            ? AppStyles.buttonTextAlert
                                            : AppStyles.buttonTextTertiary,
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
                              asset:
                                  images[index - imagesAlreadyUploaded.length],
                              width: 300,
                              height: 300,
                            ),
                          ),
                        )),
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
        redaction_devis_bloc.liste_mainsDeplacement.length == 0
            ? SizedBox.shrink()
            : _buildWorkLoads(false),
        redaction_devis_bloc.liste_mainsDeplacement.length == 2
            ? SizedBox.shrink()
            : SizedBox(height: 20),
        redaction_devis_bloc.liste_mainsDeplacement.length == 2
            ? SizedBox.shrink()
            : ElevatedButton(
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
                      padding:
                          EdgeInsets.symmetric(vertical: 6, horizontal: 20),
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
                        return StatefulBuilder(builder:
                            (BuildContext context, StateSetter setState) {
                          return Dialog(
                            backgroundColor: AppColors.md_light_gray,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            child: ShowMainDeplacementDialogWidget(),
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
                    textStyle:
                        TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
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
        redaction_devis_bloc.liste_materiel.length == 0
            ? SizedBox.shrink()
            : _buildWorkLoads(true),
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

  Widget _buildWorkLoads(bool isMaterial) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (var i in (isMaterial
            ? redaction_devis_bloc.liste_materiel
            : redaction_devis_bloc.liste_mainsDeplacement))
          isMaterial
              ? _buildWorkLoadsMateriel(i)
              : _buildWorkLoadsMainDeplacement(i),
      ],
    );
  }

  Widget _buildWorkLoadsMateriel(WorkLoadModel i) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 20),
        Container(
          decoration: BoxDecoration(
            color: AppColors.md_light_gray,
            borderRadius: BorderRadius.all(Radius.circular(5)),
          ),
          padding: EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(i.name,
                        style: AppStyles.header2DarkBlue,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 5),
                  ),
                  SizedBox(width: 20),
                  Text(
                      i.quantity +
                          ((bloc.liste_materials.where((element) => element.id == i.workchange_id)
        .toList().isEmpty ) ? "" :
                      bloc.liste_materials
                          .where((element) => element.id == i.workchange_id)
                          .toList()[0].unitName),
                      style: AppStyles.textNormal,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 5),
                ],
              ),
              SizedBox(height: 15),
              Text(
                  ((i.comment.trim() == "") || (i.comment == null))
                      ? "Pas de commentaire"
                      : i.comment,
                  style: AppStyles.textNormal,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 5),
              Row(
                children: [
                  Expanded(
                      child: Text(i.price_ht + "€ HT",
                          style: AppStyles.bodyBold,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 5)),
                  IconButton(
                    onPressed: () {
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
                                child: AddUpdateFournituresDialog(
                                    bloc.liste_materials
                                        .where((element) =>
                                            element.id == i.workchange_id)
                                        .first,
                                    false,
                                    i),
                              );
                            });
                          });
                    },
                    splashColor: AppColors.white,
                    icon: Icon(
                      Icons.edit,
                      color: AppColors.md_dark_blue,
                      size: 24,
                    ),
                  ),
                  IconButton(
                    splashColor: AppColors.white,
                    onPressed: () {
                      redaction_devis_bloc.liste_materiel.removeWhere(
                          (element) =>
                              ((element.workchange_id == i.workchange_id)));
                      redaction_devis_bloc.notifyChanges.add(0);
                    },
                    icon: Icon(
                      Icons.close,
                      color: AppColors.md_dark_blue,
                      size: 24,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildWorkLoadsMainDeplacement(WorkLoadModel i) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 20),
        Container(
          decoration: BoxDecoration(
            color: AppColors.md_light_gray,
            borderRadius: BorderRadius.all(Radius.circular(5)),
          ),
          padding: EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(i.name,
                        style: AppStyles.header2DarkBlue,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 5),
                  ),
                  SizedBox(width: 20),
                  Text(
                      i.quantity +
                          bloc.liste_mainDeplacement
                              .where((element) => element.id == i.workchange_id)
                              .toList()[0]
                              .unitName,
                      style: AppStyles.textNormal,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 5),
                ],
              ),
              SizedBox(height: 15),
              Text(
                  ((i.comment.trim() == "") || (i.comment == null))
                      ? "Pas de commentaire"
                      : i.comment,
                  style: AppStyles.textNormal,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 5),
              Row(
                children: [
                  Expanded(
                      child: Text(i.price_ht + "€ HT",
                          style: AppStyles.bodyBold,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 5)),
                  IconButton(
                    onPressed: () {
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
                                child: AddUpdateMainDeplacementDialog(
                                    bloc.liste_mainDeplacement
                                        .where((element) =>
                                            element.id == i.workchange_id)
                                        .first,
                                    false,
                                    i),
                              );
                            });
                          });
                    },
                    splashColor: AppColors.white,
                    icon: Icon(
                      Icons.edit,
                      color: AppColors.md_dark_blue,
                      size: 24,
                    ),
                  ),
                  IconButton(
                    splashColor: AppColors.white,
                    onPressed: () {
                      redaction_devis_bloc.liste_mainsDeplacement.removeWhere(
                          (element) =>
                              ((element.workchange_id == i.workchange_id) &&
                                  (element.name == i.name)));
                      redaction_devis_bloc.notifyChanges.add(0);
                    },
                    icon: Icon(
                      Icons.close,
                      color: AppColors.md_dark_blue,
                      size: 24,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ],
    );
  }

  bool _notValidate() {
    return ((_designationTitleController.text.trim() == "") ||
        (_designationTitleController.text == null) ||
        (redaction_devis_bloc.liste_mainsDeplacement.length == 0) ||
        (redaction_devis_bloc.liste_materiel.length == 0));
  }

  Widget _buildValidButton() {
    return ElevatedButton(
      child: Ink(
        decoration: BoxDecoration(
          color: _notValidate() ? AppColors.inactive : AppColors.md_dark_blue,
          borderRadius: BorderRadius.all(
            Radius.circular(12),
          ),
        ),
        child: Container(
          alignment: Alignment.center,
          width: double.infinity,
          height: 55,
          child: _savingLoading
              ? Center(
                  child: CircularProgressIndicator(
                    color: AppColors.white,
                  ),
                )
              : Text(
                  widget.isAdd
                      ? "VALIDER LA DESIGNATION"
                      : "MODIFIER LA DÉSIGNATION",
                  style: _notValidate()
                      ? AppStyles.buttonInactiveText
                      : AppStyles.buttonTextWhite,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
        ),
      ),
      onPressed: () {
        _notValidate()
            ? null
            // ignore: unnecessary_statements
            : (images.length + imagesAlreadyUploaded.length == 0
                ? _validButtonClickError()
                : (_savingLoading ? null : _saveDesignation()));
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

  _saveDesignation() async {
    setState(() {
      _savingLoading = true;
    });
    AddDesignationRequest newDesignation = AddDesignationRequest(
        quote: Quote(),
        quoteReference: QuoteReference(),
        photos: <Photos>[],
        lines: <Lines>[]);
    newDesignation.quote = Quote(
        order: bloc.interventionDetail.interventionDetail.id,
        id: bloc.dernierDevis == null
            ? null
            : bloc.dernierDevis.quoteData.quote.id);

    ListQuoteReference findDesignation = bloc.liste_names.firstWhereOrNull(
        (element) =>
            element.designation.toUpperCase() ==
            _designationTitleController.text.toUpperCase());
    newDesignation.quoteReference.id =
        (findDesignation == null ? null : findDesignation.id);
    newDesignation.quoteReference.name = _designationTitleController.text;
    newDesignation.name = _designationTitleController.text;
    List<WorkLoadModel> lista = redaction_devis_bloc.liste_mainsDeplacement +
        redaction_devis_bloc.liste_materiel;
    lista.asMap().forEach((index, value) {
      newDesignation.lines.add(Lines(
          workchangeId: value.workchange_id,
          name: value.name,
          quantity: int.parse(value.quantity),
          priceHt: num.parse(value.price_ht),
          sort: index + 1,
          comment: value.comment));
    });
    if ((!widget.isAdd) && (images.length == 0)) {
      bool response =
          await redaction_devis_bloc.updateDesignation(newDesignation);
      if (response) {
        Modular.to.pop();
        bloc.getInterventionDetail(
            bloc.interventionDetail.interventionDetail.uuid);
        _savingLoading = false;
      } else {
        setState(() {
          _savingLoading = false;
        });
        Fluttertoast.showToast(msg: "Erreur lors de la modification");
      }
    } else {
      //for saving Designation we start by uploading photos and getting their uuid in aws
      for (var element in images) {
        final dir = await getTemporaryDirectory();
        var path2 =
            await FlutterAbsolutePath.getAbsolutePath(element.identifier);
        var file = await image_compressor.compressAndGetFile(
            File(path2), dir.absolute.path + "/temp.jpg");
        var base64Image = base64Encode(file.readAsBytesSync());
        UploadDocumentResponse resp = await redaction_devis_bloc.uploadPhotos(
            bloc.dernierDevis == null
                ? null
                : bloc.dernierDevis.quoteData.quote.id.toString(),
            base64Image);
        if ((resp.documentUploaded != null) && (resp.documentUploaded)) {
          if (resp.document.uuid != null) {
            newDesignation.photos.add(Photos(photoId: resp.document.uuid));
            //check if the last photo uploaded call api save the desigantion
            if (newDesignation.photos.length == images.length) {
              bool response;
              if (widget.isAdd)
                response =
                    await redaction_devis_bloc.addDesignation(newDesignation);
              if (!widget.isAdd)
                response = await redaction_devis_bloc
                    .updateDesignation(newDesignation);
              if (response) {
                Modular.to.pop();
                bloc.getInterventionDetail(
                    bloc.interventionDetail.interventionDetail.uuid);
                _savingLoading = false;
              } else {
                setState(() {
                  _savingLoading = false;
                });
                Fluttertoast.showToast(msg: "Erreur lors de l'ajout");
              }
            }
          }
        } else {
          Fluttertoast.showToast(msg: "un problème est survenu");
          setState(() {
            _savingLoading = false;
          });
        }
      }
    }
  }

  _validButtonClickError() {
    setState(() {
      _pictureError = true;
    });
    Timer timer = Timer(Duration(milliseconds: AppConstants.TIMER_DIALOG), () {
      Modular.to.pop();
    });
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
              child: _showProvideImagePopUp(),
            );
          });
        }).then((value) {
      // dispose the timer in case something else has triggered the dismiss.
      timer?.cancel();
      timer = null;
    });
  }

  Future<void> loadAssets() async {
    setState(() {
      lastSelectedAssets.clear();
      if (resultList != null) resultList.clear();
    });
    try {
      resultList = await MultiImagePicker.pickImages(
        maxImages: images.length == 8 ? 1 : (images.length == 7 ? 2 : 3),
        enableCamera: true,
        selectedAssets: lastSelectedAssets,
        materialOptions: MaterialOptions(
            actionBarTitle: "Galerie",
            actionBarColor: "",
            lightStatusBar: true),
      );
    } on Exception catch (e) {}
    setState(() {
      resultList == null ? null : images += resultList;
    });
  }

  Widget _showProvideImagePopUp() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
              "N'oubliez pas d'ajouter les photos avant de valider la désignation",
              style: AppStyles.header3,
              textAlign: TextAlign.center,
              maxLines: 10,
              overflow: TextOverflow.ellipsis),
          SvgPicture.asset(AppImages.warning),
          ElevatedButton(
            child: Ink(
              decoration: BoxDecoration(
                color: AppColors.white,
                border: Border.all(color: AppColors.mdAlert, width: 1.5),
                borderRadius: BorderRadius.all(
                  Radius.circular(12),
                ),
              ),
              child: Container(
                alignment: Alignment.center,
                width: double.infinity,
                height: 50,
                child: Text(
                  "J'AI COMPRIS",
                  style: AppStyles.buttonTextAlert,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
            onPressed: () {
              Modular.to.pop();
            },
            style: ElevatedButton.styleFrom(
                elevation: 5,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                onPrimary: AppColors.mdAlert.withOpacity(0.1),
                primary: Colors.transparent,
                padding: EdgeInsets.zero,
                textStyle:
                    TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }
}
