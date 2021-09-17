import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mdp/constants/app_colors.dart';
import 'package:mdp/constants/app_constants.dart';
import 'package:mdp/constants/app_images.dart';
import 'package:mdp/constants/styles/app_styles.dart';
import 'package:mdp/ui/interventions/interventions_bloc.dart';
import 'package:mdp/widgets/gradients/md_gradient_light.dart';

class PaymentMessageScreen extends StatefulWidget {
  //true = succes, false = message envoyé
  bool status;
  String message;

  //check if we need to pop twice or once to return to intervention detail screen
  bool otherOptions;

  PaymentMessageScreen(this.status, this.message, this.otherOptions);

  @override
  State<StatefulWidget> createState() => _PaymentMessageScreenState();
}

class _PaymentMessageScreenState extends State<PaymentMessageScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final bloc = Modular.get<InterventionsBloc>();

  @override
  Future<void> initState() {
    super.initState();
  }

  Future<bool> _onWillPop() async {
    Modular.to.pop();
    if (widget.otherOptions) Modular.to.pop();
    await bloc
        .getInterventionDetail(bloc.interventionDetail.interventionDetail.uuid);
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        key: _scaffoldKey,
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: Container(
            color: AppColors.white,
            height: double.infinity,
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
        Expanded(
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: AppConstants.default_padding,
                vertical: AppConstants.default_padding * 2),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.message,
                  style: AppStyles.body,
                ),
                SizedBox(height: 15),
                widget.status
                    ? SvgPicture.asset(
                        AppImages.succes,
                      )
                    : Image.asset(AppImages.message),
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
                      child: Text(
                        "TERMINER",
                        style: AppStyles.buttonTextWhite,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                  onPressed: () {
                    _onWillPop();
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
              ],
            ),
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
              _onWillPop();
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
          vertical: AppConstants.default_padding),
      decoration: BoxDecoration(color: AppColors.md_light_gray),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Paiement",
            style: AppStyles.largeTextBoldDefaultBlack,
          ),
        ],
      ),
    );
  }
}
