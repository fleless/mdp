import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mdp/constants/app_colors.dart';
import 'package:mdp/constants/app_constants.dart';
import 'package:mdp/constants/app_images.dart';
import 'package:mdp/constants/routes.dart';
import 'package:mdp/constants/styles/app_styles.dart';
import 'package:mdp/models/responses/login_response.dart';
import 'package:mdp/ui/home/home_screen.dart';
import 'package:mdp/widgets/gradients/md_gradient_light.dart';
import 'package:splashscreen/splashscreen.dart';

import 'login_bloc.dart';

class LoginScreenWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _LoginScreenWidgetState();
}

class _LoginScreenWidgetState extends State<LoginScreenWidget> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  GlobalKey<FormState> formKey = new GlobalKey();
  TextEditingController _userNameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  final bloc = Modular.get<LoginBloc>();
  bool loading = false;

  @override
  void initState() {
    _userNameController.text = "mobile-app";
    _passwordController.text = "jSth&n5*tMRu";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.appBackground,
      //drawer: DrawerWidget(),
      body: SafeArea(
        child: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(gradient: MdGradientLight()),
          height: double.infinity,
          child: Padding(
            padding:
                EdgeInsets.symmetric(horizontal: AppConstants.default_padding),
            child: Center(
              child: Container(
                alignment: Alignment.center,
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 50),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.all(
                      Radius.circular(AppConstants.default_Radius)),
                ),
                height: MediaQuery.of(context).size.height * 0.6,
                width: double.infinity,
                child: SingleChildScrollView(
                  child: _buildContent(),
                ),
              ),
            ),
          ),
        ),
      ), //LoadingIndicator(loading: _bloc.loading),
      //NetworkErrorMessages(error: _bloc.error),
    );
  }

  Widget _buildContent() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.asset(AppImages.logo, height: 50),
        SizedBox(height: 40),
        Text("Connexion au compte", style: AppStyles.header1MdDarkBlue),
        SizedBox(height: 25),
        Form(
          key: formKey,
          child: Column(
            children: [
              _buildUsernameTextField(),
              SizedBox(height: 25),
              _buildPasswordTextField(),
              SizedBox(height: 25),
              _buildConfirmButton()
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildUsernameTextField() {
    return TextFormField(
      controller: _userNameController,
      obscureText: false,
      cursorColor: AppColors.default_black,
      keyboardType: TextInputType.text,
      decoration: const InputDecoration(
        filled: true,
        fillColor: AppColors.md_light_gray,
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
        hintText: "Login",
        hintStyle: AppStyles.textNormalPlaceholder,
      ),
      style: AppStyles.textNormal,
      validator: (String value) =>
          (value.isEmpty) ? 'ce champ ne peut pas être vide' : null,
    );
  }

  Widget _buildPasswordTextField() {
    return TextFormField(
      controller: _passwordController,
      obscureText: true,
      cursorColor: AppColors.default_black,
      keyboardType: TextInputType.text,
      decoration: const InputDecoration(
        filled: true,
        fillColor: AppColors.md_light_gray,
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
        hintText: "Mot de passe",
        hintStyle: AppStyles.textNormalPlaceholder,
      ),
      style: AppStyles.textNormal,
      validator: (String value) =>
          (value.isEmpty) ? 'ce champ ne peut pas être vide' : null,
    );
  }

  Widget _buildConfirmButton() {
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
              ? Padding(
                  padding: EdgeInsets.all(5),
                  child: CircularProgressIndicator(
                    color: AppColors.md_text_white,
                    strokeWidth: 2,
                  ),
                )
              : Text(
                  "SE CONNECTER",
                  style: AppStyles.buttonTextWhite,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
        ),
      ),
      onPressed: () async {
        LoginResponse response;
        if (!loading) {
          final formState = formKey.currentState;
          if (formState.validate()) {
            setState(() {
              loading = true;
            });
            response = await bloc.getToken(
                _userNameController.text, _passwordController.text);
            setState(() {
              loading = false;
            });
            if ((response.token != null) && (response.token != "")) {
              Modular.to.pushNamedAndRemoveUntil(
                  Routes.home, (Route<dynamic> route) => false);
            } else {
              Fluttertoast.showToast(
                  msg: "Utilisateur introuvable",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.CENTER,
                  timeInSecForIosWeb: 1,
                  backgroundColor: AppColors.mdAlert,
                  textColor: Colors.white,
                  fontSize: 16.0);
            }
          }
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
