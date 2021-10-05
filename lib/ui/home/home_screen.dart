import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:mdp/constants/app_colors.dart';
import 'package:mdp/constants/app_constants.dart';
import 'package:mdp/constants/app_images.dart';
import 'package:mdp/constants/routes.dart';
import 'package:mdp/constants/styles/app_styles.dart';
import 'package:mdp/widgets/bottom_navbar_widget.dart';
import 'package:mdp/widgets/gradients/md_gradient_light.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  // Pour savoir si on affiche le mois actuel ou précédent du CA
  bool affichageMoisActuel = true;

  @override
  Future<void> initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.white,
      //drawer: DrawerWidget(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            child: _buildContent(),
          ),
        ),
      ),
      //LoadingIndicator(loading: _bloc.loading),
      //NetworkErrorMessages(error: _bloc.error),
      bottomNavigationBar: const BottomNavbar(route: Routes.home),
    );
  }

  Widget _buildContent() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          height: 150,
          decoration: BoxDecoration(
            gradient: MdGradientLightt(),
          ),
          child: _buildTitle(),
        ),
        _buildBody(),
      ],
    );
  }

  Widget _buildTitle() {
    return Padding(
      padding: EdgeInsets.only(top: AppConstants.default_padding * 1.3),
      child: Container(
        height: double.infinity,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Flexible(
                flex: 1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Flexible(
                      child: Text(
                        "Bienvenue",
                        style: AppStyles.headerWhite,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    SizedBox(height: 2),
                    Flexible(
                        child: Text(
                      "Isabelle",
                      style: AppStyles.headerWhite,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    )),
                    SizedBox(height: 25),
                    Flexible(
                      child: GestureDetector(
                        onTap: () {
                          Modular.to.pushNamed(Routes.profil);
                        },
                        child: Text(
                          "Mon compte",
                          style: AppStyles.underlinedwhiteText,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                  ],
                )),
            Flexible(
                flex: 1,
                child: Container(
                  padding: EdgeInsets.only(left: 40),
                  alignment: Alignment.centerRight,
                  child: Image.asset(
                    AppImages.logo,
                    color: AppColors.white,
                  ),
                )),
          ],
        ),
      ),
    );
  }

  Widget _buildBody() {
    return Padding(
      padding: EdgeInsets.all(AppConstants.default_padding),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          _buildFinalisation(),
          SizedBox(height: 15),
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    _buildCommandes(),
                    SizedBox(height: 15),
                    _buildReclamations(),
                    SizedBox(height: 15),
                    _buildPaiements(),
                  ],
                ),
              ),
              SizedBox(width: 12),
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    _buildCA(),
                    SizedBox(height: 15),
                    _buildSatisfaction(),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFinalisation() {
    return Stack(
      children: [
        Container(
          height: 145,
          decoration: BoxDecoration(
            color: AppColors.md_primary_2,
            borderRadius:
                BorderRadius.all(Radius.circular(AppConstants.default_Radius)),
          ),
        ),
        Container(
          height: 145,
          width: double.infinity,
          child: Image.asset(AppImages.sky, fit: BoxFit.fitWidth),
        ),
        Container(
          height: 145,
          padding: EdgeInsets.only(left: 20),
          alignment: Alignment.centerLeft,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("85%", style: AppStyles.headerMdDarkBlue),
              Text("Taux de finalisation",
                  style: AppStyles.largeTextNormalDarkBlue),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildCommandes() {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.md_light_gray,
        borderRadius:
            BorderRadius.all(Radius.circular(AppConstants.default_Radius)),
        border: Border.all(color: AppColors.md_gray, width: 1),
      ),
      child: Column(
        children: [
          Text("45 commandes au total",
              maxLines: 5,
              overflow: TextOverflow.ellipsis,
              style: AppStyles.bodyBoldMdDarkBlue),
          SizedBox(height: 20),
          Container(
            width: double.infinity,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  flex: 7,
                  child: Container(
                    height: 130,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Flexible(
                          child: Text("35 commandes en cours",
                              maxLines: 5,
                              overflow: TextOverflow.ellipsis,
                              style: AppStyles.miniCap),
                        ),
                        SizedBox(height: 10),
                        Flexible(
                          child: Text("5 commandes annulées",
                              maxLines: 5,
                              overflow: TextOverflow.ellipsis,
                              style: AppStyles.miniCap),
                        ),
                        SizedBox(height: 10),
                        Flexible(
                          child: Text("10 commandes finalisées",
                              maxLines: 5,
                              overflow: TextOverflow.ellipsis,
                              style: AppStyles.miniCap),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Flexible(
                  flex: 3,
                  child: Container(
                    height: 110,
                    width: 60,
                    child: Column(
                      children: [
                        Flexible(
                          flex: 5,
                          child: Container(
                            decoration: BoxDecoration(
                              color: AppColors.md_primary,
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(7),
                                topLeft: Radius.circular(7),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 5),
                        Flexible(
                          flex: 2,
                          child: Container(
                            decoration: BoxDecoration(
                              color: AppColors.md_tertiary,
                            ),
                          ),
                        ),
                        SizedBox(height: 5),
                        Flexible(
                          flex: 4,
                          child: Container(
                            decoration: BoxDecoration(
                              color: AppColors.md_secondary,
                              borderRadius: BorderRadius.only(
                                bottomRight: Radius.circular(7),
                                bottomLeft: Radius.circular(7),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCA() {
    return GestureDetector(
      onTap: () {
        setState(() {
          affichageMoisActuel = !affichageMoisActuel;
        });
      },
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: AppColors.md_dark_blue,
          borderRadius:
              BorderRadius.all(Radius.circular(AppConstants.default_Radius)),
        ),
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 22),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Chiffres d'affaires", style: AppStyles.bodyBoldWhite),
            SizedBox(height: 8),
            affichageMoisActuel
                ? Row(
                    children: [
                      Icon(
                        Icons.arrow_left_outlined,
                        color: AppColors.white,
                        size: 33,
                      ),
                      Expanded(
                        child: Text("42K €",
                            style: AppStyles.bigHeaderWhite,
                            maxLines: 1,
                            textAlign: TextAlign.right),
                      ),
                    ],
                  )
                : Row(
                    children: [
                      Expanded(
                        child: Text("42K €", style: AppStyles.bigHeaderWhite),
                      ),
                      Icon(
                        Icons.arrow_right_outlined,
                        color: AppColors.white,
                        size: 33,
                      ),
                    ],
                  ),
            SizedBox(height: 8),
            Align(
              alignment: affichageMoisActuel
                  ? Alignment.centerRight
                  : Alignment.centerLeft,
              child: Text(
                  affichageMoisActuel
                      ? "sur le mois actuel"
                      : "sur le mois précédent",
                  style: AppStyles.bodyWhite),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildReclamations() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.md_light_gray,
        border: Border.all(color: AppColors.md_gray, width: 1),
        borderRadius:
            BorderRadius.all(Radius.circular(AppConstants.default_Radius)),
      ),
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 22),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Réclamations", style: AppStyles.bodyBoldMdDarkBlue),
          SizedBox(height: 8),
          Text("4", style: AppStyles.headerSecondary),
          SizedBox(height: 8),
          Text("en cours", style: AppStyles.bodyDefaultBlack),
        ],
      ),
    );
  }

  Widget _buildPaiements() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.md_light_gray,
        border: Border.all(color: AppColors.md_gray, width: 1),
        borderRadius:
            BorderRadius.all(Radius.circular(AppConstants.default_Radius)),
      ),
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 22),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Paiement en ligne", style: AppStyles.bodyBoldMdDarkBlue),
          SizedBox(height: 8),
          Text("89%", style: AppStyles.headerSecondary),
          SizedBox(height: 8),
          Text("ces 15 derniers jours", style: AppStyles.bodyDefaultBlack),
        ],
      ),
    );
  }

  Widget _buildSatisfaction() {
    final double itemStarSize = 18;
    final double itemPadding = 2.0;

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.md_light_gray,
        border: Border.all(color: AppColors.md_gray, width: 1),
        borderRadius:
            BorderRadius.all(Radius.circular(AppConstants.default_Radius)),
      ),
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 22),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Satisfaction globale", style: AppStyles.bodyBoldMdDarkBlue),
          SizedBox(height: 8),
          RatingBar(
            initialRating: 3.3,
            direction: Axis.horizontal,
            allowHalfRating: true,
            ignoreGestures: true,
            itemCount: 5,
            itemSize: itemStarSize,
            wrapAlignment: WrapAlignment.spaceEvenly,
            ratingWidget: RatingWidget(
              full: Icon(
                Icons.star_outlined,
                color: AppColors.md_dark_blue,
              ),
              half:
                  Icon(Icons.star_half_outlined, color: AppColors.md_dark_blue),
              empty: Icon(
                Icons.star_outlined,
                color: AppColors.emptyStar,
              ),
            ),
            itemPadding: EdgeInsets.symmetric(horizontal: itemPadding),
            onRatingUpdate: (rating) {
              print(rating);
            },
          ),
          SizedBox(height: 15),
          Text("Propreté", style: AppStyles.bodyDefaultBlack),
          SizedBox(height: 8),
          RatingBar(
            initialRating: 2.8,
            direction: Axis.horizontal,
            allowHalfRating: true,
            itemCount: 5,
            ignoreGestures: true,
            itemSize: itemStarSize,
            wrapAlignment: WrapAlignment.center,
            ratingWidget: RatingWidget(
              full: Icon(
                Icons.star_outlined,
                color: AppColors.md_secondary,
              ),
              half:
                  Icon(Icons.star_half_outlined, color: AppColors.md_secondary),
              empty: Icon(
                Icons.star_outlined,
                color: AppColors.emptyStar,
              ),
            ),
            itemPadding: EdgeInsets.symmetric(horizontal: itemPadding),
            onRatingUpdate: (rating) {
              print(rating);
            },
          ),
          SizedBox(height: 15),
          Text("Courtoise", style: AppStyles.bodyDefaultBlack),
          SizedBox(height: 8),
          RatingBar(
            initialRating: 1.8,
            direction: Axis.horizontal,
            allowHalfRating: true,
            itemCount: 5,
            itemSize: itemStarSize,
            ignoreGestures: true,
            wrapAlignment: WrapAlignment.center,
            ratingWidget: RatingWidget(
              full: Icon(
                Icons.star_outlined,
                color: AppColors.md_secondary,
              ),
              half:
                  Icon(Icons.star_half_outlined, color: AppColors.md_secondary),
              empty: Icon(
                Icons.star_outlined,
                color: AppColors.emptyStar,
              ),
            ),
            itemPadding: EdgeInsets.symmetric(horizontal: itemPadding),
            onRatingUpdate: (rating) {
              print(rating);
            },
          ),
          SizedBox(height: 15),
          Text("Ponctualité", style: AppStyles.bodyDefaultBlack),
          SizedBox(height: 8),
          RatingBar(
            initialRating: 1.3,
            direction: Axis.horizontal,
            allowHalfRating: true,
            itemCount: 5,
            itemSize: itemStarSize,
            ignoreGestures: true,
            wrapAlignment: WrapAlignment.center,
            ratingWidget: RatingWidget(
              full: Icon(
                Icons.star_outlined,
                color: AppColors.md_secondary,
              ),
              half:
                  Icon(Icons.star_half_outlined, color: AppColors.md_secondary),
              empty: Icon(
                Icons.star_outlined,
                color: AppColors.emptyStar,
              ),
            ),
            itemPadding: EdgeInsets.symmetric(horizontal: itemPadding),
            onRatingUpdate: (rating) {
              print(rating);
            },
          ),
          SizedBox(height: 15),
          Text("Qualité du travail", style: AppStyles.bodyDefaultBlack),
          SizedBox(height: 8),
          RatingBar(
            initialRating: 4.8,
            direction: Axis.horizontal,
            allowHalfRating: true,
            itemCount: 5,
            itemSize: itemStarSize,
            ignoreGestures: true,
            wrapAlignment: WrapAlignment.center,
            ratingWidget: RatingWidget(
              full: Icon(
                Icons.star_outlined,
                color: AppColors.md_secondary,
              ),
              half:
                  Icon(Icons.star_half_outlined, color: AppColors.md_secondary),
              empty: Icon(
                Icons.star_outlined,
                color: AppColors.emptyStar,
              ),
            ),
            itemPadding: EdgeInsets.symmetric(horizontal: itemPadding),
            onRatingUpdate: (rating) {
              print(rating);
            },
          ),
        ],
      ),
    );
  }
}
