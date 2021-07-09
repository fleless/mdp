import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:mdp/constants/app_colors.dart';
import 'package:mdp/constants/app_constants.dart';
import 'package:mdp/constants/routes.dart';
import 'package:mdp/constants/styles/app_styles.dart';
import 'package:mdp/models/responses/show_intervention_response.dart';
import 'package:mdp/ui/interventions/commande/nouvelle_commande/motif_refus.dart';
import 'package:mdp/ui/interventions/interventions_bloc.dart';
import 'package:mdp/widgets/gradients/md_gradient_light.dart';
import 'package:map_launcher/map_launcher.dart';

class PropositionCommandeWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _PropositionCommandeWidgetState();
}

class _PropositionCommandeWidgetState extends State<PropositionCommandeWidget> {
  bool loading = true;
  ShowInterventionResponse _showInterventionResponse =
      ShowInterventionResponse();
  final bloc = Modular.get<InterventionsBloc>();
  bool _acceptLoading = false;

  @override
  Future<void> initState() {
    _loadIntervention();
    super.initState();
  }

  _loadIntervention() async {
    setState(() {
      loading = true;
    });
    _showInterventionResponse =
        await bloc.showIntervention("73467dae-df59-11eb-a612-0ace6068ba3f");
    setState(() {
      loading = false;
    });
  }

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
            child: Column(
              children: [
                _buildTitle(),
                loading
                    ? Container(
                        height: 500,
                        child: Center(
                          child: CircularProgressIndicator(
                            color: AppColors.md_dark_blue,
                          ),
                        ),
                      )
                    : _buildContent(),
              ],
            ),
          ),
        ),
      ),
    ));
  }

  Widget _buildContent() {
    return Column(
      children: [
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
        mainAxisSize: MainAxisSize.min,
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
                  _showInterventionResponse.intervention.partner.name,
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
                  _showInterventionResponse.intervention.code,
                  style: AppStyles.boldText,
                ),
              ),
            ),
          ),
          SizedBox(height: 30),
          for (var i in _showInterventionResponse.intervention.details)
            Padding(padding: EdgeInsets.only(top: 10), child: _orderCase(i)),
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
              title: Text(
                  "Min : " +
                      _showInterventionResponse.intervention.totalMinPrice
                          .toString() +
                      " € - Max : " +
                      _showInterventionResponse.intervention.totalMaxPrice
                          .toString() +
                      " €",
                  style: AppStyles.bodyWhite,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis),
              subtitle: Text(
                  "Montant pré-bloqué " +
                      _showInterventionResponse.intervention.amountToBlock
                          .toString() +
                      " €",
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
                coords: Coords(
                    double.parse(_showInterventionResponse
                        .intervention.interventionAddress.city.latitude),
                    double.parse(_showInterventionResponse
                        .intervention.interventionAddress.city.longitude)),
                title: _showInterventionResponse
                    .intervention.interventionAddress.city.name,
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
                title: Text(
                    _showInterventionResponse
                        .intervention.interventionAddress.streetName,
                    style: AppStyles.bodyWhite,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis),
                subtitle: Text(
                    _showInterventionResponse
                            .intervention.interventionAddress.city.postcode +
                        " " +
                        _showInterventionResponse.intervention
                            .interventionAddress.city.department.name,
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
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.md_dark_blue),
          borderRadius: BorderRadius.all(Radius.circular(15)),
        ),
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
                color: AppColors.md_dark_blue,
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
                color: AppColors.white,
              ),
              child: Text(_getPreferredDate(),
                  style: AppStyles.textNormalBold,
                  textAlign: TextAlign.left,
                  maxLines: 5,
                  overflow: TextOverflow.ellipsis),
            ),
          ],
        ),
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
                _showInterventionResponse.intervention.description == ""
                    ? "Aucun commentaire"
                    : _showInterventionResponse.intervention.description,
                style: AppStyles.textNormal,
                maxLines: 100,
                overflow: TextOverflow.clip),
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
                itemCount:
                    _showInterventionResponse.intervention.clientPhotos.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () => {
                      Modular.to.pushNamed(Routes.photoView, arguments: {
                        'image': _showInterventionResponse
                            .intervention.clientPhotos[index]
                      })
                    },
                    child: Card(
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      elevation: 4,
                      child: Container(
                        width: 180,
                        child: Hero(
                          tag: AppConstants.IMAGE_VIEWER_TAG,
                          child: Image.network(
                              _showInterventionResponse
                                  .intervention.clientPhotos[index],
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
            child: _acceptLoading
                ? Center(
                    child: CircularProgressIndicator(color: AppColors.white),
                  )
                : Text(
                    "ACCEPTER L'INTERVENTION",
                    style: AppStyles.smallTitleWhite,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
          ),
        ),
        onPressed: () {
          _acceptLoading ? null : _acceptAction();
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

  _acceptAction() async {
    setState(() {
      _acceptLoading = true;
    });
    Intervention _intervention = _showInterventionResponse.intervention;
    int response = await bloc.acceptIntervention(
        _intervention.code, _intervention.id, _intervention.uuid, null);
    if (response == 200) {
      Modular.to.popAndPushNamed(Routes.detailCommande);
    } else {
      Fluttertoast.showToast(
          msg: "Compétition introuvable",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
      );
      //TODO: remove when release mode
      Modular.to.popAndPushNamed(Routes.detailCommande);
    }
    setState(() {
      _acceptLoading = false;
    });
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
              "REFUSER L'INTERVENTION",
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
                    child: MotifRefusWidget(_showInterventionResponse),
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

  Widget _orderCase(Details detail) {
    return Column(
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
          child: Text(
              detail.ordercase.code.toString() + " - " + detail.ordercase.name,
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
          child: Text(
              _showInterventionResponse.intervention.indication == ""
                  ? "Aucun commentaire."
                  : _showInterventionResponse.intervention.indication,
              style: AppStyles.textNormal,
              textAlign: TextAlign.left,
              maxLines: 5,
              overflow: TextOverflow.ellipsis),
        ),
      ],
    );
  }

  _getPreferredDate() {
    DateTime dateTime = DateTime.parse(
        _showInterventionResponse.intervention.preferredVisitDate.date);
    String day = DateFormat('EEEE').format(dateTime);
    switch (day) {
      case "Saturday":
        day = "Samedi";
        break;
      case "Monday":
        day = "Lundi";
        break;
      case "Thursday":
        day = "Mardi";
        break;
      case "Wednesday":
        day = "mercredi";
        break;
      case "Tuesday":
        day = "Jeudi";
        break;
      case "Friday":
        day = "Vendredi";
        break;
    }
    day += " ";
    day += dateTime.day.toString();
    day += " ";
    String month = "";
    switch (dateTime.month) {
      case 1:
        month = "Janvier";
        break;
      case 2:
        month = "Février";
        break;
      case 3:
        month = "Mars";
        break;
      case 4:
        month = "Avril";
        break;
      case 5:
        month = "Mai";
        break;
      case 6:
        month = "Juin";
        break;
      case 7:
        month = "Juillet";
        break;
      case 8:
        month = "Août";
        break;
      case 9:
        month = "Septembre";
        break;
      case 10:
        month = "Octobre";
        break;
      case 11:
        month = "Novembre";
        break;
      case 12:
        month = "Décembre";
        break;
    }
    day += month;
    day += " - ";
    day += (DateFormat('HH:mm').format(dateTime)).replaceAll(":", "h");
    return day;
  }
}
