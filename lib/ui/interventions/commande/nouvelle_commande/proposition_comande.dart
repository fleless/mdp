import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mdp/constants/app_colors.dart';
import 'package:mdp/constants/app_constants.dart';
import 'package:mdp/constants/routes.dart';
import 'package:mdp/constants/styles/app_styles.dart';
import 'package:mdp/ui/interventions/commande/nouvelle_commande/motif_refus.dart';
import 'package:mdp/widgets/gradients/md_gradient.dart';
import 'package:mdp/widgets/gradients/md_gradient_light.dart';
import 'package:map_launcher/map_launcher.dart';

class PropositionCommandeWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _PropositionCommandeWidgetState();
}

class _PropositionCommandeWidgetState extends State<PropositionCommandeWidget> {
  @override
  Widget build(BuildContext context) {
    return Material(
        child: Container(
      height: MediaQuery.of(context).size.height * 0.92,
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
        _buildTitle(),
        _buildBloc(),
        SizedBox(height: 15),
        _buildDateSouhait(),
        SizedBox(height: 15),
        _buildComment(),
        SizedBox(height: 15),
        _buildPhotos(),
        SizedBox(height: 15),
        _buildAcceptButton(),
        _buildRejectButton(),
        SizedBox(height: 30),
      ],
    );
  }

