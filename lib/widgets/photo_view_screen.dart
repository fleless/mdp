import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_absolute_path/flutter_absolute_path.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mdp/constants/app_colors.dart';
import 'package:mdp/constants/app_constants.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:photo_view/photo_view.dart';

class PhotoViewScreenWidget extends StatefulWidget {
  dynamic image;
  String path;

  PhotoViewScreenWidget(dynamic image, String path) {
    this.image = image;
    this.path = path;
  }

  @override
  State<StatefulWidget> createState() => _PhotoViewScreenWidgetState();
}

class _PhotoViewScreenWidgetState extends State<PhotoViewScreenWidget> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  dynamic _image;

  @override
  void initState() {
    super.initState();
    _image = widget.image;
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      resizeToAvoidBottomInset: true,
      backgroundColor: AppColors.default_black,
      //drawer: DrawerWidget(),
      body: Container(
          height: double.infinity,
          width: double.infinity,
          child: _image.runtimeType == String
              ? _buildContent()
              : _buildContentAsset()),
    );
  }

  Widget _buildContent() {
    return Stack(
      children: [
        // wecan show all photos and swipe wih this library
        Hero(
          tag: AppConstants.IMAGE_VIEWER_TAG,
          child: PhotoView(
            enableRotation: true,
            imageProvider: NetworkImage(_image),
          ),
        ),
        Positioned(
          top: 75.0,
          right: 30.0,
          child: InkWell(
            onTap: () => Modular.to.pop(),
            child: FaIcon(
              FontAwesomeIcons.times,
              color: AppColors.white,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildContentAsset() {
    print("vwala le path " + widget.path);
    return Stack(
      children: [
        // wecan show all photos and swipe wih this library
        Hero(
          tag: AppConstants.IMAGE_VIEWER_TAG,
          child: PhotoView(
            enableRotation: true,
            imageProvider: Image.file(File(widget.path)).image,
          ),
        ),
        Positioned(
          top: 75.0,
          right: 30.0,
          child: InkWell(
            onTap: () => Modular.to.pop(),
            child: FaIcon(
              FontAwesomeIcons.times,
              color: AppColors.white,
            ),
          ),
        ),
      ],
    );
  }
}
