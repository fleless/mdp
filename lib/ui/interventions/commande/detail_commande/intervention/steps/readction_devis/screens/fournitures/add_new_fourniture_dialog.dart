import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mdp/constants/app_colors.dart';
import 'package:mdp/constants/styles/app_styles.dart';
import 'package:mdp/models/responses/add_new_material_response.dart';
import 'package:mdp/models/responses/get_materials_response.dart';
import 'package:mdp/models/responses/units_response.dart';
import 'package:mdp/models/workload_model.dart';
import "dart:ui" as ui;
import '../../../../../../../interventions_bloc.dart';
import '../../redaction_devis_bloc.dart';

class AddNewFournituresDialog extends StatefulWidget {
  AddNewFournituresDialog();

  @override
  State<StatefulWidget> createState() => _AddNewFournitureDialogState();
}

class _AddNewFournitureDialogState extends State<AddNewFournituresDialog> {
  final bloc = Modular.get<InterventionsBloc>();
  final _redactionBloc = Modular.get<RedactionDevisBloc>();
  GlobalKey<FormState> formKey = new GlobalKey();
  TextEditingController _nomController = TextEditingController();
  TextEditingController _qteController = TextEditingController();
  TextEditingController _priceController = TextEditingController();
  TextEditingController _commentController = TextEditingController();
  bool _loading = false;
  ListWorkloadUnits selectedunit;

  @override
  void initState() {
    selectedunit = bloc.liste_units[0];
    super.initState();
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
                    SizedBox(height: 20),
                    _buildPrice(),
                    SizedBox(height: 20),
                    _buildUnit(),
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
            "Ajouter un autre élément",
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
          validator: (String value) => (value.isEmpty) ? '' : null,
        ),
      ],
    );
  }

  Widget _buildQuantity() {
    return Row(
      children: [
        Text("Quantité :",
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
                hintText: "0€",
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
                } else {
                  return null;
                }
              }),
        ),
      ],
    );
  }

  Widget _buildUnit() {
    return Row(
      children: [
        Text("Unité :",
            style: AppStyles.bodyDefaultBlack,
            maxLines: 2,
            overflow: TextOverflow.ellipsis),
        SizedBox(width: 10),
        Container(
          width: 120,
          height: 40,
          child: Theme(
            // Create a unique theme with "ThemeData"
            data: ThemeData(
              primarySwatch: AppColors.defaultColorMaterial,
            ),
            child: DropdownSearch<String>(
                maxHeight: 150,
                searchBoxDecoration: null,
                dropdownSearchDecoration: null,
                mode: Mode.MENU,
                items: bloc.liste_unit_names,
                selectedItem: bloc.liste_unit_names[0],
                errorBuilder: null,
                label: "",
                validator: (value) {
                  if (selectedunit == null) {
                    return '';
                  } else {
                    return null;
                  }
                },
                onChanged: (value) {
                  selectedunit =
                      bloc.liste_units[bloc.liste_unit_names.indexOf(value)];
                }),
          ),
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
        //validator: (String value) => (value.isEmpty) ? '' : null,
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
          child: _loading
              ? Center(
                  child: CircularProgressIndicator(color: AppColors.white),
                )
              : Text(
                  "AJOUTER",
                  style: AppStyles.buttonTextWhite,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
        ),
      ),
      onPressed: () {
        _loading ? null : _goSave();
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

  _goSave() async {
    setState(() {
      _loading = true;
    });
    if (formKey.currentState.validate()) {
      AddNewMaterialResponse resp = await _redactionBloc.addNewMaterial(
          _nomController.text,
          _commentController.text,
          selectedunit.id,
          int.parse(_qteController.text),
          double.parse(_priceController.text));
      if (resp.workLoadData == null) {
        Fluttertoast.showToast(msg: "error survenue");
      } else {
        await bloc.getMaterials();
        _redactionBloc.liste_materiel.add(WorkLoadModel(
            resp.workLoadData.id,
            _nomController.text,
            _qteController.text,
            _priceController.text,
            _commentController.text));
        Modular.to.pop();
        _redactionBloc.notifyChanges.add(0);
      }
    }
    setState(() {
      _loading = false;
    });
  }
}
