import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mdp/constants/app_colors.dart';
import 'package:mdp/constants/app_constants.dart';
import 'package:mdp/constants/routes.dart';
import 'package:mdp/constants/styles/app_styles.dart';
import 'package:mdp/models/responses/get_devis_response.dart';
import 'package:mdp/models/responses/get_notif_refus_response.dart';
import 'package:mdp/ui/interventions/commande/detail_commande/intervention/steps/prise_rdv/prise_rdv_bloc.dart';
import 'package:mdp/ui/interventions/commande/detail_commande/intervention/steps/readction_devis/redaction_devis_bloc.dart';
import 'package:mdp/utils/document_uploader.dart';
import 'package:mdp/utils/life_cycle_watcher.dart';
import 'package:mdp/widgets/gradients/md_gradient_green.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:isolate';
import 'dart:ui'; // You need to import these 2 libraries besides another libraries to work with this code
import 'package:collection/collection.dart';

import '../../../../../interventions_bloc.dart';

class RedactionDevisWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _RedactionDevisWidgetState();
}

class _RedactionDevisWidgetState
    extends LifecycleWatcherState<RedactionDevisWidget> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final bloc = Modular.get<InterventionsBloc>();
  final _rdvBloc = Modular.get<PriseRdvBloc>();
  final _redactionDevisBloc = Modular.get<RedactionDevisBloc>();
  bool opened = false;
  List<Photos> listePhotos = <Photos>[];
  ReceivePort _port = ReceivePort();
  bool _notifierRefusButtonLoading = false;

  @override
  void initState() {
    super.initState();
    bloc.changesNotifier.listen((value) {
      if (mounted) setState(() {});
    });
    if (bloc.dernierDevis != null) _getPhotosOfQuote();
    IsolateNameServer.registerPortWithName(
        _port.sendPort, 'downloader_send_port');
    _port.listen((dynamic data) {
      String id = data[0];
      DownloadTaskStatus status = data[1];
      int progress = data[2];
      setState(() {});
    });
    FlutterDownloader.registerCallback(DocumentUploader.downloadCallback);
  }

  _getPhotosOfQuote() {
    listePhotos.clear();
    setState(() {
      if (bloc.dernierDevis != null)
        bloc.dernierDevis.quoteData.designations.forEach((element) {
          if (element.photos != null) listePhotos.addAll(element.photos);
        });
    });
  }

  bool _validIfWeAreInThisStep() {
    if (bloc.dernierDevis == null) {
      if (_rdvBloc.userOrderAppointmentsResponse.length > 0) {
        return true;
      }
      return false;
    }
    return ((bloc.dernierDevis.quoteData.quote.state.code != "CLIENT_SIGNED") &&
        (_rdvBloc.userOrderAppointmentsResponse.length > 0));
  }

  bool _validIfWeEndedTheStep() {
    if (bloc.dernierDevis == null) {
      return false;
    }
    return bloc.dernierDevis.quoteData.quote.state.code == "CLIENT_SIGNED";
  }

  @override
  void dispose() {
    IsolateNameServer.removePortNameMapping('downloader_send_port');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _buildContent();
  }

  Widget _buildContent() {
    return Container(
        width: double.infinity,
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              color: _validIfWeAreInThisStep()
                  ? AppColors.md_gray
                  : AppColors.white,
              child: _buildHeader(),
            ),
            opened ? _buildExpansion() : SizedBox.shrink()
          ],
        ));
  }

  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _validIfWeAreInThisStep()
                ? Container(
                    width: 30.0,
                    height: 30.0,
                    alignment: Alignment.center,
                    decoration: new BoxDecoration(
                      color: AppColors.md_dark_blue,
                      shape: BoxShape.circle,
                      border:
                          Border.all(color: AppColors.md_dark_blue, width: 1.5),
                    ),
                    child: Icon(
                      Icons.edit,
                      color: AppColors.white,
                      size: 16,
                    ),
                  )
                : _validIfWeEndedTheStep()
                    ? Container(
                        width: 30.0,
                        height: 30.0,
                        alignment: Alignment.center,
                        decoration: new BoxDecoration(
                          color: AppColors.white,
                          shape: BoxShape.circle,
                          border: Border.all(
                              color: AppColors.md_primary, width: 1.5),
                        ),
                        child: Icon(
                          Icons.done,
                          color: AppColors.md_primary,
                          size: 16,
                        ),
                      )
                    : Container(
                        width: 30.0,
                        height: 30.0,
                        alignment: Alignment.center,
                        decoration: new BoxDecoration(
                          color: Colors.transparent,
                          shape: BoxShape.circle,
                          border: Border.all(
                              color: AppColors.placeHolder, width: 1.5),
                        ),
                        child: Text(
                          "2",
                          style: AppStyles.header2Gray,
                        ),
                      ),
            SizedBox(width: 10),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 3),
                  Text("Rédaction du devis",
                      style: _rdvBloc.userOrderAppointmentsResponse.length > 0
                          ? AppStyles.header2DarkBlue
                          : AppStyles.header2Gray),
                  !(_rdvBloc.userOrderAppointmentsResponse.length > 0)
                      ? SizedBox.shrink()
                      : SizedBox(height: 5),
                  _validIfWeAreInThisStep()
                      ? Container(
                          padding: EdgeInsets.all(7),
                          decoration: BoxDecoration(
                            color: bloc.dernierDevis == null
                                ? AppColors.mdAlert
                                : bloc.dernierDevis.quoteData.quote.state
                                            .code ==
                                        "SUBCONTRACTOR_SIGNED"
                                    ? AppColors.travaux
                                    : AppColors.mdAlert,
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                          ),
                          child: Text(
                              bloc.dernierDevis == null
                                  ? "  À réaliser "
                                  : bloc.dernierDevis.quoteData.quote.state
                                              .code ==
                                          "CLIENT_REFUSED"
                                      ? "  Devis refusé "
                                      : bloc.dernierDevis.quoteData.quote.state
                                                  .code ==
                                              "SUBCONTRACTOR_SIGNED"
                                          ? "  En attente "
                                          : "  À réaliser ",
                              style: AppStyles.tinyTitleWhite,
                              textAlign: TextAlign.center,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis),
                        )
                      : _validIfWeEndedTheStep()
                          ? Container(
                              padding: EdgeInsets.all(7),
                              decoration: BoxDecoration(
                                color: AppColors.md_secondary,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15)),
                              ),
                              child: Text("  Validé et signé ",
                                  style: AppStyles.tinyTitleWhite,
                                  textAlign: TextAlign.center,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis),
                            )
                          : SizedBox.shrink(),
                ],
              ),
            ),
            Container(
              height: 30,
              child: IconButton(
                onPressed: () {
                  _rdvBloc.userOrderAppointmentsResponse.length > 0
                      ? setState(() {
                          opened = !opened;
                        })
                      : null;
                },
                iconSize: 12,
                alignment: Alignment.topCenter,
                icon: FaIcon(
                    opened
                        ? FontAwesomeIcons.chevronUp
                        : FontAwesomeIcons.chevronDown,
                    color: _validIfWeEndedTheStep()
                        ? AppColors.md_primary
                        : _validIfWeAreInThisStep()
                            ? AppColors.md_dark_blue
                            : AppColors.placeHolder,
                    size: 12),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildExpansion() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      color: _validIfWeAreInThisStep() ? AppColors.md_gray : AppColors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          (bloc.dernierDevis == null)
              ? SizedBox.shrink()
              : bloc.dernierDevis.quoteData.quote.id == null
                  ? SizedBox.shrink()
                  : (bloc.dernierDevis.quoteData.documents
                          .where((element) =>
                              element.documentType == "signature_artisan")
                          .toList()
                          .isNotEmpty)
                      ? _buildPDF()
                      : SizedBox.shrink(),
          SizedBox(height: 10),
          if ((bloc.dernierDevis != null) && (listePhotos.length != 0))
            _buildPhotos(),
          bloc.dernierDevis == null
              ? _buildUndefinedStateButtons()
              : bloc.dernierDevis.quoteData.quote.state.code == "UNDEFINED"
                  ? _buildUndefinedStateButtons()
                  : bloc.dernierDevis.quoteData.quote.state.code ==
                          "SUBCONTRACTOR_SIGNED"
                      ? _buildSubcontractorSignedStateButtons()
                      : bloc.dernierDevis.quoteData.quote.state.code ==
                              "CLIENT_REFUSED"
                          ? _buildRefusedStateButtons()
                          : bloc.dernierDevis.quoteData.quote.state.code ==
                                  "CLIENT_SIGNED"
                              ? SizedBox.shrink()
                              : _buildUndefinedStateButtons()
        ],
      ),
    );
  }

  Widget _buildUndefinedStateButtons() {
    return Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
      SizedBox(height: 10),
      _buildRealiserDevisButton(),
      SizedBox(height: 10),
    ]);
  }

  Widget _buildSubcontractorSignedStateButtons() {
    return Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
      SizedBox(height: 10),
      _buildAppelerClientButon(),
      SizedBox(height: 10),
      _buildFaireSignerDevisButton(),
      SizedBox(height: 10),
      _buildRefusButton(),
      SizedBox(height: 10),
    ]);
  }

  Widget _buildRefusedStateButtons() {
    return Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
      SizedBox(height: 10),
      _buildEnvoyerMessageButton(),
      SizedBox(height: 10),
      _buildRealiserAutreDevisButton(),
      SizedBox(height: 10),
    ]);
  }

  Widget _buildPDF() {
    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.only(left: 10, right: 10, bottom: 10),
      decoration: BoxDecoration(
        color: AppColors.white,
        border: Border.all(color: AppColors.closeDialogColor),
        borderRadius: BorderRadius.circular(AppConstants.default_Radius),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          splashColor: AppColors.md_light_gray,
          onTap: () async {
            final status = await Permission.storage.request();
            final externalDir = await getTemporaryDirectory();
            Documents doc = bloc.dernierDevis.quoteData.documents
                .firstWhereOrNull(
                    (element) => element.documentType == "quote_pdf");
            String url;
            if (doc == null) {
              url = "http://www.africau.edu/images/default/sample.pdf";
            } else {
              url = doc.url;
            }
            if (status.isGranted) {
              openFile(
                  url: url,
                  fileName: "Devis n°" +
                      bloc.dernierDevis.quoteData.quote.id.toString() +
                      ".pdf");
            } else {
              print("permission denied");
            }
            /*final status = await Permission.storage.request();
            final externalDir = await getTemporaryDirectory();
            Documents doc = bloc.dernierDevis.quoteData.documents
                .firstWhereOrNull(
                    (element) => element.documentType == "quote_pdf");
            String url;
            if (doc != null) {
              url = "http://www.africau.edu/images/default/sample.pdf";
            } else {
              url = doc.url;
            }
            if (status.isGranted) {
              final id = await FlutterDownloader.enqueue(
                url: url,
                savedDir: externalDir.path,
                fileName: "Devis n°" +
                    bloc.dernierDevis.quoteData.quote.id.toString(),
                showNotification: true,
                openFileFromNotification: true,
                saveInPublicStorage: true,
              ).then((value) => FlutterDownloader.open(taskId: value));
              /*await Future.delayed(const Duration(seconds: 3), () {
                FlutterDownloader.open(taskId: id);
              });*/
            } else {
              print("permission denied");
            }*/
          },
          child: Container(
            padding: EdgeInsets.all(15),
            alignment: Alignment.center,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  Icons.download,
                ),
                Expanded(
                  child: Text(
                    "    Devis n°" +
                        bloc.dernierDevis.quoteData.quote.id.toString(),
                    style: AppStyles.bodyBold,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Text(".pdf ", style: AppStyles.body)
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future openFile({String url, String fileName}) async {
    final file = await downloadFile(url, fileName);
    if (file == null) return;
    print("Path: ${file.path}");
    OpenFile.open(file.path);
  }

  ///Download File into private folder not visible to user
  Future<File> downloadFile(String url, String name) async {
    final appStorage = await getApplicationDocumentsDirectory();
    final file = File('${appStorage.path}/$name');
    final response = await Dio().get(
      url,
      options: Options(
        responseType: ResponseType.bytes,
        followRedirects: false,
        receiveTimeout: 0,
      ),
    );
    final raf = file.openSync(mode: FileMode.write);
    raf.writeFromSync(response.data);
    await raf.close();
    return file;
  }

  Widget _buildPhotos() {
    return Padding(
      padding: EdgeInsets.only(bottom: 20, right: 10, left: 10),
      child: Container(
        width: double.infinity,
        height: 220,
        child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: listePhotos.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () => {
                  Modular.to.pushNamed(Routes.photoView,
                      arguments: {'image': listePhotos[index].url, 'path': ""})
                },
                child: Card(
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  elevation: 4,
                  child: Container(
                    width: 160,
                    child: Image.network(listePhotos[index].url,
                        fit: BoxFit.cover),
                  ),
                ),
              );
            }),
      ),
    );
  }

  Widget _buildRealiserDevisButton() {
    return ElevatedButton(
      child: Ink(
        decoration: BoxDecoration(
          color: AppColors.md_dark_blue,
          borderRadius: BorderRadius.all(
            Radius.circular(12),
          ),
          border: Border.all(color: AppColors.md_dark_blue),
        ),
        child: Container(
          alignment: Alignment.center,
          width: double.infinity,
          height: 50,
          child: Text(
            "RÉALISER LE DEVIS",
            style: AppStyles.buttonTextWhite,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
      onPressed: () {
        Modular.to
            .pushNamed(Routes.redactionDevis)
            .then((value) => setState(() {
                  _getPhotosOfQuote();
                }));
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

  Widget _buildAppelerClientButon() {
    return ElevatedButton(
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
        dynamic phone = bloc
            .interventionDetail.interventionDetail.clients.commchannels
            .firstWhereOrNull((element) =>
                (element.preferred) && (element.type.name == "Phone"));
        phone == null
            ? Fluttertoast.showToast(msg: "Aucun numéro indiqué")
            : _callPhone(phone.name);
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

  Widget _buildFaireSignerDevisButton() {
    return ElevatedButton(
      child: Ink(
        decoration: BoxDecoration(
          color: AppColors.md_dark_blue,
          borderRadius: BorderRadius.all(
            Radius.circular(12),
          ),
          border: Border.all(color: AppColors.md_dark_blue),
        ),
        child: Container(
          alignment: Alignment.center,
          width: double.infinity,
          height: 50,
          child: Text(
            "FAIRE SIGNER LE DEVIS",
            style: AppStyles.buttonTextWhite,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
      onPressed: () {
        Modular.to.pushNamed(Routes.presentationDevis);
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

  Widget _buildRefusButton() {
    return ElevatedButton(
      child: Ink(
        decoration: BoxDecoration(
          color: AppColors.md_dark_blue,
          borderRadius: BorderRadius.all(
            Radius.circular(12),
          ),
          border: Border.all(color: AppColors.md_dark_blue),
        ),
        child: Container(
          alignment: Alignment.center,
          width: double.infinity,
          height: 50,
          child: _notifierRefusButtonLoading
              ? Center(
                  child: CircularProgressIndicator(color: AppColors.white),
                )
              : Text(
                  "NOTIFIER UN REFUS",
                  style: AppStyles.buttonTextWhite,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
        ),
      ),
      onPressed: () async {
        if (!_notifierRefusButtonLoading) {
          setState(() {
            _notifierRefusButtonLoading = true;
          });
          GetNotifRefusResponse resp = await _redactionDevisBloc
              .notifierRefus(bloc.dernierDevis.quoteData.quote.id);
          await bloc
              .getDevisDetails(bloc.dernierDevis.quoteData.quote.id.toString());
          setState(() {
            _notifierRefusButtonLoading = false;
          });
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

  Widget _buildEnvoyerMessageButton() {
    return ElevatedButton(
      child: Ink(
        decoration: BoxDecoration(
          color: AppColors.md_dark_blue,
          borderRadius: BorderRadius.all(
            Radius.circular(12),
          ),
          border: Border.all(color: AppColors.md_dark_blue),
        ),
        child: Container(
          alignment: Alignment.center,
          width: double.infinity,
          height: 50,
          child: Text(
            "ENVOYER UN MESSAGE À MES DESPANNEURS",
            style: AppStyles.buttonTextWhite,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
      onPressed: () {
        bloc.changeIndex(2);
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

  Widget _buildRealiserAutreDevisButton() {
    return ElevatedButton(
      child: Ink(
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.all(
            Radius.circular(12),
          ),
          border: Border.all(color: AppColors.md_dark_blue),
        ),
        child: Container(
          alignment: Alignment.center,
          width: double.infinity,
          height: 50,
          child: Text(
            "RÉALISER UN AUTRE DEVIS ",
            style: AppStyles.buttonTextDarkBlue,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
      onPressed: () {
        setState(() {
          bloc.dernierDevis = null;
          Modular.to
              .pushNamed(Routes.redactionDevis)
              .then((value) => setState(() {
                    _getPhotosOfQuote();
                  }));
        });
      },
      style: ElevatedButton.styleFrom(
          elevation: 5,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          onPrimary: AppColors.md_dark_blue,
          primary: Colors.transparent,
          padding: EdgeInsets.zero,
          textStyle: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
    );
  }

  @override
  void onDetached() {}

  @override
  void onInactive() {}

  @override
  void onPaused() {}

  @override
  void onResumed() {
    setState(() {
      _getPhotosOfQuote();
    });
  }

  void _callPhone(String numero) async => await canLaunch("tel:" + numero)
      ? await launch("tel:" + numero)
      : throw 'Could not launch';
}
