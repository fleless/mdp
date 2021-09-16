import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mdp/constants/app_colors.dart';
import 'package:mdp/constants/styles/app_styles.dart';
import 'package:mdp/models/responses/add_adresse_facturation_response.dart';
import 'package:mdp/models/responses/adressResponse.dart';

import '../../../interventions_bloc.dart';

class ModifierAdresseFacturationWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() =>
      _ModifierAdresseFacturationWidgetState();
}

class _ModifierAdresseFacturationWidgetState
    extends State<ModifierAdresseFacturationWidget> {
  GlobalKey<FormState> formKey = new GlobalKey();
  TextEditingController _firstNameController = TextEditingController();
  TextEditingController _lastNameController = TextEditingController();
  TextEditingController _adressController = TextEditingController();
  TextEditingController _complementAdresseController = TextEditingController();
  TextEditingController _zipController = TextEditingController();
  TextEditingController _streetNumberController = TextEditingController();
  TextEditingController _communityController = TextEditingController();
  final bloc = Modular.get<InterventionsBloc>();
  bool loading = false;
  List<AdressResponse> listeCommunites = <AdressResponse>[];

  @override
  void initState() {
    bloc.interventionDetail.interventionDetail.invoicingAddress != null
        ? _initValues()
        : null;
    super.initState();
  }

  _initValues() async {
    _firstNameController.text = bloc.interventionDetail.interventionDetail
            .invoicingAddress.addressFirstname ??
        "";
    _lastNameController.text = bloc.interventionDetail.interventionDetail
            .invoicingAddress.addressLastname ??
        "";
    _adressController.text = (bloc.interventionDetail.interventionDetail
            .invoicingAddress.streetName ??
        "");
    _streetNumberController.text = bloc.interventionDetail.interventionDetail
            .invoicingAddress.streetNumber ??
        "";
    _complementAdresseController.text = bloc.interventionDetail
            .interventionDetail.invoicingAddress.streetNumber ??
        "";
    _zipController.text = (bloc.interventionDetail.interventionDetail
            .invoicingAddress.city.postcode ??
        "");
    _communityController.text =
        bloc.interventionDetail.interventionDetail.invoicingAddress.city.name ??
            "";
    List<AdressResponse> resp = await bloc.getCommunity(_zipController.text);
    setState(() {
      listeCommunites.addAll(resp);
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
              _buildStreetNumber(),
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

  Widget _buildStreetNumber() {
    return TextFormField(
      controller: _streetNumberController,
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
        hintText: "Numéro de l'avenue",
        hintStyle: AppStyles.textNormalPlaceholder,
      ),
      style: AppStyles.textNormal,
      validator: (String value) => (value.isEmpty)
          ? 'ce champ ne peut pas être vide'
          : (value.length >= 4)
              ? 'numéro avenue invalide'
              : null,
    );
  }

  Widget _buildZip() {
    return TextFormField(
      controller: _zipController,
      obscureText: false,
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter.allow(RegExp(r'(^\d+)')),
      ],
      cursorColor: AppColors.default_black,
      onChanged: (value) async {
        List<AdressResponse> resp = await bloc.getCommunity(value);
        setState(() {
          _communityController.text = "";
          listeCommunites = resp;
        });
        if ((resp == null) || (resp.length < 1)) {
          //print("community not found");
        } else {
          //print("community is " + resp[0].nom);
        }
      },
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
          : ((value.length != 5) || (listeCommunites.length == 0))
              ? 'code postale invalide'
              : null,
    );
  }

  List<String> _getCommunities() {
    List<String> lista = <String>[];
    listeCommunites.forEach((element) {
      lista.add(element.nom);
    });
    return lista;
  }

  Widget _buildCommunity() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 0),
      child: Container(
        height: 45,
        child: Theme(
          // Create a unique theme with "ThemeData"
          data: ThemeData(
            primarySwatch: AppColors.defaultColorMaterial,
          ),
          child: DropdownSearch<String>(
              selectedItem: _communityController.text,
              searchBoxController: _communityController,
              searchBoxDecoration: null,
              dropdownSearchDecoration: null,
              mode: Mode.MENU,
              showSelectedItem: true,
              popupSafeArea: PopupSafeArea(top: false),
              popupBackgroundColor: AppColors.white,
              items: listeCommunites.map((e) => e.nom).toList(),
              label: "Ville",
              hint: "Sélectionner une communité",
              onChanged: (value) {
                setState(() {
                  _communityController.text = value;
                });
              }),
        ),
      ),
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
          child: loading
              ? Center(
                  child: CircularProgressIndicator(color: AppColors.white),
                )
              : Text(
                  "VALIDER LES MODIFICATIONS",
                  style: AppStyles.smallTitleWhite,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
        ),
      ),
      onPressed: () {
        loading ? null : _goAction();
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

  _goAction() {
    final formState = formKey.currentState;
    if ((formState.validate()) && (_communityController.text != "")) {
      // then do something
      if ((bloc.interventionDetail.interventionDetail.invoicingAddress ==
              null) ||
          (bloc.interventionDetail.interventionDetail.invoicingAddress.id ==
              null)) {
        _ajouterAdresseFacturation();
      } else {
        _modifierAdresseFacturation();
      }
    }
  }

  _ajouterAdresseFacturation() async {
    setState(() {
      loading = true;
    });
    AddAdressFacturationResponse resp = await bloc.addAddressFacturation(
        bloc.interventionDetail.interventionDetail.uuid,
        _firstNameController.text,
        _lastNameController.text,
        _streetNumberController.text,
        _adressController.text,
        _complementAdresseController.text,
        _communityController.text,
        _zipController.text);
    if (resp.result == 'OK') {
      await bloc.getInterventionDetail(
          bloc.interventionDetail.interventionDetail.uuid);
      Modular.to.pop();
    } else {
      Fluttertoast.showToast(
          msg: "Erreur survenue",
          backgroundColor: AppColors.mdAlert,
          textColor: AppColors.white);
    }
    setState(() {
      loading = false;
    });
  }

  _modifierAdresseFacturation() async {
    setState(() {
      loading = true;
    });
    AddAdressFacturationResponse resp = await bloc.modifierAddressFacturation(
        bloc.interventionDetail.interventionDetail.invoicingAddress.uuid,
        _firstNameController.text,
        _lastNameController.text,
        _streetNumberController.text,
        _adressController.text,
        _complementAdresseController.text,
        _communityController.text,
        _zipController.text);
    if (resp.result == 'OK') {
      await bloc.getInterventionDetail(
          bloc.interventionDetail.interventionDetail.uuid);
      Modular.to.pop();
    } else {
      Fluttertoast.showToast(
          msg: "Erreur survenue",
          backgroundColor: AppColors.mdAlert,
          textColor: AppColors.white);
    }
    setState(() {
      loading = false;
    });
  }
}
