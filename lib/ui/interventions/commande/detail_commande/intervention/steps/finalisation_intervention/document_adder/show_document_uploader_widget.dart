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

import '../../../../../../interventions_bloc.dart';

class ShowDocumentUploaderWidget extends StatefulWidget {
  String type;

  @override
  State<StatefulWidget> createState() => _ShowDocumentUploaderWidgetState();

  ShowDocumentUploaderWidget(String type) {
    this.type = type;
  }
}

class _ShowDocumentUploaderWidgetState
    extends State<ShowDocumentUploaderWidget> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final bloc = Modular.get<InterventionsBloc>();
  List<File> documentsList = <File>[];
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
          SizedBox(height: 20),
          Text(
            "Ou ajouter le document : ",
            style: AppStyles.body,
          ),
          SizedBox(height: 20),
          for (var element in documentsList)
            Padding(
              padding: EdgeInsets.only(bottom: 15),
              child: _buildListDoc(element),
            ),
          SizedBox(height: 20),
          _buildDocButton(),
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

  Widget _buildDocButton() {
    return ElevatedButton(
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
      onPressed: () async {
        FilePickerResult result = await FilePicker.platform.pickFiles();
        if (result != null) {
          File file = File(result.files.single.path);
          setState(() {
            documentsList.add(file);
          });
        } else {
          // User canceled the picker
        }
      },
      style: ElevatedButton.styleFrom(
          elevation: 0,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          onPrimary: AppColors.md_tertiary,
          primary: Colors.transparent,
          padding: EdgeInsets.zero,
          textStyle: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
    );
  }

  Widget _buildListDoc(File element) {
    return Row(
      children: [
        Expanded(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(15)),
              border: Border.all(color: AppColors.md_dark_blue, width: 1.3),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.check_circle,
                  color: AppColors.md_dark_blue,
                ),
                SizedBox(width: 20),
                Expanded(
                  child: Text(
                    widget.type,
                    style: AppStyles.bodyBold,
                  ),
                ),
              ],
            ),
          ),
        ),
        IconButton(
          splashColor: AppColors.md_dark_blue,
          onPressed: () {
            setState(() {
              documentsList.removeWhere((ele) => ele == element);
            });
          },
          icon: Icon(
            Icons.close,
            color: AppColors.md_dark_blue,
          ),
        ),
      ],
    );
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
    if ((documentsList == null) && (image != null)) return true;
    if ((documentsList == null) && (image == null)) return false;
    return ((image != null) || (documentsList.length > 0));
  }

  _goSaveDocs() async {
    setState(() {
      _loading = true;
    });
    // First get id of type document (backend)
    num id = bloc.liste_documents
        .firstWhere((element) => element.name == widget.type)
        .id;
    List<String> lista = <String>[];
    //convert image to base64
    if (image != null) {
      final dir = await getTemporaryDirectory();
      var path2 = await FlutterAbsolutePath.getAbsolutePath(image.identifier);
      var file = await image_compressor.compressAndGetFile(
          File(path2), dir.absolute.path + "/temp.jpg");
      var base64Image = base64Encode(file.readAsBytesSync());
      lista.add(base64Image);
    }
    //convert docs to base64
    if ((documentsList != null) && (documentsList.length > 0)) {
      documentsList.forEach((element) async {
        final dir = await getTemporaryDirectory();
        var path2 = await FlutterAbsolutePath.getAbsolutePath(element.path);
        var file = await image_compressor.compressAndGetFile(
            File(path2), dir.absolute.path + "/temp.jpg");
        //If it'is image itz gonna be compressed and use file, in the other side if it is another extension get the base64 directly from element
        var base64Image = file == null
            ? base64Encode(element.readAsBytesSync())
            : base64Encode(file.readAsBytesSync());
        lista.add(base64Image);
        //check if we ended converting the last doc
        if (image == null
            ? lista.length == documentsList.length
            : lista.length == documentsList.length + 1) {
          var index = 0;
          lista.forEach((element) async {
            await bloc.uploadDocsIntervention(element, id);
            index++;
            if (index == lista.length) {
              setState(() {
                _loading = false;
              });
              Modular.to.pop();
              await bloc.getInterventionDetail(
                  bloc.interventionDetail.interventionDetail.uuid);
            }
          });
        }
      });
    } else {
      await bloc.uploadDocsIntervention(lista[0], id);
      setState(() {
        _loading = false;
      });
      Modular.to.pop();
      await bloc.getInterventionDetail(
          bloc.interventionDetail.interventionDetail.uuid);
    }
  }
}
