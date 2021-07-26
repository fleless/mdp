import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mdp/constants/app_colors.dart';
import 'package:mdp/constants/styles/app_styles.dart';
import 'package:mdp/models/responses/get_materials_response.dart';
import "dart:ui" as ui;
import '../../../../../../../interventions_bloc.dart';

class AddUpdateFournituresDialog extends StatefulWidget {
  ListWorkload liste;
  bool isAdd;

  AddUpdateFournituresDialog(this.liste, this.isAdd);

  @override
  State<StatefulWidget> createState() => _AddUpdateFournituresDialogState();
}

class _AddUpdateFournituresDialogState
    extends State<AddUpdateFournituresDialog> {
  final bloc = Modular.get<InterventionsBloc>();
  GlobalKey<FormState> formKey = new GlobalKey();
  TextEditingController _nomController = TextEditingController();
  TextEditingController _qteController = TextEditingController();
  TextEditingController _priceController = TextEditingController();
  TextEditingController _commentController = TextEditingController();
  bool _showQuantityError = false;
  bool _showPriceError = false;

  @override
  void initState() {
    _initData();
    super.initState();
  }

  _initData() {
    if (widget.isAdd) {
      _qteController.text = widget.liste.recommendedQuantity.toString();
      _priceController.text = widget.liste.recommendedPrice.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTitle(),
            SizedBox(height: 35),
            Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _buildName(),
                    SizedBox(height: 20),
                    _buildQuantity(),
                    _showQuantityError
                        ? Text(
                            "la quantité maximale: " +
                                (widget.liste.maximumQuantity.toString() ?? ""),
                            style: AppStyles.textFieldError,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis)
                        : SizedBox.shrink(),
                    SizedBox(height: 20),
                    _buildPrice(),
                    _showPriceError
                        ? Text(
                            "le tarif unitaire maximale: " +
                                (widget.liste.maximumPrice.toString() ?? ""),
                            style: AppStyles.textFieldError,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis)
                        : SizedBox.shrink(),
                    SizedBox(height: 20),
                    _buildCommentaire(),
                    SizedBox(height: 40),
                    _buildValidButton(),
                    SizedBox(height: 20),
                  ],
                )),
          ],
        ),
      ),
    );
  }

  Widget _buildTitle() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(
            widget.liste.name,
            style: AppStyles.header1,
            textAlign: TextAlign.left,
            overflow: TextOverflow.clip,
            maxLines: 3,
          ),
        ),
        SizedBox(width: 20),
        InkWell(
          onTap: () {
            Modular.to.pop();
          },
          child: Align(
            alignment: Alignment.topRight,
            child: Icon(
              Icons.close_outlined,
              size: 25,
              color: AppColors.closeDialogColor,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildName() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Nom de l'élément : ",
            style: AppStyles.bodyDefaultBlack,
            maxLines: 2,
            overflow: TextOverflow.ellipsis),
        SizedBox(height: 10),
        TextFormField(
          controller: _nomController,
          obscureText: false,
          cursorColor: AppColors.default_black,
          keyboardType: TextInputType.text,
          decoration: const InputDecoration(
            filled: true,
            fillColor: AppColors.white,
            border: OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.md_gray, width: 1),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.md_gray, width: 1),
            ),
            errorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.mdAlert, width: 1),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.md_dark_blue, width: 1),
            ),
            contentPadding: EdgeInsets.only(
                bottom: 10.0, left: 10.0, right: 10.0, top: 10.0),
            errorStyle: AppStyles.textFieldError,
            hintText: "Xxxx",
            hintStyle: AppStyles.textNormalPlaceholder,
          ),
          style: AppStyles.textNormal,
          validator: (String value) =>
              (value.isEmpty) ? '' : null,
        ),
      ],
    );
  }

  Widget _buildQuantity() {
    return Row(
      children: [
        Text("Quantité (/h):",
            style: AppStyles.bodyDefaultBlack,
            maxLines: 2,
            overflow: TextOverflow.ellipsis),
        SizedBox(width: 10),
        Container(
          width: 50,
          child: TextFormField(
              textAlign: TextAlign.center,
              controller: _qteController,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.allow(RegExp(r'(^\d+)')),
              ],
              onChanged: (value) {
                setState(() {
                  _showQuantityError = false;
                });
              },
              obscureText: false,
              cursorColor: AppColors.default_black,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                filled: true,
                fillColor: AppColors.white,
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: AppColors.md_gray, width: 1),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: AppColors.md_gray, width: 1),
                ),
                errorBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: AppColors.mdAlert, width: 1),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide:
                      BorderSide(color: AppColors.md_dark_blue, width: 1),
                ),
                contentPadding: EdgeInsets.only(
                    bottom: 10.0, left: 10.0, right: 10.0, top: 10.0),
                errorStyle: AppStyles.textFieldError,
                hintText: "Xxxx",
                hintStyle: AppStyles.textNormalPlaceholder,
              ),
              style: AppStyles.textNormal,
              validator: (String value) {
                if (value.isEmpty) {
                  return '';
                } else if (double.parse(value) == null) {
                  return '';
                } else if (!(double.parse(value) > 0.0)) {
                  return '';
                } else if (double.parse(value) > widget.liste.maximumQuantity) {
                  setState(() {
                    _showQuantityError = true;
                  });
                  return '';
                } else {
                  return null;
                }
              }),
        ),
      ],
    );
  }

  Widget _buildPrice() {
    return Row(
      children: [
        Text("Tarif unitaire :",
            style: AppStyles.bodyDefaultBlack,
            maxLines: 2,
            overflow: TextOverflow.ellipsis),
        SizedBox(width: 10),
        Container(
          width: 120,
          child: TextFormField(
              textAlign: TextAlign.center,
              controller: _priceController,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.allow(RegExp(r'(^\d+\.?\d?\d?)')),
              ],
              onChanged: (value) {
                setState(() {
                  _showPriceError = false;
                });
              },
              obscureText: false,
              cursorColor: AppColors.default_black,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                filled: true,
                fillColor: AppColors.white,
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: AppColors.md_gray, width: 1),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: AppColors.md_gray, width: 1),
                ),
                errorBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: AppColors.mdAlert, width: 1),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide:
                      BorderSide(color: AppColors.md_dark_blue, width: 1),
                ),
                contentPadding: EdgeInsets.only(
                    bottom: 10.0, left: 10.0, right: 10.0, top: 10.0),
                errorStyle: AppStyles.textFieldError,
                hintText: "00€ HT",
                hintStyle: AppStyles.textNormalPlaceholder,
              ),
              style: AppStyles.textNormal,
              validator: (String value) {
                if (value.isEmpty) {
                  return '';
                } else if (value.endsWith('.')) {
                  return ('');
                } else if (double.parse(value) == null) {
                  return '';
                } else if (!(double.parse(value) > 0.0)) {
                  return '';
                } else if (double.parse(value) > widget.liste.maximumPrice) {
                  setState(() {
                    _showPriceError = true;
                  });
                  return '';
                } else {
                  return null;
                }
              }),
        ),
      ],
    );
  }

  Widget _buildCommentaire() {
    return Container(
      width: double.infinity,
      child: TextFormField(
        textAlign: TextAlign.start,
        controller: _commentController,
        obscureText: false,
        maxLines: null,
        minLines: 5,
        cursorColor: AppColors.default_black,
        keyboardType: TextInputType.multiline,
        decoration: const InputDecoration(
          filled: true,
          fillColor: AppColors.white,
          border: OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.md_gray, width: 1),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.md_gray, width: 1),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.mdAlert, width: 1),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.md_dark_blue, width: 1),
          ),
          contentPadding:
              EdgeInsets.only(bottom: 10.0, left: 10.0, right: 10.0, top: 10.0),
          errorStyle: AppStyles.textFieldError,
          hintText: "Commentaire ...",
          hintStyle: AppStyles.textNormalPlaceholder,
        ),
        style: AppStyles.textNormal,
        validator: (String value) =>
            (value.isEmpty) ? '' : null,
      ),
    );
  }

  Widget _buildValidButton() {
    return ElevatedButton(
      child: Ink(
        decoration: BoxDecoration(
          color: AppColors.md_dark_blue,
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
            widget.isAdd ? "AJOUTER" : "MODIFIER",
            style: AppStyles.buttonTextWhite,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
      onPressed: () {
        if (formKey.currentState.validate()) {}
      },
      style: ElevatedButton.styleFrom(
          elevation: 2,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          onPrimary: AppColors.white,
          primary: Colors.transparent,
          padding: EdgeInsets.zero,
          textStyle: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
    );
  }
}
