import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mdp/constants/app_colors.dart';
import 'package:mdp/constants/app_constants.dart';
import 'package:mdp/constants/app_images.dart';
import 'package:mdp/constants/routes.dart';
import 'package:mdp/constants/styles/app_styles.dart';
import 'package:mdp/models/responses/get_account_response.dart';
import 'package:mdp/models/responses/login_response.dart';
import 'package:mdp/ui/home/home_screen.dart';
import 'package:mdp/utils/shared_preferences.dart';
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
  final sharedPref = Modular.get<SharedPref>();
  bool loading = false;

  @override
  void initState() {
    // find if there is a user connected before and reconnect him
    _loadDatas();
    super.initState();
  }

  _loadDatas() async {
    var username = await sharedPref.read(AppConstants.USERNAME_KEY);
    var password = await sharedPref.read(AppConstants.PASSWORD_KEY);
    if ((username != null) && (password != null)) {
      _userNameController.text = username;
      _passwordController.text = password;
      _goConnect();
    }
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
      textInputAction: TextInputAction.next,
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
      textInputAction: TextInputAction.next,
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
      onPressed: () {
        if (!loading) {
          final formState = formKey.currentState;
          if (formState.validate()) {
            _goConnect();
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

  _goConnect() async {
    LoginResponse response;
    setState(() {
      loading = true;
    });
    response =
        await bloc.getToken(_userNameController.text, _passwordController.text);
    setState(() {
      loading = false;
    });
    if ((response.token != null) && (response.token != "")) {
      GetAccountResponse resp = await bloc.getAccount(_userNameController.text);
      if (resp != null) {
        bloc.registerDevice(resp.profile.subcontractor.uuid.toString(),
            "deviceToken", 323, "personData");
        sharedPref.save(AppConstants.SUBCONTRACTOR_UUID_KEY,
            resp.profile.subcontractor.uuid.toString());
        sharedPref.save(AppConstants.SUBCONTRACTOR_ID_KEY,
            resp.profile.subcontractor.id.toString());
        sharedPref.save(AppConstants.USERNAME_KEY, _userNameController.text);
        sharedPref.save(AppConstants.PASSWORD_KEY, _passwordController.text);
        Modular.to.pushNamedAndRemoveUntil(
            Routes.home, (Route<dynamic> route) => false);
      }
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