  Widget _buildTitle() {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: AppConstants.default_padding,
          vertical: AppConstants.default_padding),
      child: Material(
        color: AppColors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Nouvelle proposition",
              style: AppStyles.header1,
              textAlign: TextAlign.left,
              overflow: TextOverflow.clip,
              maxLines: 2,
            ),
            InkWell(
              onTap: () {
                Modular.to.pop();
              },
              child: Icon(
                Icons.close_outlined,
                size: 25,
                color: AppColors.closeDialogColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBloc() {
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: AppConstants.default_padding,
          vertical: AppConstants.default_padding),
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: MdGradientLight(),
        borderRadius: BorderRadius.only(
          bottomRight: Radius.circular(20),
          bottomLeft: Radius.circular(20),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Partenaire",
            style: AppStyles.subTitleWhite,
            textAlign: TextAlign.left,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(height: 10),
          Container(
            height: 35,
            width: double.infinity,
            decoration: BoxDecoration(
              color: AppColors.md_primary_3,
              borderRadius: BorderRadius.all(
                Radius.circular(8),
              ),
            ),
            child: Center(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                width: double.infinity,
                child: Text(
                  "MesDépanneurs.fr",
                  style: AppStyles.boldText,
                ),
              ),
            ),
          ),
          SizedBox(height: 15),
          Text(
            "Référence",
            style: AppStyles.subTitleWhite,
            textAlign: TextAlign.left,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(height: 10),
          Container(
            height: 35,
            width: double.infinity,
            decoration: BoxDecoration(
              color: AppColors.md_primary_3,
              borderRadius: BorderRadius.all(
                Radius.circular(8),
              ),
            ),
            child: Center(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                width: double.infinity,
                child: Text(
                  "FR - 6DH3",
                  style: AppStyles.boldText,
                ),
              ),
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
          SizedBox(height: 30),
          Text(
            "Fourchette tarifaire :",
            style: AppStyles.subTitleWhite,
            textAlign: TextAlign.left,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(height: 0),
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
                    color: AppColors.md_text_white,
                    size: 16,
                  ),
                ),
              ),
              title: Text("Min : 600 € - Max : 1200 €",
                  style: AppStyles.bodyWhite,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis),
              subtitle: Text("Montant pré-bloqué 1 200 €",
                  style: AppStyles.smallBodyWhite,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis),
            ),
          ),
          SizedBox(height: 25),
          Text(
            "Adresse d’intervention :",
            style: AppStyles.subTitleWhite,
            textAlign: TextAlign.left,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(height: 0),
          GestureDetector(
            onTap: () async {
              final availableMaps = await MapLauncher.installedMaps;
              print(
                  availableMaps); // [AvailableMap { mapName: Google Maps, mapType: google }, ...]

              await availableMaps.first.showMarker(
                coords: Coords(37.759392, -122.5107336),
                title: "Ocean Beach",
              );
            },
            child: Container(
              width: double.infinity,
              height: 50,
              child: ListTile(
                minLeadingWidth: 15,
                leading: Container(
                  height: double.infinity,
                  width: 30,
                  child: Center(
                    child: FaIcon(
                      FontAwesomeIcons.mapMarkerAlt,
                      color: AppColors.md_text_white,
                      size: 16,
                    ),
                  ),
                ),
                title: Text("Rue André Chemin",
                    style: AppStyles.bodyWhite,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis),
                subtitle: Text("78000 Versailles",
                    style: AppStyles.bodyWhite,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis),
              ),
            ),
          ),
          SizedBox(height: 15),
        ],
      ),
    );
  }

  Widget _buildDateSouhait() {
    return Padding(
      padding: EdgeInsets.all(AppConstants.default_padding),
      child: Column(
        children: [
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
            child: Text("Date souhaitée du rendez-vous",
                style: AppStyles.smallTitleWhite,
                textAlign: TextAlign.center,
                maxLines: 5,
                overflow: TextOverflow.ellipsis),
          ),
          Container(
            width: double.infinity,
            alignment: Alignment.center,
            padding: EdgeInsets.all(15),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(15),
                bottomRight: Radius.circular(15),
              ),
              color: AppColors.md_gray,
            ),
            child: Text("Mardi 30 mars - 17h00",
                style: AppStyles.textNormalBold,
                textAlign: TextAlign.left,
                maxLines: 5,
                overflow: TextOverflow.ellipsis),
          ),
        ],
      ),
    );
  }

  Widget _buildComment() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: AppConstants.default_padding),
      child: Container(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Commentaire du client",
                style: AppStyles.subTitleBlack,
                overflow: TextOverflow.ellipsis),
            SizedBox(height: 10),
            Text(
                "Amet minim mollit non deserunt ullamco est sit aliqua dolor do amet sint. Velit officia consequat duis enim velit mollit. Exercitation veniam consequat sunt nostrud amet.",
                style: AppStyles.textNormal,
                maxLines: 100),
          ],
        ),
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

  Widget _buildAcceptButton() {
    return Padding(
      padding: EdgeInsets.all(AppConstants.default_padding),
      child: ElevatedButton(
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
              "J'ACCEPTE L'INTERVENTION",
              style: AppStyles.smallTitleWhite,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
        onPressed: () {
          Modular.to.popAndPushNamed(Routes.detailCommande);
        },
        style: ElevatedButton.styleFrom(
            elevation: 5,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            onPrimary: AppColors.white,
            primary: Colors.transparent,
            padding: EdgeInsets.zero,
            textStyle: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
      ),
    );
  }

  Widget _buildRejectButton() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: AppConstants.default_padding),
      child: ElevatedButton(
        child: Ink(
          decoration: BoxDecoration(
            color: AppColors.white,
            border: Border.all(color: AppColors.mdAlert),
            borderRadius: BorderRadius.all(
              Radius.circular(12),
            ),
          ),
          child: Container(
            alignment: Alignment.center,
            width: double.infinity,
            height: 55,
            child: Text(
              "JE REFUSE L'INTERVENTION",
              style: AppStyles.alertNormalText,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
        onPressed: () {
          showDialog(
              context: context,
              builder: (context) {
                return StatefulBuilder(
                    builder: (BuildContext context, StateSetter setState) {
                  return Dialog(
                    backgroundColor: AppColors.md_light_gray,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: MotifRefusWidget(),
                  );
                });
              });
        },
        style: ElevatedButton.styleFrom(
            elevation: 5,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            onPrimary: AppColors.mdAlert.withOpacity(0.1),
            primary: Colors.transparent,
            padding: EdgeInsets.zero,
            textStyle: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
      ),
    );
  }
}
