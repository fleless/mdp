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
import 'package:mdp/widgets/bottom_navbar_widget.dart';
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
      backgroundColor: AppColors.white,
      //drawer: DrawerWidget(),
      body: SafeArea(
          child: Container(
        child: Column(
          children: [
            Container(
              height: 220,
              decoration: BoxDecoration(
                gradient: MdGradientLightt(),
              ),
              child: _buildTitle(),
            ),
            _buildContent(),
            Expanded(
              child: _buildButtons(),
            ),
            SizedBox(height: 15),
          ],
        ),
      )), //LoadingIndicator(loading: _bloc.loading),
      //NetworkErrorMessages(error: _bloc.error),
      bottomNavigationBar: const BottomNavbar(route: Routes.home),
    );
  }

  Widget _buildTitle() {
    return Padding(
      padding: EdgeInsets.only(
          left: AppConstants.default_padding,
          right: AppConstants.default_padding,
          bottom: AppConstants.default_padding,
          top: AppConstants.default_padding * 2),
      child: Container(
          alignment: Alignment.centerLeft,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Flexible(
                child: Text(
                  "Bienvenue",
                  style: AppStyles.headerWhite,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              SizedBox(height: 10),
              Flexible(
                  child: Text(
                "Isabelle",
                style: AppStyles.headerWhite,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              )),
              SizedBox(height: 33),
              RichText(
                textAlign: TextAlign.left,
                maxLines: 10,
                overflow: TextOverflow.clip,
                text: TextSpan(
                  children: [
                    TextSpan(text: "Alias : ", style: AppStyles.bodyBoldWhite),
                    TextSpan(text: "IsaSARL", style: AppStyles.bodyWhite),
                  ],
                ),
              ),
              SizedBox(height: 12),
              RichText(
                textAlign: TextAlign.left,
                maxLines: 10,
                overflow: TextOverflow.clip,
                text: TextSpan(
                  children: [
                    TextSpan(text: "ID : ", style: AppStyles.bodyBoldWhite),
                    TextSpan(text: "Isabelle", style: AppStyles.bodyWhite),
                  ],
                ),
              ),
            ],
          )),
    );
  }

  Widget _buildContent() {
    return Container(
      width: double.infinity,
      color: AppColors.md_light_gray,
      padding: EdgeInsets.all(AppConstants.default_padding),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            "Votre chargée de réseau",
            style: AppStyles.largeTextBoldDarkBlue,
            overflow: TextOverflow.ellipsis,
            maxLines: 5,
          ),
          SizedBox(height: 30),
          RichText(
            textAlign: TextAlign.left,
            maxLines: 10,
            overflow: TextOverflow.clip,
            text: TextSpan(
              children: [
                TextSpan(text: "Contact : ", style: AppStyles.bigSecondaryText),
                TextSpan(
                    text: "Nathanaelle", style: AppStyles.bodyDefaultBlack),
              ],
            ),
          ),
          SizedBox(height: 10),
          RichText(
            textAlign: TextAlign.left,
            maxLines: 10,
            overflow: TextOverflow.clip,
            text: TextSpan(
              children: [
                TextSpan(text: "Mail : ", style: AppStyles.bigSecondaryText),
                TextSpan(
                    text: "Nath@mesdepanneurs.fr",
                    style: AppStyles.bodyDefaultBlack),
              ],
            ),
          ),
          SizedBox(height: 10),
          RichText(
            textAlign: TextAlign.left,
            maxLines: 10,
            overflow: TextOverflow.clip,
            text: TextSpan(
              children: [
                TextSpan(
                    text: "Téléphone : ", style: AppStyles.bigSecondaryText),
                TextSpan(text: "0746680640", style: AppStyles.bodyDefaultBlack),
              ],
            ),
          ),
          SizedBox(height: 15),
        ],
      ),
    );
  }

  Widget _buildButtons() {
    return Container(
      child: Padding(
        padding: EdgeInsets.all(AppConstants.default_padding),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ElevatedButton(
              child: Ink(
                decoration: BoxDecoration(
                  color: AppColors.md_tertiary,
                  borderRadius: BorderRadius.all(
                    Radius.circular(12),
                  ),
                ),
                child: Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.symmetric(vertical: 20, horizontal: 50),
                  width: double.infinity,
                  child: Text(
                      "PLUS DE FONCTIONNALITÉS SUR ESPACE PRO.MESDÉPANNEURS.FR",
                    textAlign: TextAlign.center,
                    style: AppStyles.buttonTextWhite,
                    maxLines: 5,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  onPrimary: AppColors.md_dark_blue.withOpacity(0.1),
                  primary: Colors.transparent,
                  padding: EdgeInsets.zero,
                  textStyle:
                      TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
            ),
            ElevatedButton(
              child: Ink(
                decoration: BoxDecoration(
                  color: AppColors.white,
                  border: Border.all(color: AppColors.md_dark_blue),
                  borderRadius: BorderRadius.all(
                    Radius.circular(12),
                  ),
                ),
                child: Container(
                  alignment: Alignment.center,
                  width: double.infinity,
                  height: 50,
                  child: Text(
                    "SE DÉCONNECTER",
                    style: AppStyles.buttonTextDarkBlue,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  onPrimary: AppColors.md_dark_blue.withOpacity(0.1),
                  primary: Colors.transparent,
                  padding: EdgeInsets.zero,
                  textStyle:
                      TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
            ),
          ],
        ),
      ),
    );
  }
}
