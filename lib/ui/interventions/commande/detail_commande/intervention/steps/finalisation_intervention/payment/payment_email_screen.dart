import 'dart:ui';

import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mdp/constants/app_colors.dart';
import 'package:mdp/constants/app_constants.dart';
import 'package:mdp/constants/routes.dart';
import 'package:mdp/constants/styles/app_styles.dart';
import 'package:mdp/models/responses/payment/send_sms_payment_response.dart';
import 'package:mdp/ui/interventions/commande/detail_commande/intervention/steps/finalisation_intervention/finalisation_intervention_bloc.dart';
import 'package:mdp/ui/interventions/commande/detail_commande/intervention/steps/readction_devis/redaction_devis_bloc.dart';
import 'package:mdp/utils/flushbar_utils.dart';
import 'package:mdp/widgets/gradients/md_gradient_light.dart';

import '../../../../../../interventions_bloc.dart';

class PaymentEmailScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _PaymentEmailScreenState();
}

class _PaymentEmailScreenState extends State<PaymentEmailScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final bloc = Modular.get<InterventionsBloc>();
  final _finalisationInterventionBloc =
      Modular.get<FinalisationInterventionBloc>();
  TextEditingController _emailController = TextEditingController();
  GlobalKey<FormState> formKey = new GlobalKey();
  bool _loading = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
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
      body: GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
        child: SafeArea(
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
                ),
                Container(
                  padding: EdgeInsets.all(AppConstants.default_padding),
                  color: AppColors.white,
                  alignment: Alignment.center,
                  child: _buildEditText(),
                ),
                SizedBox(height: 7),
                Padding(
                  padding: EdgeInsets.all(AppConstants.default_padding),
                  child: Divider(
                      color: AppColors.md_gray, height: 1, thickness: 1.2),
                ),
                SizedBox(height: 7),
                Container(
                  padding: EdgeInsets.all(AppConstants.default_padding),
                  color: AppColors.white,
                  alignment: Alignment.center,
                  child: _buildSubmitButton(),
                ),
                SizedBox(height: 80),
              ],
            ),
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
                    text: "Finalisation de l'intervention \n n° ",
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

  Widget _buildEditText() {
    return Container(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            "Paiement en ligne",
            style: AppStyles.bodyBoldMdDarkBlue,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(height: 20),
          Text("Merci de renseigner l’e-mail du client :",
              style: AppStyles.body, overflow: TextOverflow.clip),
          SizedBox(height: 20),
          Form(
            key: formKey,
            child: TextFormField(
              controller: _emailController,
              obscureText: false,
              cursorColor: AppColors.default_black,
              keyboardType: TextInputType.emailAddress,
              onChanged: (value) {
                formKey.currentState.validate();
                setState(() {});
              },
              decoration: const InputDecoration(
                filled: true,
                fillColor: AppColors.md_light_gray,
                border: OutlineInputBorder(
                  borderSide:
                      BorderSide(color: AppColors.placeHolder, width: 1),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide:
                      BorderSide(color: AppColors.placeHolder, width: 1),
                ),
                errorBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: AppColors.mdAlert, width: 1),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide:
                      BorderSide(color: AppColors.placeHolder, width: 1.5),
                ),
                contentPadding: EdgeInsets.only(
                    bottom: 10.0, left: 10.0, right: 10.0, top: 10.0),
                errorStyle: AppStyles.textFieldError,
                hintText: "Adresse e-mail ...",
                hintStyle: AppStyles.textNormalPlaceholder,
              ),
              style: AppStyles.bodyBold,
              validator: (String value) => (value.isEmpty)
                  ? 'ce champ ne peut pas être vide'
                  : (EmailValidator.validate(value))
                      ? null
                      : 'email non valide',
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSubmitButton() {
    return ElevatedButton(
      child: Ink(
        decoration: BoxDecoration(
          color: _emailController.text.isEmpty
              ? AppColors.inactive
              : AppColors.md_dark_blue,
          borderRadius: BorderRadius.all(
            Radius.circular(12),
          ),
        ),
        child: Container(
          alignment: Alignment.center,
          width: double.infinity,
          height: 55,
          child: _loading
              ? Center(
                  child: CircularProgressIndicator(
                    color: AppColors.white,
                  ),
                )
              : Text(
                  "CONTINUER",
                  style: _emailController.text.isEmpty
                      ? AppStyles.buttonInactiveText
                      : AppStyles.buttonTextWhite,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
        ),
      ),
      onPressed: () async {
        setState(() {
          _loading = true;
        });
        final formState = formKey.currentState;
        if (formState.validate()) {
          SendSmsPaymentResponse verif =
              await _finalisationInterventionBloc.sendEmailPayment(
                  _emailController.text,
                  bloc.interventionDetail.interventionDetail.code,
                  bloc.interventionDetail.interventionDetail.clients.firstname);
          if (verif.success == null) {
            showErrorToast(context, "Une erreur est survenue");
          } else if (verif.success) {
            Modular.to.pushReplacementNamed(Routes.paymentMessage, arguments: {
              "status": true,
              "message": "Merci, un e-mail à bien été envoyé à l’adresse : " +
                  _emailController.text
            });
          } else {
            showErrorToast(context, "Une erreur est survenue");
          }
        }
        setState(() {
          _loading = false;
        });
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
}
