import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mdp/constants/app_colors.dart';
import 'package:mdp/constants/app_constants.dart';
import 'package:mdp/constants/app_images.dart';
import 'package:mdp/constants/routes.dart';
import 'package:mdp/constants/styles/app_styles.dart';
import 'package:mdp/models/responses/login_response.dart';
import 'package:mdp/ui/home/home_screen.dart';
import 'package:mdp/widgets/gradients/md_gradient_light.dart';
import 'package:splashscreen/splashscreen.dart';


class ProfilScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ProfilScreenState();
}

class _ProfilScreenState extends State<ProfilScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  GlobalKey<FormState> formKey = new GlobalKey();

  @override
  void initState() {
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
            ],
          ),
        ),
      ],
    );
  }

}
