import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:map_launcher/map_launcher.dart';
import 'package:mdp/constants/app_colors.dart';
import 'package:mdp/constants/styles/app_styles.dart';
import 'package:mdp/ui/interventions/commande/detail_commande/client/modifier_adresse_facturation_widget.dart';
import 'package:mdp/ui/interventions/commande/detail_commande/client/modifier_coordonnees_widget.dart';
import 'package:mdp/utils/user_location.dart';
import 'package:mdp/widgets/gradients/md_gradient_green.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../interventions_bloc.dart';

class ClientWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ClientWidgetState();
}

class _ClientWidgetState extends State<ClientWidget> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  int indexTab = 0;
  final userLocation = Modular.get<UserLocation>();
  Position _userPosition;
  final bloc = Modular.get<InterventionsBloc>();

  @override
  void initState() {
    _getUserLocation();
    bloc.changesNotifier.listen((value) {
      setState(() {});
    });
    super.initState();
  }

  _getUserLocation() async {
    Position _position;
    _position = await userLocation.getUserCoordiantes();
    if (mounted) {
      setState(() {
        _userPosition = _position;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.md_light_gray,
      body: SafeArea(
        child: Container(
          height: double.infinity,
          child: _buildContent(),
        ),
      ),
    );
  }

  Widget _buildContent() {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildAdresseIntervention(),
          _buildCoordonnees(),
          _buildAdresseFacturation(),
          _buildCommentaires()
        ],
      ),
    );
  }

  Widget _buildCoordonnees() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
      color: AppColors.md_gray,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Coordonnées :",
            style: AppStyles.header2,
          ),
          SizedBox(height: 15),
          Padding(
            padding: EdgeInsets.only(left: 30, bottom: 5),
            child: Text(
                bloc.interventionDetail.interventionDetail.clients.firstname +
                    " " +
                    bloc.interventionDetail.interventionDetail.clients.lastname,
                style: AppStyles.body,
                overflow: TextOverflow.ellipsis,
                maxLines: 2),
          ),
          Padding(
            padding: EdgeInsets.only(left: 30, bottom: 5),
            child: Text(
                bloc.interventionDetail.interventionDetail.clients.commchannels
                    .firstWhere((element) =>
                        (element.preferred) && (element.type.name == "Phone"))
                    .name,
                style: AppStyles.body,
                overflow: TextOverflow.ellipsis,
                maxLines: 2),
          ),
          Padding(
            padding: EdgeInsets.only(left: 30, bottom: 25),
            child: Text(
                bloc.interventionDetail.interventionDetail.clients.commchannels
                    .firstWhere((element) =>
                        (element.preferred) && (element.type.name == "Email"))
                    .name,
                style: AppStyles.body,
                overflow: TextOverflow.ellipsis,
                maxLines: 2),
          ),
          GestureDetector(
            onTap: () {
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
                        child: ModifierCoordonneesWidget(),
                      );
                    });
                  });
            },
            child: Center(
              child: Text(
                "MODIFIER LES COORDONNÉES",
                style: AppStyles.underlinedTertiaryButtonText,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAdresseFacturation() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
      color: AppColors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Adresse de facturation :",
            style: AppStyles.header2,
          ),
          SizedBox(height: 15),
          Padding(
            padding: EdgeInsets.only(left: 30, bottom: 5),
            child: Text(
                bloc.interventionDetail.interventionDetail.clients.firstname +
                    " " +
                    bloc.interventionDetail.interventionDetail.clients.lastname,
                style: AppStyles.body,
                overflow: TextOverflow.ellipsis,
                maxLines: 2),
          ),
          Padding(
              padding: EdgeInsets.only(left: 30, bottom: 5),
              child: Text(
                  bloc.interventionDetail.interventionDetail.invoicingAddress !=
                          null
                      ? (bloc.interventionDetail.interventionDetail
                                  .invoicingAddress.streetNumber ==
                              null
                          ? ""
                          : bloc.interventionDetail.interventionDetail
                                          .invoicingAddress.streetNumber +
                                      " " +
                                      bloc.interventionDetail.interventionDetail
                                          .invoicingAddress.streetName ==
                                  null
                              ? ""
                              : bloc.interventionDetail.interventionDetail
                                  .invoicingAddress.streetName)
                      : (bloc.interventionDetail.interventionDetail
                                  .interventionAddress.streetNumber ==
                              null
                          ? ""
                          : bloc.interventionDetail.interventionDetail
                                          .interventionAddress.streetNumber +
                                      " " +
                                      bloc.interventionDetail.interventionDetail
                                          .interventionAddress.streetName ==
                                  null
                              ? ""
                              : bloc.interventionDetail.interventionDetail
                                  .interventionAddress.streetName),
                  style: AppStyles.body,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2)),
          Padding(
            padding: EdgeInsets.only(left: 30, bottom: 25),
            child: Text(
                bloc.interventionDetail.interventionDetail.invoicingAddress !=
                        null
                    ? (bloc.interventionDetail.interventionDetail
                                .invoicingAddress.streetNumber ==
                            null
                        ? ""
                        : bloc.interventionDetail.interventionDetail
                                        .invoicingAddress.city.postcode +
                                    " " +
                                    bloc.interventionDetail.interventionDetail
                                        .invoicingAddress.streetName ==
                                null
                            ? ""
                            : bloc.interventionDetail.interventionDetail
                                .invoicingAddress.city.name)
                    : (bloc.interventionDetail.interventionDetail
                                .interventionAddress.streetNumber ==
                            null
                        ? ""
                        : bloc.interventionDetail.interventionDetail
                                        .interventionAddress.city.postcode +
                                    " " +
                                    bloc.interventionDetail.interventionDetail
                                        .interventionAddress.streetName ==
                                null
                            ? ""
                            : bloc.interventionDetail.interventionDetail
                                .interventionAddress.city.name),
                style: AppStyles.body,
                overflow: TextOverflow.ellipsis,
                maxLines: 2),
          ),
          GestureDetector(
            onTap: () {
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
                        child: ModifierAdresseFacturationWidget(),
                      );
                    });
                  });
            },
            child: Center(
              child: Text(
                "MODIFIER L’ADRESSE DE FACTURATION",
                style: AppStyles.underlinedTertiaryButtonText,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAdresseIntervention() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
      color: AppColors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Adresse d’intervention :",
            style: AppStyles.header2,
          ),
          SizedBox(height: 15),
          Padding(
            padding: EdgeInsets.only(bottom: 5),
            child: GestureDetector(
              onTap: () async {
                final availableMaps = await MapLauncher.installedMaps;
                print(
                    availableMaps); // [AvailableMap { mapName: Google Maps, mapType: google }, ...]

                await availableMaps.first.showMarker(
                  coords: Coords(
                      bloc.interventionDetail.interventionDetail
                          .interventionAddress.latitude,
                      bloc.interventionDetail.interventionDetail
                          .interventionAddress.longitude),
                  title: "Adresse d'intervention",
                );
              },
              child: Row(
                children: [
                  FaIcon(FontAwesomeIcons.mapMarkerAlt,
                      color: AppColors.md_primary, size: 18),
                  SizedBox(width: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                          bloc.interventionDetail.interventionDetail
                                      .interventionAddress.streetNumber ==
                                  null
                              ? ""
                              : bloc
                                              .interventionDetail
                                              .interventionDetail
                                              .interventionAddress
                                              .streetNumber +
                                          " " +
                                          bloc
                                              .interventionDetail
                                              .interventionDetail
                                              .interventionAddress
                                              .streetName ==
                                      null
                                  ? ""
                                  : bloc.interventionDetail.interventionDetail
                                      .interventionAddress.streetName,
                          style: AppStyles.bodyPrimaryColor,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2),
                      SizedBox(height: 5),
                      Text(
                          bloc.interventionDetail.interventionDetail
                                  .interventionAddress.city.postcode +
                              " " +
                              bloc.interventionDetail.interventionDetail
                                  .interventionAddress.city.department.name,
                          style: AppStyles.bodyPrimaryColor,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 30, bottom: 5),
            child: RichText(
              textAlign: TextAlign.left,
              maxLines: 10,
              overflow: TextOverflow.clip,
              text: TextSpan(
                children: [
                  WidgetSpan(
                    child: FaIcon(FontAwesomeIcons.longArrowAltRight,
                        size: 16, color: AppColors.default_black),
                  ),
                  _userPosition == null
                      ? TextSpan(
                          text: "    Accéder à vos coordonnées de position",
                          style: AppStyles.textNormalPlaceholder,
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              _getUserLocation();
                            })
                      : TextSpan(
                          text: "    " +
                              userLocation
                                  .distanceBetweenTwoLocalisations(
                                      _userPosition.latitude,
                                      _userPosition.longitude,
                                      bloc.interventionDetail.interventionDetail
                                          .interventionAddress.latitude,
                                      bloc.interventionDetail.interventionDetail
                                          .interventionAddress.longitude)
                                  .toStringAsFixed(1) +
                              " km de ma position actuelle",
                          style: AppStyles.textNormal),
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 30, bottom: 10),
            child: RichText(
              textAlign: TextAlign.left,
              maxLines: 10,
              overflow: TextOverflow.clip,
              text: TextSpan(
                children: [
                  WidgetSpan(
                    child: FaIcon(FontAwesomeIcons.longArrowAltRight,
                        size: 16, color: AppColors.default_black),
                  ),
                  TextSpan(
                      text: "    " +
                          userLocation
                              .distanceBetweenTwoLocalisations(
                                  bloc
                                      .interventionDetail
                                      .interventionDetail
                                      .subcontractors
                                      .first
                                      .company
                                      .addresses
                                      .first
                                      .latitude,
                                  bloc
                                      .interventionDetail
                                      .interventionDetail
                                      .subcontractors
                                      .first
                                      .company
                                      .addresses
                                      .first
                                      .longitude,
                                  bloc.interventionDetail.interventionDetail
                                      .interventionAddress.latitude,
                                  bloc.interventionDetail.interventionDetail
                                      .interventionAddress.longitude)
                              .toStringAsFixed(1) +
                          "km de xx SARL",
                      style: AppStyles.textNormal),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCommentaires() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
      color: AppColors.md_gray,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Commentaire du client",
            style: AppStyles.header2,
          ),
          SizedBox(height: 15),
          Padding(
            padding: EdgeInsets.only(left: 0, bottom: 25),
            child: Text(
                bloc.interventionDetail.interventionDetail.description == ""
                    ? "Aucun commentaire"
                    : bloc.interventionDetail.interventionDetail.description,
                style: AppStyles.body,
                overflow: TextOverflow.ellipsis,
                maxLines: 120),
          ),
          ElevatedButton(
            child: Ink(
              decoration: BoxDecoration(
                gradient: MdGradientGreen(),
                borderRadius: BorderRadius.all(
                  Radius.circular(12),
                ),
              ),
              child: Container(
                  alignment: Alignment.center,
                  width: double.infinity,
                  height: 50,
                  child: Stack(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: FaIcon(FontAwesomeIcons.phoneAlt,
                              color: AppColors.white),
                        ),
                      ),
                      Center(
                        child: Text(
                          "APPELER LE CLIENT",
                          style: AppStyles.smallTitleWhite,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  )),
            ),
            onPressed: () {
              _callPhone(bloc
                  .interventionDetail.interventionDetail.clients.commchannels
                  .firstWhere((element) =>
                      (element.preferred) && (element.type.name == "Phone"))
                  .name);
            },
            style: ElevatedButton.styleFrom(
                elevation: 5,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                onPrimary: AppColors.white,
                primary: Colors.transparent,
                padding: EdgeInsets.zero,
                textStyle:
                    TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
          ),
          SizedBox(height: 15),
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
                  "ENVOYER UN SMS",
                  style: AppStyles.buttonTextDarkBlue,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
            onPressed: () {
              _sendSMS(bloc
                  .interventionDetail.interventionDetail.clients.commchannels
                  .firstWhere((element) =>
                      (element.preferred) && (element.type.name == "Phone"))
                  .name);
            },
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
    );
  }

  void _callPhone(String numero) async => await canLaunch("tel:" + numero)
      ? await launch("tel:" + numero)
      : throw 'Could not launch';

  void _sendSMS(String numero) async => await canLaunch("sms:" + numero)
      ? await launch("sms:" + numero)
      : throw 'Could not launch';

  void _sendMail(String email) async => await canLaunch("mailto:" + email)
      ? await launch("mailto:" + email)
      : throw 'Could not launch';
}
