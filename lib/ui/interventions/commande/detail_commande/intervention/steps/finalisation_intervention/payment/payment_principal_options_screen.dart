import 'package:contained_tab_bar_view/contained_tab_bar_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mdp/constants/app_colors.dart';
import 'package:mdp/constants/app_constants.dart';
import 'package:mdp/constants/app_images.dart';
import 'package:mdp/constants/routes.dart';
import 'package:mdp/constants/styles/app_styles.dart';
import 'package:mdp/models/responses/payment/send_sms_payment_response.dart';
import 'package:mdp/ui/interventions/commande/detail_commande/client/client_widget.dart';
import 'package:mdp/ui/interventions/commande/detail_commande/intervention/intervention_widget.dart';
import 'package:mdp/ui/interventions/commande/detail_commande/intervention/steps/finalisation_intervention/finalisation_intervention_bloc.dart';
import 'package:mdp/ui/interventions/commande/detail_commande/intervention/steps/readction_devis/redaction_devis_bloc.dart';
import 'package:mdp/ui/interventions/commande/detail_commande/messagerie/messagerie_widget.dart';
import 'package:mdp/ui/interventions/interventions_bloc.dart';
import 'package:mdp/ui/interventions/interventions_screen.dart';
import 'package:mdp/utils/flushbar_utils.dart';
import 'package:mdp/widgets/gradients/md_gradient_light.dart';

class PaymentPrincipalOptionsScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _PaymentPrincipalOptionsScreenState();
}

class _PaymentPrincipalOptionsScreenState
    extends State<PaymentPrincipalOptionsScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final bloc = Modular.get<InterventionsBloc>();
  final _finalisationInterventionbloc =
      Modular.get<FinalisationInterventionBloc>();
  bool _smsButtonLoading = false;

  @override
  Future<void> initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.white,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            color: AppColors.white,
            child: _buildContent(),
          ),
        ),
      ),
    );
  }

  Widget _buildContent() {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(gradient: MdGradientLightt()),
          child: _buildHeader(),
        ),
        Container(
          decoration: BoxDecoration(gradient: MdGradientLightt()),
          child: _buildTitle(),
        ),
        Padding(
          padding: EdgeInsets.symmetric(
              horizontal: AppConstants.default_padding,
              vertical: AppConstants.default_padding * 2),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Paiement en ligne",
                style: AppStyles.bodyBoldMdDarkBlue,
              ),
              SizedBox(height: 15),
              Text(
                "Générer un lien de paiement pour votre client",
                style: AppStyles.body,
              ),
              SizedBox(height: 50),
              ElevatedButton(
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
                    height: 55,
                    child: Text(
                      "ENVOYER UN MAIL AU CLIENT",
                      style: AppStyles.buttonTextWhite,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
                onPressed: () {
                  _smsButtonLoading
                      ? null
                      : Modular.to.pushNamed(Routes.paymentEmailScreen);
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
                    color: AppColors.md_dark_blue,
                    borderRadius: BorderRadius.all(
                      Radius.circular(12),
                    ),
                    border: Border.all(color: AppColors.md_dark_blue),
                  ),
                  child: Container(
                    alignment: Alignment.center,
                    width: double.infinity,
                    height: 55,
                    child: _smsButtonLoading
                        ? Center(
                            child: CircularProgressIndicator(
                              color: AppColors.white,
                            ),
                          )
                        : Text(
                            "ENVOYER UN SMS AU CLIENT",
                            style: AppStyles.buttonTextWhite,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                  ),
                ),
                onPressed: () {
                  _smsButtonLoading ? null : _sendSms();
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
              SizedBox(height: 50),
              InkWell(
                splashColor: AppColors.md_dark_blue,
                onTap: () {
                  Modular.to.pushNamed(Routes.paymentOtherOptionsScreen);
                },
                child: Center(
                  child: RichText(
                    textAlign: TextAlign.left,
                    maxLines: 10,
                    overflow: TextOverflow.clip,
                    text: TextSpan(
                      children: [
                        WidgetSpan(
                          child: FaIcon(FontAwesomeIcons.solidQuestionCircle,
                              size: 16, color: AppColors.md_dark_blue),
                        ),
                        TextSpan(text: "    ", style: AppStyles.body),
                        TextSpan(
                            text: "Autre moyens de paiement disponible",
                            style: AppStyles.underlinedBodyBold),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
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
                    text: "Finalisation de l'Intervention \n",
                    style: AppStyles.header1White),
                TextSpan(text: "n° ", style: AppStyles.header1White),
                TextSpan(
                    text: bloc.interventionDetail.interventionDetail.code
                        .toString(),
                    style: AppStyles.header1WhiteBold),
              ],
            ),
          ),
          InkWell(
            onTap: () {
              Modular.to.pop();
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
            "Paiement",
            style: AppStyles.largeTextBoldDefaultBlack,
          ),
        ],
      ),
    );
  }

  _sendSms() async {
    setState(() {
      _smsButtonLoading = true;
    });
    SendSmsPaymentResponse resp =
        await _finalisationInterventionbloc.sendSmsPayment(
            bloc.interventionDetail.interventionDetail.clients.commchannels
                .firstWhere((element) =>
                    (element.preferred) && (element.type.name == "Phone"))
                .name,
            bloc.interventionDetail.interventionDetail.code,
            bloc.interventionDetail.interventionDetail.clients.firstname);
    setState(() {
      _smsButtonLoading = false;
    });
    if (resp.success == null) {
      showErrorToast(context, "Une erreur est survenue");
    } else if (resp.success) {
      Modular.to.pushReplacementNamed(Routes.paymentMessage, arguments: {
        "status": true,
        "message": "Merci, un sms a bien été envoyé au numéro suivant : " +
            bloc.interventionDetail.interventionDetail.clients.commchannels
                .firstWhere((element) =>
                    (element.preferred) && (element.type.name == "Phone"))
                .name
      });
    } else {
      showErrorToast(context, "Une erreur est survenue");
    }
  }
}
