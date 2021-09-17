import 'dart:convert';
import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_absolute_path/flutter_absolute_path.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mdp/constants/app_colors.dart';
import 'package:mdp/constants/routes.dart';
import 'package:mdp/constants/styles/app_styles.dart';
import 'package:mdp/models/responses/intervention_detail_response.dart'
    as DetailResponse;
import 'package:mdp/models/responses/payment/start_payment_response.dart';
import 'package:mdp/models/responses/upload_document_response.dart';
import 'package:mdp/ui/interventions/commande/detail_commande/intervention/steps/finalisation_intervention/finalisation_intervention_bloc.dart';
import 'package:mdp/utils/flushbar_utils.dart';
import 'package:mdp/utils/image_compresser.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:path_provider/path_provider.dart';

import '../../../../../interventions_bloc.dart';

class FinalisationInterventionWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _FinalisationInterventionWidgetState();
}

class _FinalisationInterventionWidgetState
    extends State<FinalisationInterventionWidget> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  bool opened = false;
  final bloc = Modular.get<InterventionsBloc>();
  final image_compressor = Modular.get<ImageCompressor>();
  final _finalisationInterventionBloc =
      Modular.get<FinalisationInterventionBloc>();
  bool _paymentButtonLoading = false;

  //les listes pour les photos
  List<DetailResponse.Documents> imagesAlreadyUploaded =
      <DetailResponse.Documents>[];

  @override
  void initState() {
    super.initState();
    _loadImages();
    bloc.changesNotifier.listen((value) {
      if (mounted)
        setState(() {
          _loadImages();
        });
    });
  }

  _loadImages() {
    setState(() {
      imagesAlreadyUploaded = bloc
          .interventionDetail.interventionDetail.documents
          .where((element) => element.documentType == "Photo apr\u00e8s")
          .toList();
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

  _weAreInThisStep() {
    return (bloc.interventionDetail.interventionDetail.state.name ==
        "WAITING_FINISH");
  }

  _weAreBeforeThisStep() {
    //TODO: ajouter le check de paiement pas fait
    return (bloc.interventionDetail.interventionDetail.state.name !=
        "WAITING_FINISH");
  }

  _weEndedThisStep() {
    //TODO: ajouter le check de paiement fait
    return (bloc.interventionDetail.interventionDetail.state.name ==
        "WAITING_FINISH");
  }

  Widget _buildContent() {
    return Container(
        width: double.infinity,
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              color: _weAreInThisStep()
                  ? AppColors.md_light_gray
                  : AppColors.white,
              child: _buildHeader(),
            ),
            opened ? _buildExpansion() : SizedBox.shrink()
          ],
        ));
  }

  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _weAreInThisStep()
                ? Container(
                    width: 30.0,
                    height: 30.0,
                    alignment: Alignment.center,
                    decoration: new BoxDecoration(
                      color: AppColors.md_dark_blue,
                      shape: BoxShape.circle,
                      border: Border.all(
                          color: _weAreInThisStep()
                              ? AppColors.md_dark_blue
                              : AppColors.md_primary,
                          width: 1.5),
                    ),
                    child: FaIcon(
                      FontAwesomeIcons.handsHelping,
                      color: AppColors.md_text_white,
                      size: 16,
                    ),
                  )
                : Container(
                    width: 30.0,
                    height: 30.0,
                    alignment: Alignment.center,
                    decoration: new BoxDecoration(
                      color: Colors.transparent,
                      shape: BoxShape.circle,
                      border:
                          Border.all(color: AppColors.placeHolder, width: 1.5),
                    ),
                    child: Text(
                      "4",
                      style: AppStyles.header2Gray,
                    ),
                  ),
            SizedBox(width: 10),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 3),
                  Text("Finalisation de l'intervention",
                      style: _weAreInThisStep()
                          ? AppStyles.header2DarkBlue
                          : AppStyles.header2Gray),
                  _weAreInThisStep() ? SizedBox(height: 5) : SizedBox.shrink(),
                  _weAreInThisStep()
                      ? Container(
                          padding: EdgeInsets.all(7),
                          decoration: BoxDecoration(
                            color: AppColors.mdAlert,
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                          ),
                          child: Text("  À réaliser ",
                              style: AppStyles.tinyTitleWhite,
                              textAlign: TextAlign.center,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis),
                        )
                      : SizedBox.shrink(),
                ],
              ),
            ),
            Container(
              height: 50,
              child: IconButton(
                onPressed: () {
                  _weAreInThisStep()
                      ? setState(() {
                          opened = !opened;
                        })
                      : null;
                },
                iconSize: 12,
                alignment: Alignment.topCenter,
                icon: FaIcon(
                    opened
                        ? FontAwesomeIcons.chevronUp
                        : FontAwesomeIcons.chevronDown,
                    color: _weAreInThisStep()
                        ? AppColors.md_dark_blue
                        : AppColors.placeHolder,
                    size: 12),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildExpansion() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      color: _weAreInThisStep() ? AppColors.md_light_gray : AppColors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _buildPhotos(),
          SizedBox(height: 30),
          _buildDocuments(),
          SizedBox(height: 15),
          Divider(
            color: AppColors.md_gray,
            thickness: 1.5,
          ),
          SizedBox(height: 15),
          _builPayment(),
          SizedBox(height: 30),
        ],
      ),
    );
  }

  Widget _buildPhotos() {
    return Container(
      width: double.infinity,
      child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Ajouter les photos de fin de travaux :",
                style: AppStyles.bodyDefaultBlack,
                overflow: TextOverflow.ellipsis,
                maxLines: 3),
            SizedBox(height: 3),
            Text("Max. 9 photos, téléchargeables jusqu’à 3 par 3",
                style: AppStyles.textNormalPlaceholder,
                overflow: TextOverflow.ellipsis,
                maxLines: 3),
            SizedBox(height: 15),
            Container(
              height: 200,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: (imagesAlreadyUploaded.length) >= 9
                      ? imagesAlreadyUploaded.length
                      : imagesAlreadyUploaded.length + 1,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return InkWell(
                        onTap: () async {
                          Modular.to.pushNamed(Routes.photoView, arguments: {
                            'image': imagesAlreadyUploaded[index].url,
                            'path': ""
                          });
                        },
                        child: (index < imagesAlreadyUploaded.length)
                            ? Card(
                                clipBehavior: Clip.antiAliasWithSaveLayer,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                elevation: 4,
                                child: Container(
                                  width: 150,
                                  child: Image.network(
                                      imagesAlreadyUploaded[index].url,
                                      fit: BoxFit.cover),
                                ),
                              )
                            : GestureDetector(
                                onTap: () {
                                  loadAssets();
                                },
                                child: DottedBorder(
                                  borderType: BorderType.RRect,
                                  color: AppColors.md_tertiary,
                                  radius: Radius.circular(12),
                                  padding: EdgeInsets.all(6),
                                  child: ClipRRect(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(12)),
                                    child: Container(
                                        width: 150,
                                        padding: EdgeInsets.all(40),
                                        alignment: Alignment.center,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Icon(
                                              Icons.photo_camera,
                                              color: AppColors.md_tertiary,
                                            ),
                                            SizedBox(height: 12),
                                            Text(
                                              "PRENDRE UNE PHOTO",
                                              style:
                                                  AppStyles.buttonTextTertiary,
                                              maxLines: 4,
                                              textAlign: TextAlign.center,
                                              overflow: TextOverflow.ellipsis,
                                            )
                                          ],
                                        )),
                                  ),
                                ),
                              ));
                  }),
            )
          ]),
    );
  }

  Future<void> loadAssets() async {
    List<Asset> resultList = <Asset>[];
    try {
      resultList = await MultiImagePicker.pickImages(
        maxImages: imagesAlreadyUploaded.length == 8
            ? 1
            : (imagesAlreadyUploaded.length == 7 ? 2 : 3),
        enableCamera: true,
        selectedAssets: resultList,
        materialOptions: MaterialOptions(
            actionBarTitle: "Galerie",
            actionBarColor: "",
            lightStatusBar: true),
      );
    } on Exception catch (e) {}
    resultList.forEach((element) async {
      final dir = await getTemporaryDirectory();
      var path2 = await FlutterAbsolutePath.getAbsolutePath(element.identifier);
      var file = await image_compressor.compressAndGetFile(
          File(path2), dir.absolute.path + "/temp.jpg");
      var base64Image = base64Encode(file.readAsBytesSync());
      UploadDocumentResponse resp = await bloc.uploadPhotosIntervention(
          bloc.interventionDetail.interventionDetail.id, base64Image);
      bloc.getInterventionDetail(
          bloc.interventionDetail.interventionDetail.uuid);
      if ((resp.documentUploaded != null) && (resp.documentUploaded)) {}
    });
  }

  Widget _buildDocuments() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Ajouter les documents de fin d'intervention (optionnel) :",
            style: AppStyles.bodyDefaultBlack,
            overflow: TextOverflow.ellipsis,
            maxLines: 3),
        SizedBox(height: 15),
        for (var element
            in bloc.interventionDetail.interventionDetail.documents)
          _buildDocsBloc(element),
        SizedBox(height: 15),
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
                        "AJOUTER UN DOCUMENT",
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
            Modular.to.pushNamed(Routes.documentTypeSelector);
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

  Widget _buildDocsBloc(DetailResponse.Documents element) {
    return ((element.documentType == "Photo après") ||
            (element.documentType == "Photo avant") ||
            (element.documentType == "Photo client"))
        ? SizedBox.shrink()
        : Padding(
            padding: EdgeInsets.symmetric(vertical: 5),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(15)),
                border:
                    Border.all(color: AppColors.closeDialogColor, width: 1.1),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.check_circle,
                    color: AppColors.closeDialogColor,
                  ),
                  SizedBox(width: 20),
                  Expanded(
                    child: Text(
                      element.documentType,
                      style: AppStyles.bodyBold,
                    ),
                  ),
                ],
              ),
            ),
          );
  }

  Widget _builPayment() {
    return Column(
      children: [
        Row(
          children: [
            FaIcon(
              FontAwesomeIcons.solidCreditCard,
              color: AppColors.default_black,
            ),
            SizedBox(width: 10),
            Expanded(
              child: Text(
                'Paiement',
                style: AppStyles.header3,
              ),
            ),
          ],
        ),
        SizedBox(height: 30),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Expanded(
              child: Column(
                children: [
                  Container(
                    width: 30.0,
                    height: 30.0,
                    alignment: Alignment.center,
                    decoration: new BoxDecoration(
                      color: imagesAlreadyUploaded.isEmpty
                          ? AppColors.inactive
                          : AppColors.md_dark_blue,
                      shape: BoxShape.circle,
                      border: Border.all(
                          color: imagesAlreadyUploaded.isEmpty
                              ? AppColors.inactive
                              : AppColors.md_dark_blue,
                          width: 1.5),
                    ),
                    child: Text(
                      "1",
                      style: imagesAlreadyUploaded.isEmpty
                          ? AppStyles.buttonInactiveText
                          : AppStyles.buttonTextWhite,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "Déclencher le paiement",
                    style: AppStyles.body,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            SizedBox(width: 10),
            Expanded(
              child: Column(
                children: [
                  Container(
                    width: 30.0,
                    height: 30.0,
                    alignment: Alignment.center,
                    decoration: new BoxDecoration(
                      color: AppColors.md_gray,
                      shape: BoxShape.circle,
                      border: Border.all(color: AppColors.md_gray, width: 1.5),
                    ),
                    child: Text(
                      "2",
                      style: AppStyles.buttonInactiveText,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "Paiement en cours",
                    style: AppStyles.body,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            SizedBox(width: 10),
            Expanded(
              child: Column(
                children: [
                  Container(
                    width: 30.0,
                    height: 30.0,
                    alignment: Alignment.center,
                    decoration: new BoxDecoration(
                      color: AppColors.md_gray,
                      shape: BoxShape.circle,
                      border: Border.all(color: AppColors.md_gray, width: 1.5),
                    ),
                    child: Text(
                      "3",
                      style: AppStyles.buttonInactiveText,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "Paiement  validé",
                    style: AppStyles.body,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 30),
        ElevatedButton(
          child: Ink(
            decoration: BoxDecoration(
              color: imagesAlreadyUploaded.isEmpty
                  ? AppColors.inactive
                  : AppColors.md_dark_blue,
              borderRadius: BorderRadius.all(
                Radius.circular(12),
              ),
              border: Border.all(
                  color: imagesAlreadyUploaded.isEmpty
                      ? AppColors.inactive
                      : AppColors.md_dark_blue),
            ),
            child: Container(
              alignment: Alignment.center,
              width: double.infinity,
              height: 55,
              child: _paymentButtonLoading
                  ? Center(
                      child: CircularProgressIndicator(
                        color: AppColors.white,
                      ),
                    )
                  : Text(
                      "DÉCLENCHER LE PAIEMENT",
                      style: imagesAlreadyUploaded.isEmpty
                          ? AppStyles.buttonInactiveText
                          : AppStyles.buttonTextWhite,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
            ),
          ),
          onPressed: () {
            _paymentButtonLoading
                ? null
                : imagesAlreadyUploaded.isEmpty
                    ? null
                    : _startPayment();
          },
          style: ElevatedButton.styleFrom(
              elevation: 5,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              onPrimary: AppColors.white,
              primary: Colors.transparent,
              padding: EdgeInsets.zero,
              textStyle: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
        ),
      ],
    );
  }

  _startPayment() async {
    setState(() {
      _paymentButtonLoading = true;
    });
    StartPaymentResponse resp = await _finalisationInterventionBloc
        .startPayment(bloc.interventionDetail.interventionDetail.code);
    setState(() {
      _paymentButtonLoading = false;
    });
    if (resp.paymentStatus == "PAYMENT_OK") {
      //payment done
      Modular.to.pushNamed(Routes.paymentMessage, arguments: {
        "status": true,
        "message":
            "Le prélèvement va être réalisé sur la carte bleue renseignée par le client"
      });
    } else if ((resp.paymentStatus == "PAYMENT_TODO") &&
        (resp.paymentId != null)) {
      _finalisationInterventionBloc.paymentId = resp.paymentId;
      Modular.to.pushNamed(Routes.paymentPrincipalOptionsScreen);
    } else {
      showErrorToast(context, "Une erreur est survenue");
    }
  }
}
