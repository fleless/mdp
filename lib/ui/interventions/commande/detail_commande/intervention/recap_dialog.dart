import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mdp/constants/app_colors.dart';
import 'package:mdp/constants/app_constants.dart';
import 'package:mdp/constants/routes.dart';
import 'package:mdp/constants/styles/app_styles.dart';

class RecapDialog extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _RecapDialogState();
}

class _RecapDialogState extends State<RecapDialog> {
  @override
  Widget build(BuildContext context) {
    return Material(
        child: Container(
          color: AppColors.white,
      height: MediaQuery.of(context).size.height * 0.88,
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        primary: true,
        child: Container(
          color: AppColors.white,
          child: Container(
            width: double.infinity,
            child: _buildContent(),
          ),
        ),
      ),
    ));
  }

  Widget _buildContent() {
    return Column(
      children: [
        _buildHeader(),
        _buildBloc(),
        _buildPhotos(),
        _buildFourchetteTarifiaire()
      ],
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      decoration: BoxDecoration(
          color: AppColors.closeDialogColor),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("Récapitulatif", style: AppStyles.subTitleWhite),
          IconButton(
            onPressed: () {
              Modular.to.pop();
            },
            icon: FaIcon(FontAwesomeIcons.chevronDown,
                color: AppColors.white, size: 13),
          ),
        ],
      ),
    );
  }

  Widget _buildBloc() {
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: AppConstants.default_padding,
          vertical: AppConstants.default_padding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RichText(
            textAlign: TextAlign.left,
            maxLines: 10,
            overflow: TextOverflow.clip,
            text: TextSpan(
              children: [
                TextSpan(text: "Partenaire : ", style: AppStyles.textNormal),
                TextSpan(
                    text: "MesDépanneurs.fr", style: AppStyles.textNormalBold),
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
                    text: "N° de référence : ", style: AppStyles.textNormal),
                TextSpan(text: "FR - 6DH3", style: AppStyles.textNormalBold),
              ],
            ),
          ),
          SizedBox(height: 30),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(15),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(15),
                topLeft: Radius.circular(15),
              ),
              color: AppColors.closeDialogColor,
            ),
            child: Text(
                "SERR37 - Fourniture et pose d’une serrure 3-points standard",
                style: AppStyles.smallTitleWhite,
                textAlign: TextAlign.center,
                maxLines: 5,
                overflow: TextOverflow.ellipsis),
          ),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(15),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(15),
                bottomRight: Radius.circular(15),
              ),
              color: AppColors.md_gray,
            ),
            child: Text("Franchise de 100€ à appliquer.",
                style: AppStyles.textNormal,
                textAlign: TextAlign.left,
                maxLines: 5,
                overflow: TextOverflow.ellipsis),
          ),
        ],
      ),
    );
  }

  Widget _buildPhotos() {
    return Padding(
      padding: EdgeInsets.all(AppConstants.default_padding),
      child: Container(
        width: double.infinity,
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text("Photos du client",
              style: AppStyles.subTitleBlack, overflow: TextOverflow.ellipsis),
          SizedBox(height: 10),
          Container(
            height: 250,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 5,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () => {
                      Modular.to.pushNamed(Routes.photoView, arguments: {
                        'image':
                            "https://www.travaux.com/images/cms/medium/5d09d48b-2e3d-4106-8b80-11c2cc260bec.jpg"
                      })
                    },
                    child: Card(
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      elevation: 0,
                      child: Container(
                        width: 180,
                        child: Hero(
                          tag: AppConstants.IMAGE_VIEWER_TAG,
                          child: Image.network(
                              "https://www.travaux.com/images/cms/medium/5d09d48b-2e3d-4106-8b80-11c2cc260bec.jpg",
                              fit: BoxFit.fill),
                        ),
                      ),
                    ),
                  );
                }),
          )
        ]),
      ),
    );
  }

  Widget _buildFourchetteTarifiaire() {
    return Padding(
      padding: EdgeInsets.all(AppConstants.default_padding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Fourchette tarifaire :",
            style: AppStyles.subTitleBlack,
            textAlign: TextAlign.left,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          Container(
            width: double.infinity,
            height: 50,
            child: ListTile(
              minLeadingWidth: 15,
              leading: Container(
                height: double.infinity,
                width: 30,
                child: Center(
                  child: FaIcon(
                    FontAwesomeIcons.euroSign,
                    color: AppColors.default_black,
                    size: 16,
                  ),
                ),
              ),
              title: Text("Min : 600 € - Max : 1200 €",
                  style: AppStyles.body,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis),
              subtitle: Text("Montant pré-bloqué 1 200 €",
                  style: AppStyles.smallGray,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis),
            ),
          ),
        ],
      ),
    );
  }
}
