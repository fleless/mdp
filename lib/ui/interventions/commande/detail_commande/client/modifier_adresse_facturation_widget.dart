import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mdp/constants/app_colors.dart';
import 'package:mdp/constants/styles/app_styles.dart';

class ModifierAdresseFacturationWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ModifierAdresseFacturationWidgetState();
}

class _ModifierAdresseFacturationWidgetState extends State<ModifierAdresseFacturationWidget> {
  GlobalKey<FormState> formKey = new GlobalKey();
  TextEditingController _firstNameController = TextEditingController();
  TextEditingController _lastNameController = TextEditingController();
  TextEditingController _adressController = TextEditingController();
  TextEditingController _complementAdresseController = TextEditingController();
  TextEditingController _zipController = TextEditingController();
  TextEditingController _communityController = TextEditingController();

  @override
  void initState() {
    _initValues();
    super.initState();
  }

  _initValues(){
    _firstNameController.text = "Marc";
    _lastNameController.text = "DUPUIS";
    _adressController.text = "53 Rue André Chemin";
    _complementAdresseController.text = "Bat B";
    _zipController.text = "78000";
    _communityController.text = "Versailles";
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [_buildTitle(), _buildForm()],
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
            "Modifier l’adresse de facturation",
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

  Widget _buildForm() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 20),
      child: SingleChildScrollView(
        primary: true,
        scrollDirection: Axis.vertical,
        child: Form(
          key: formKey,
          child: Column(
            children: [
              _buildFirstName(),
              SizedBox(height: 10),
              _buildLastName(),
              SizedBox(height: 10),
              _buildAdress(),
              SizedBox(height: 10),
              _buildComplementAdress(),
              SizedBox(height: 10),
              _buildZip(),
              SizedBox(height: 10),
              _buildCommunity(),
              SizedBox(height: 20),
              _buildSubmitButton()
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFirstName() {
    return TextFormField(
      controller: _firstNameController,
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
        contentPadding:
        EdgeInsets.only(bottom: 10.0, left: 10.0, right: 10.0, top: 10.0),
        errorStyle: AppStyles.textFieldError,
        hintText: "Prénom",
        hintStyle: AppStyles.textNormalPlaceholder,
      ),
      style: AppStyles.textNormal,
      validator: (String value) =>
      (value.isEmpty) ? 'ce champ ne peut pas être vide' : null,
    );
  }

  Widget _buildLastName() {
    return TextFormField(
      controller: _lastNameController,
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
        contentPadding:
        EdgeInsets.only(bottom: 10.0, left: 10.0, right: 10.0, top: 10.0),
        errorStyle: AppStyles.textFieldError,
        hintText: "Nom",
        hintStyle: AppStyles.textNormalPlaceholder,
      ),
      style: AppStyles.textNormal,
      validator: (String value) =>
      (value.isEmpty) ? 'ce champ ne peut pas être vide' : null,
    );
  }

  Widget _buildAdress() {
    return TextFormField(
      controller: _adressController,
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
        contentPadding:
        EdgeInsets.only(bottom: 10.0, left: 10.0, right: 10.0, top: 10.0),
        errorStyle: AppStyles.textFieldError,
        hintText: "Adresse",
        hintStyle: AppStyles.textNormalPlaceholder,
      ),
      style: AppStyles.textNormal,
      validator: (String value) =>
      (value.isEmpty) ? 'ce champ ne peut pas être vide' : null,
    );
  }

  Widget _buildComplementAdress() {
    return TextFormField(
      controller: _complementAdresseController,
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
        contentPadding:
        EdgeInsets.only(bottom: 10.0, left: 10.0, right: 10.0, top: 10.0),
        errorStyle: AppStyles.textFieldError,
        hintText: "Complément d'adresse",
        hintStyle: AppStyles.textNormalPlaceholder,
      ),
      style: AppStyles.textNormal,
      validator: (String value) =>
      (value.isEmpty) ? 'ce champ ne peut pas être vide' : null,
    );
  }

  Widget _buildZip() {
    return TextFormField(
      controller: _zipController,
      obscureText: false,
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter.allow(
            RegExp(r'(^\d+)')),
      ],
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
          borderSide: BorderSide(color: AppColors.md_dark_blue, width: 1),
        ),
        contentPadding:
        EdgeInsets.only(bottom: 10.0, left: 10.0, right: 10.0, top: 10.0),
        errorStyle: AppStyles.textFieldError,
        hintText: "Code postale",
        hintStyle: AppStyles.textNormalPlaceholder,
      ),
      style: AppStyles.textNormal,
      validator: (String value) => (value.isEmpty)
          ? 'ce champ ne peut pas être vide'
          : (value.length != 5)
          ? 'code postale invalide'
          : null,
    );
  }

  Widget _buildCommunity() {
    return TextFormField(
      controller: _communityController,
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
        contentPadding:
        EdgeInsets.only(bottom: 10.0, left: 10.0, right: 10.0, top: 10.0),
        errorStyle: AppStyles.textFieldError,
        hintText: "Communité",
        hintStyle: AppStyles.textNormalPlaceholder,
      ),
      style: AppStyles.textNormal,
      validator: (String value) =>
      (value.isEmpty) ? 'ce champ ne peut pas être vide' : null,
    );
  }

  Widget _buildSubmitButton() {
    return ElevatedButton(
      child: Ink(
        decoration: BoxDecoration(
          color: AppColors.md_dark_blue,
          borderRadius: BorderRadius.all(
            Radius.circular(12),
          ),
        ),
        child: Container(
          alignment: Alignment.center,
          width: double.infinity,
          height: 55,
          child: Text(
            "VALIDER LES MODIFICATIONS",
            style: AppStyles.smallTitleWhite,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
      onPressed: () {
        final formState = formKey.currentState;
        if (formState.validate()) {
          // then do something
        }
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

}