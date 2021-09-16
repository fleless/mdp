import 'dart:convert';
import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_absolute_path/flutter_absolute_path.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mdp/constants/app_colors.dart';
import 'package:mdp/constants/routes.dart';
import 'package:mdp/constants/styles/app_styles.dart';
import 'package:mdp/utils/image_compresser.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:path_provider/path_provider.dart';

import '../../../../../../../interventions_bloc.dart';

class ShowChequePaymentWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ShowChequePaymentWidgetState();
}

class _ShowChequePaymentWidgetState extends State<ShowChequePaymentWidget> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final bloc = Modular.get<InterventionsBloc>();
  Asset image;
  final image_compressor = Modular.get<ImageCompressor>();
  bool _loading = false;

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
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      width: double.infinity,
      color: AppColors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            "Ajouter une photo du document : ",
            style: AppStyles.body,
          ),
          SizedBox(height: 20),
          _buildPhoto(),
          SizedBox(height: 50),
          _buildButton(),
          SizedBox(height: 30),
        ],
      ),
    );
  }

  Widget _buildPhoto() {
    return InkWell(
      onTap: () {},
      child: image == null
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
                      height: 240,
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
              child: GestureDetector(
                onTap: () async {
                  String path = await FlutterAbsolutePath.getAbsolutePath(
                      image.identifier);
                  Modular.to.pushNamed(Routes.photoView,
                      arguments: {'image': image, 'path': path});
                },
                child: Container(
                  width: 180,
                  height: 240,
                  child: AssetThumb(
                    asset: image,
                    width: 300,
                    height: 300,
                  ),
                ),
              ),
            ),
    );
  }

  Future<void> loadAssets() async {
    List<Asset> resultList;
    try {
      resultList = await MultiImagePicker.pickImages(
        maxImages: 1,
        enableCamera: true,
        selectedAssets: List<Asset>(),
        materialOptions: MaterialOptions(
            actionBarTitle: "Galerie",
            actionBarColor: "",
            lightStatusBar: true),
      );
    } on Exception catch (e) {}
    setState(() {
      resultList == null ? null : image = resultList[0];
    });
  }

  Widget _buildButton() {
    return ElevatedButton(
      child: Ink(
        decoration: BoxDecoration(
          color: _validButton() ? AppColors.md_dark_blue : AppColors.inactive,
          borderRadius: BorderRadius.all(
            Radius.circular(12),
          ),
          border: Border.all(
              color:
                  _validButton() ? AppColors.md_dark_blue : AppColors.inactive),
        ),
        child: Container(
          alignment: Alignment.center,
          width: double.infinity,
          height: 55,
          child: _loading
              ? Center(
                  child: CircularProgressIndicator(color: AppColors.white),
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
                ? _goSaveDocs()
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
    );
  }

  bool _validButton() {
    return image != null;
  }

  _goSaveDocs() async {
    setState(() {
      _loading = true;
    });
    //convert image to base64
    if (image != null) {
      final dir = await getTemporaryDirectory();
      var path2 = await FlutterAbsolutePath.getAbsolutePath(image.identifier);
      var file = await image_compressor.compressAndGetFile(
          File(path2), dir.absolute.path + "/temp.jpg");
      var base64Image = base64Encode(file.readAsBytesSync());
      //await bloc.uploadDocsIntervention(element, id);
      setState(() {
        _loading = false;
      });
    }
  }
}
