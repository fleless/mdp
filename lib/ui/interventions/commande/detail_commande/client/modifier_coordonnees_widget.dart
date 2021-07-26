import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:group_radio_button/group_radio_button.dart';
import 'package:mdp/constants/app_colors.dart';
import 'package:mdp/constants/styles/app_styles.dart';
import 'package:mdp/models/responses/result_message_response.dart';
import 'package:collection/collection.dart';

import '../../../interventions_bloc.dart';

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
  final bloc = Modular.get<InterventionsBloc>();
  bool _loading = false;
  String _singleValue = "";

  @override
  void initState() {
    _initValues();
    super.initState();
  }

  _initValues() {
    dynamic email = bloc
        .interventionDetail.interventionDetail.clients.commchannels
        .firstWhereOrNull(
            (element) => (element.preferred) && (element.type.name == "Email"));
    _firstNameController.text =
        bloc.interventionDetail.interventionDetail.clients.firstname;
    _lastNameController.text =
        bloc.interventionDetail.interventionDetail.clients.lastname;
    _phoneController.text = bloc
        .interventionDetail.interventionDetail.clients.commchannels
        .firstWhere(
            (element) => (element.preferred) && (element.type.name == "Phone"))
        .name;
    email == null ? _emailController.text ="" : _emailController.text = bloc
        .interventionDetail.interventionDetail.clients.commchannels
        .firstWhere(
            (element) => (element.preferred) && (element.type.name == "Email"))
        .name;
    setState(() {
      _singleValue =
          bloc.interventionDetail.interventionDetail.clients.civility;
    });
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
              _buildCivility(),
              SizedBox(height: 10),
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

  Widget _buildCivility() {
    return Theme(
      data: ThemeData(
        unselectedWidgetColor: AppColors.defaultColorMaterial,
        primarySwatch: AppColors.defaultColorMaterial,
      ),
      child: Row(
        children: [
          Text(
            "Civilité",
            style: AppStyles.textNormal,
          ),
          Row(
            children: [
              RadioButton(
                description: "",
                value: "M",
                groupValue: _singleValue,
                onChanged: (value) => setState(
                  () => _singleValue = value,
                ),
                textPosition: RadioButtonTextPosition.left,
              ),
              Text("M", style: AppStyles.textNormal),
            ],
          ),
          Row(
            children: [
              RadioButton(
                description: "",
                value: "Mme",
                groupValue: _singleValue,
                onChanged: (value) => setState(
                  () => _singleValue = value,
                ),
                textPosition: RadioButtonTextPosition.left,
              ),
              Text("Mme", style: AppStyles.textNormal),
            ],
          ),
        ],
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
          child: _loading
              ? Center(
                  child: CircularProgressIndicator(
                    color: AppColors.white,
                  ),
                )
              : Text(
                  "VALIDER LES MODIFICATIONS",
                  style: AppStyles.smallTitleWhite,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
        ),
      ),
      onPressed: () async {
        setState(() {
          _loading = true;
        });
        final formState = formKey.currentState;
        if (formState.validate()) {
          // then do something
          ResultMessageResponse result = await bloc.modifCoordClient(
              _singleValue,
              _firstNameController.text,
              _lastNameController.text,
              _phoneController.text,
              _emailController.text,
              bloc.interventionDetail.interventionDetail.clients.uuid);
          if (result.result == 'OK') {
            await bloc.getInterventionDetail(
                bloc.interventionDetail.interventionDetail.uuid);
            Modular.to.pop();
          } else {
            Fluttertoast.showToast(
                msg: "Erreur survenue",
                backgroundColor: AppColors.mdAlert,
                textColor: AppColors.white);
          }
        }
        setState(() {
          _loading = false;
        });
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
