import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mdp/constants/app_colors.dart';
import 'package:mdp/constants/app_constants.dart';
import 'package:mdp/constants/routes.dart';
import 'package:mdp/constants/styles/app_styles.dart';
import 'package:mdp/models/responses/upload_document_response.dart';
import 'package:mdp/ui/interventions/commande/detail_commande/intervention/steps/readction_devis/redaction_devis_bloc.dart';
import 'package:mdp/widgets/gradients/md_gradient_light.dart';
import 'package:signature/signature.dart';

import '../../../../../../interventions_bloc.dart';

class SignatureClientScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SignatureClientScreenState();
}

class _SignatureClientScreenState extends State<SignatureClientScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final bloc = Modular.get<InterventionsBloc>();
  final _RedactionDevisBloc = Modular.get<RedactionDevisBloc>();
  final SignatureController _controller = SignatureController(
    penStrokeWidth: 5,
    penColor: AppColors.default_black,
    exportBackgroundColor: AppColors.white,
  );
  bool _checkBoxFirst = false;
  bool _checkBoxSecond = false;
  bool _checkBoxThird = false;
  bool _checkBoxFourth = false;
  bool _checkBoxFifth = false;
  bool _loadingSignature = false;

  @override
  void initState() {
    super.initState();
    _controller.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _buildContent();
  }

  Widget _buildContent() {
    return Scaffold(
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
                child: _buildCheckBoxes(),
              ),
              Container(
                padding: EdgeInsets.all(AppConstants.default_padding),
                color: AppColors.white,
                alignment: Alignment.center,
                child: _loadingSignature
                    ? _buildLoadingBloc()
                    : _buildSingatureBloc(),
              ),
            ],
          ),
        ),
      ),
    );
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
          vertical: AppConstants.default_padding * 2),
      decoration: BoxDecoration(color: AppColors.md_light_gray),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () {
              Modular.to.pop();
              bloc.changesNotifier.add(true);
            },
            child: RichText(
              textAlign: TextAlign.left,
              maxLines: 10,
              overflow: TextOverflow.clip,
              text: TextSpan(
                children: [
                  WidgetSpan(
                      alignment: PlaceholderAlignment.middle,
                      child: FaIcon(
                        FontAwesomeIcons.chevronLeft,
                        color: AppColors.md_dark_blue,
                        size: 14,
                      )),
                  TextSpan(text: "   Retour", style: AppStyles.textNormalBold),
                ],
              ),
            ),
          ),
          SizedBox(height: 15),
          Text(
            "Signature du devis",
            style: AppStyles.largeTextBoldDefaultBlack,
          ),
        ],
      ),
    );
  }

  Widget _buildCheckBoxes() {
    return Container(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Conditions de signature",
            style: AppStyles.bodyBoldMdDarkBlue,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(height: 20),
          _buildCheckBoxFirst(),
          SizedBox(height: 10),
          _buildCheckBoxSecond(),
          SizedBox(height: 10),
          _buildCheckBoxThird(),
          SizedBox(height: 10),
          _buildCheckBoxFourth(),
          SizedBox(height: 10),
          _buildCheckBoxFifth(),
          SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildCheckBoxFirst() {
    return Theme(
      data: ThemeData(unselectedWidgetColor: AppColors.md_dark_blue),
      child: CheckboxListTile(
        contentPadding: EdgeInsets.only(left: 0),
        title: Text(
            "La situation présentant un caractère urgent, je demande l'exécution immédiate de l'intervention. Je reconnais que le délai de rétractation n'est pas applicable.",
            style: AppStyles.body),
        checkColor: AppColors.white,
        activeColor: AppColors.md_dark_blue,
        value: _checkBoxFirst,
        onChanged: (newValue) {
          setState(() {
            _checkBoxFirst = newValue;
          });
        },
        controlAffinity:
            ListTileControlAffinity.leading, //  <-- leading Checkbox
      ),
    );
  }

  Widget _buildCheckBoxSecond() {
    return Theme(
      data: ThemeData(unselectedWidgetColor: AppColors.md_dark_blue),
      child: CheckboxListTile(
        contentPadding: EdgeInsets.only(left: 0),
        title: Text(
            "Je profite de la présence du professionnel pour effectuer des travaux supplémentaires immédiatement. Un devis complémentaire m'est remis.",
            style: AppStyles.body),
        checkColor: AppColors.white,
        activeColor: AppColors.md_dark_blue,
        value: _checkBoxSecond,
        onChanged: (newValue) {
          setState(() {
            _checkBoxSecond = newValue;
          });
        },
        controlAffinity:
            ListTileControlAffinity.leading, //  <-- leading Checkbox
      ),
    );
  }

  Widget _buildCheckBoxThird() {
    return Theme(
      data: ThemeData(unselectedWidgetColor: AppColors.md_dark_blue),
      child: CheckboxListTile(
        contentPadding: EdgeInsets.only(left: 0),
        title: Text(
            "J'atteste que le lieu est à usage d'habitation (au moins 50% de sa superficie), que la construction est achevée depuis plus de deux ans au commencement des travaux et que les travaux mentionnés sur le devis ne constituent pas des travaux d'agrandissement.",
            style: AppStyles.body),
        checkColor: AppColors.white,
        activeColor: AppColors.md_dark_blue,
        value: _checkBoxThird,
        onChanged: (newValue) {
          setState(() {
            _checkBoxThird = newValue;
          });
        },
        controlAffinity:
            ListTileControlAffinity.leading, //  <-- leading Checkbox
      ),
    );
  }

  Widget _buildCheckBoxFourth() {
    return Theme(
      data: ThemeData(unselectedWidgetColor: AppColors.md_dark_blue),
      child: CheckboxListTile(
        contentPadding: EdgeInsets.only(left: 0),
        title: Text(
            "Souhaitez-vous conserver les pièces, éléments ou appareils remplacés ?",
            style: AppStyles.body),
        checkColor: AppColors.white,
        activeColor: AppColors.md_dark_blue,
        value: _checkBoxFourth,
        onChanged: (newValue) {
          setState(() {
            _checkBoxFourth = newValue;
          });
        },
        controlAffinity:
            ListTileControlAffinity.leading, //  <-- leading Checkbox
      ),
    );
  }

  Widget _buildCheckBoxFifth() {
    return Theme(
      data: ThemeData(unselectedWidgetColor: AppColors.md_dark_blue),
      child: CheckboxListTile(
        contentPadding: EdgeInsets.only(left: 0),
        title: Text("Devis reçu avant l'exécution des travaux.",
            style: AppStyles.body),
        checkColor: AppColors.white,
        activeColor: AppColors.md_dark_blue,
        value: _checkBoxFifth,
        onChanged: (newValue) {
          setState(() {
            _checkBoxFifth = newValue;
          });
        },
        controlAffinity:
            ListTileControlAffinity.leading, //  <-- leading Checkbox
      ),
    );
  }

  Widget _buildSingatureBloc() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Signature du client",
          style: AppStyles.bodyBoldMdDarkBlue,
          overflow: TextOverflow.ellipsis,
        ),
        SizedBox(height: 20),
        Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            side: BorderSide(
              color: AppColors.hint,
              width: 0.3,
            ),
          ),
          clipBehavior: Clip.antiAlias,
          elevation: 4,
          child: Signature(
            controller: _controller,
            width: double.infinity,
            height: 200,
            backgroundColor: AppColors.md_light_gray,
          ),
        ),
        SizedBox(height: 20),
        _buildButton(),
      ],
    );
  }

  Widget _buildButton() {
    return ElevatedButton(
      child: Ink(
        decoration: BoxDecoration(
          color: (((!_checkBoxFifth)) || (_controller.isEmpty))
              ? AppColors.inactive
              : AppColors.md_dark_blue,
          borderRadius: BorderRadius.all(
            Radius.circular(12),
          ),
          border: Border.all(
              color: (((!_checkBoxFifth)) || (_controller.isEmpty))
                  ? AppColors.inactive
                  : AppColors.md_dark_blue),
        ),
        child: Container(
          alignment: Alignment.center,
          width: double.infinity,
          height: 55,
          child: Text(
            "SIGNER",
            style: (((!_checkBoxFifth)) || (_controller.isEmpty))
                ? AppStyles.buttonInactiveText
                : AppStyles.buttonTextWhite,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
      onPressed: () async {
        if ((_controller.isNotEmpty) && (_checkBoxFifth)) {
          setState(() {
            _loadingSignature = true;
          });
          final Uint8List data = await _controller.toPngBytes();
          final imageEncoded = base64.encode(data); // returns base64 string
          UploadDocumentResponse resp =
              await _RedactionDevisBloc.uploadClientSignature(
                  bloc.dernierDevis.quoteData.quote.id.toString(),
                  imageEncoded);
          if (resp.documentUploaded) {
            await bloc.getDevisDetails(
                bloc.dernierDevis.quoteData.quote.id.toString());
            Modular.to.pop();
            Modular.to.pop();
            bloc.changesNotifier.add(true);
          } else {
            Fluttertoast.showToast(
                msg: "erreur lors de la signature. Veuillez réessayer.");
          }
          setState(() {
            _loadingSignature = false;
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

  _buildLoadingBloc() {
    return Container(
      height: 200,
      child: Card(
        color: AppColors.md_light_gray,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: BorderSide(
            color: AppColors.hint,
            width: 0.1,
          ),
        ),
        clipBehavior: Clip.antiAlias,
        elevation: 4,
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(
                color: AppColors.md_dark_blue,
              ),
              SizedBox(height: 10),
              Text(
                "Génération du devis",
                style: AppStyles.bodyBoldMdDarkBlue,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              )
            ],
          ),
        ),
      ),
    );
  }
}
