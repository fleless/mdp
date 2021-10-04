import 'dart:isolate';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mdp/constants/app_colors.dart';
import 'package:mdp/constants/app_constants.dart';
import 'package:mdp/constants/routes.dart';
import 'package:mdp/constants/styles/app_styles.dart';
import 'package:mdp/models/responses/get_devis_response.dart';
import 'package:mdp/utils/document_uploader.dart';
import 'package:mdp/widgets/gradients/md_gradient_light.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:collection/collection.dart';

import '../../../../../../interventions_bloc.dart';

class PresentationDevisScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _PresentationDevisScreenState();
}

class _PresentationDevisScreenState extends State<PresentationDevisScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final bloc = Modular.get<InterventionsBloc>();
  bool _loadedDocument = false;
  ReceivePort _port = ReceivePort();

  @override
  void initState() {
    super.initState();
    IsolateNameServer.registerPortWithName(
        _port.sendPort, 'downloader_send_port');
    _port.listen((dynamic data) {
      String id = data[0];
      DownloadTaskStatus status = data[1];
      int progress = data[2];
      setState(() {
        print("done not");
        if (status == DownloadTaskStatus.complete) {
          print("done");
          _loadedDocument = true;
        }
      });
    });
    FlutterDownloader.registerCallback(DocumentUploader.downloadCallback);
  }

  @override
  void dispose() {
    super.dispose();
    IsolateNameServer.removePortNameMapping('downloader_send_port');
  }

  @override
  Widget build(BuildContext context) {
    return _buildContent();
  }

  Widget _buildContent() {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        key: _scaffoldKey,
        resizeToAvoidBottomInset: false,
        backgroundColor: AppColors.white,
        //drawer: DrawerWidget(),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  decoration: BoxDecoration(gradient: MdGradientLightt()),
                  child: _buildHeader(),
                ),
                Container(
                  decoration: BoxDecoration(gradient: MdGradientLightt()),
                  child: _buildTitle(),
                ),
                Container(
                  padding: EdgeInsets.all(AppConstants.default_padding),
                  color: AppColors.white,
                  alignment: Alignment.center,
                  child: _buildPDF(),
                ),
                Container(
                  padding: EdgeInsets.all(AppConstants.default_padding),
                  color: AppColors.white,
                  alignment: Alignment.center,
                  child: Divider(
                    height: 2,
                    thickness: 1.5,
                    color: AppColors.md_gray,
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(AppConstants.default_padding),
                  color: AppColors.white,
                  alignment: Alignment.center,
                  child: _buildAllButtons(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<bool> _onWillPop() async {
    Modular.to.pop();
    bloc.changesNotifier.add(true);
  }

  Widget _buildHeader() {
    return Padding(
      padding: EdgeInsets.only(
          left: AppConstants.default_padding,
          right: AppConstants.default_padding,
          bottom: AppConstants.default_padding,
          top: AppConstants.default_padding * 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          RichText(
            textAlign: TextAlign.left,
            maxLines: 10,
            overflow: TextOverflow.clip,
            text: TextSpan(
              children: [
                TextSpan(
                    text: "Rédaction du devis \nIntervention n° ",
                    style: AppStyles.header1White),
                TextSpan(
                    text: bloc.interventionDetail.interventionDetail.code,
                    style: AppStyles.header1WhiteBold),
              ],
            ),
          ),
          InkWell(
            onTap: () {
              Modular.to.pop();
              bloc.changesNotifier.add(true);
            },
            child: Icon(
              Icons.close_outlined,
              size: 25,
              color: AppColors.white,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTitle() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
          horizontal: AppConstants.default_padding,
          vertical: AppConstants.default_padding * 1.5),
      decoration: BoxDecoration(color: AppColors.md_light_gray),
      child: Text(
        "Signature du devis",
        style: AppStyles.largeTextBoldDefaultBlack,
      ),
    );
  }

  Widget _buildPDF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Présentation du devis",
          style: AppStyles.bodyBoldMdDarkBlue,
          overflow: TextOverflow.ellipsis,
        ),
        SizedBox(height: 20),
        Text(
            "Téléchargez le devis afin de le présenter au client pour signature.",
            style: AppStyles.body,
            overflow: TextOverflow.clip),
        SizedBox(height: 20),
        Stack(
          children: [
            Container(
              alignment: Alignment.center,
              margin: EdgeInsets.only(left: 10, right: 10, bottom: 10),
              decoration: BoxDecoration(
                color: AppColors.white,
                border: Border.all(
                    color: _loadedDocument
                        ? AppColors.md_dark_blue
                        : AppColors.closeDialogColor),
                borderRadius:
                    BorderRadius.circular(AppConstants.default_Radius),
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
                    setState(() {
                      _loadedDocument = true;
                    });
                    if (status.isGranted) {
                      final id = await FlutterDownloader.enqueue(
                          url: url,
                          savedDir: externalDir.path,
                          fileName: "Devis n°" +
                              bloc.dernierDevis.quoteData.quote.id.toString(),
                          showNotification: true,
                          openFileFromNotification: true);
                      await Future.delayed(const Duration(seconds: 3), () {
                        FlutterDownloader.open(taskId: id)
                            .then((value) => setState(() {
                                  _loadedDocument = true;
                                }));
                      });
                    } else {
                      print("permission denied");
                    }
                  },
                  child: Container(
                    padding: EdgeInsets.all(15),
                    alignment: Alignment.center,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.download,
                          color: _loadedDocument
                              ? AppColors.md_dark_blue
                              : AppColors.md_dark,
                        ),
                        Expanded(
                          child: Text(
                            "    Devis n°" +
                                bloc.dernierDevis.quoteData.quote.id.toString(),
                            style: _loadedDocument
                                ? AppStyles.bodyBold
                                : AppStyles.bodyBold,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Text(".pdf ",
                            style: _loadedDocument
                                ? AppStyles.bodyMdDarkBlue
                                : AppStyles.body)
                      ],
                    ),
                  ),
                ),
              ),
            ),
            if (_loadedDocument)
              Positioned(
                top: 0.0,
                right: 0.0,
                child: Icon(
                  Icons.check_circle,
                  color: AppColors.md_dark_blue,
                ),
              ),
          ],
        ),
      ],
    );
  }

  Widget _buildAllButtons() {
    return Column(
      children: [
        _buildButton(),
        SizedBox(height: 12),
        _buildSendMailButton(),
        SizedBox(height: 12),
        _buildMiseAttenteButton()
      ],
    );
  }

  Widget _buildButton() {
    return ElevatedButton(
      child: Ink(
        decoration: BoxDecoration(
          color: _loadedDocument ? AppColors.md_dark_blue : AppColors.inactive,
          borderRadius: BorderRadius.all(
            Radius.circular(12),
          ),
          border: Border.all(
              color: _loadedDocument
                  ? AppColors.md_dark_blue
                  : AppColors.inactive),
        ),
        child: Container(
          alignment: Alignment.center,
          width: double.infinity,
          height: 55,
          child: Text(
            "SIGNATURE CLIENT",
            style: _loadedDocument
                ? AppStyles.buttonTextWhite
                : AppStyles.buttonInactiveText,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
      onPressed: () {
        if (_loadedDocument) Modular.to.pushNamed(Routes.signatureClient);
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

  Widget _buildSendMailButton() {
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
          height: 55,
          child: Text(
            "ENVOYER LE DEVIS PAR MAIL",
            style: AppStyles.buttonTextDarkBlue,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
      onPressed: () {
        Modular.to.pushNamed(Routes.envoyerDevisMail);
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

  Widget _buildMiseAttenteButton() {
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
          height: 55,
          child: Text(
            "METTRE LE DEVIS EN ATTENTE",
            style: AppStyles.buttonTextDarkBlue,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
      onPressed: () {
        Modular.to.pop();
        bloc.changesNotifier.add(true);
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
}
