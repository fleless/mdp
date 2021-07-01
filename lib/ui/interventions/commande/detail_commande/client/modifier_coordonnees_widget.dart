import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mdp/constants/app_colors.dart';
import 'package:mdp/constants/styles/app_styles.dart';

class ModifierCoordonneesWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ModifierCoordonneesWidgetState();
}

class _ModifierCoordonneesWidgetState extends State<ModifierCoordonneesWidget> {
  GlobalKey<FormState> formKey = new GlobalKey();
  TextEditingController _firstNameController = TextEditingController();
  TextEditingController _lastNameController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _emailController = TextEditingController();

  @override
  void initState() {
    _initValues();
    super.initState();
  }

  _initValues() {
    _firstNameController.text = "Marc";
    _lastNameController.text = "DUPUIS";
    _phoneController.text = "0794859483";
    _emailController.text = "Marc.dupuis@email.com";
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
            "Modifier les coordonnées",
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
        child: Form(
          key: formKey,
          child: Column(
            children: [
              _buildFirstName(),
              SizedBox(height: 10),
              _buildLastName(),
              SizedBox(height: 10),
              _buildPhone(),
              SizedBox(height: 10),
              _buildEmail(),
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

  Widget _buildPhone() {
    return TextFormField(
      controller: _phoneController,
      obscureText: false,
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter.allow(RegExp(r'(^\d+)')),
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
        hintText: "Téléphone",
        hintStyle: AppStyles.textNormalPlaceholder,
      ),
      style: AppStyles.textNormal,
      validator: (String value) => (value.isEmpty)
          ? 'ce champ ne peut pas être vide'
          : (value.length < 9)
              ? 'numéro de téléphone invalide'
              : null,
    );
  }

  Widget _buildEmail() {
    return TextFormField(
      controller: _emailController,
      obscureText: false,
      cursorColor: AppColors.default_black,
      keyboardType: TextInputType.emailAddress,
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
        hintText: "Email",
        hintStyle: AppStyles.textNormalPlaceholder,
      ),
      style: AppStyles.textNormal,
      validator: (String value) => (value.isEmpty)
          ? 'ce champ ne peut pas être vide'
          : (EmailValidator.validate(value))
              ? null
              : 'email non valide',
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
