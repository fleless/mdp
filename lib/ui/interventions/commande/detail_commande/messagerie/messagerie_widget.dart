import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mdp/constants/app_colors.dart';
import 'package:mdp/constants/styles/app_styles.dart';
import 'package:mdp/models/message.dart';
import 'package:mdp/models/responses/messagerie_response.dart';
import 'package:mdp/ui/interventions/commande/detail_commande/messagerie/send_message_dialog.dart';
import 'package:mdp/ui/interventions/interventions_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

import 'messagerie_bloc.dart';

class MessagerieWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MessagerieWidgetState();
}

class _MessagerieWidgetState extends State<MessagerieWidget> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final bloc = Modular.get<MessagerieBloc>();
  final intervention_bloc = Modular.get<InterventionsBloc>();

  // when we add new message we use this boolean to load a loader until message approved in database
  bool messageReadyToAdd = false;

  @override
  void initState() {
    super.initState();
    bloc.initBloc();
    _loadMessages();
    bloc.addingMessage.stream.listen((event) {
      if (mounted) {
        setState(() {
          event == 1 ? messageReadyToAdd = true : messageReadyToAdd = false;
        });
      }
    });
  }

  _loadMessages() async {
    await bloc.getMessages(
        intervention_bloc.interventionDetail.interventionDetail.id.toString());
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
    return ListView.builder(
        itemCount: messageReadyToAdd
            ? bloc.listMessages.length + 3
            : bloc.listMessages.length + 2,
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return (index < bloc.listMessages.length)
              ? _buildMessageBloc(index, bloc.listMessages[index])
              : messageReadyToAdd
                  ? (index == bloc.listMessages.length)
                      ? _buildLoadingMessage(index)
                      : (index == bloc.listMessages.length + 1)
                          ? _buildButton()
                          : _buildContact()
                  : (index == bloc.listMessages.length)
                      ? _buildButton()
                      : _buildContact();
        });
  }

  Widget _buildMessageBloc(int index, ListOrderMessage message) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20),
      color: index % 2 == 0 ? AppColors.white : AppColors.md_gray,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  message.user == null
                      ? "Non défini"
                      : message.user.trim() == ""
                          ? "Non défini"
                          : message.user,
                  style: AppStyles.header2DarkBlue,
                ),
              ),
              SizedBox(width: 30),
              RichText(
                textAlign: TextAlign.left,
                maxLines: 10,
                overflow: TextOverflow.clip,
                text: TextSpan(
                  children: [
                    WidgetSpan(
                      child: FaIcon(FontAwesomeIcons.calendar,
                          size: 16, color: AppColors.md_text_light),
                    ),
                    TextSpan(
                        text: "  " +
                            message.created
                                .substring(0, message.created.length - 3),
                        style: AppStyles.smallGray),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 12),
          Text(
            message.body,
            style: AppStyles.textNormal,
            textAlign: TextAlign.left,
          ),
        ],
      ),
    );
  }

  Widget _buildLoadingMessage(int index) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20),
      color: index % 2 == 0 ? AppColors.white : AppColors.md_gray,
      child: Center(
        child: SizedBox(
          height: 25,
          width: 25,
          child: CircularProgressIndicator(
            backgroundColor: AppColors.default_black.withOpacity(0.25),
            valueColor: AlwaysStoppedAnimation(AppColors.default_black),
            strokeWidth: 2,
          ),
        ),
      ),
    );
  }

  Widget _buildButton() {
    return Container(
      width: double.infinity,
      color: AppColors.white,
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
      child: ElevatedButton(
        child: Ink(
          decoration: BoxDecoration(
            color: AppColors.md_dark_blue,
            borderRadius: BorderRadius.all(
              Radius.circular(12),
            ),
          ),
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 10),
            alignment: Alignment.center,
            width: double.infinity,
            height: 55,
            child: Text(
              "ENVOYER UN MESSAGE À MES DÉPANNEURS",
              style: AppStyles.smallTitleWhite,
              maxLines: 2,
              textAlign: TextAlign.center,
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
                    child: SendMessageDialog(),
                  );
                });
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
      ),
    );
  }

  _buildContact() {
    return Container(
      width: double.infinity,
      color: AppColors.md_gray,
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                Icons.question_answer_outlined,
                size: 22,
              ),
              SizedBox(width: 10),
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Besoin d'assistance ? \nContactez le Service Client de MesDépanneurs.fr",
                    textAlign: TextAlign.start,
                    maxLines: 5,
                    overflow: TextOverflow.ellipsis,
                    style: AppStyles.bodyBold,
                  ),
                  SizedBox(height: 10),
                  GestureDetector(
                    onTap: () => _callPhone("0975187496"),
                    child: Text(
                      "Tél : 09 75 18 74 96",
                      textAlign: TextAlign.start,
                      maxLines: 5,
                      overflow: TextOverflow.ellipsis,
                      style: AppStyles.largeTextBoldDarkBlue,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "Tous les jours 8h30 - 19h30",
                    textAlign: TextAlign.start,
                    maxLines: 5,
                    overflow: TextOverflow.ellipsis,
                    style: AppStyles.body,
                  ),
                ],
              )),
            ],
          ),
        ],
      ),
    );
  }

  void _callPhone(String numero) async => await canLaunch("tel:" + numero)
      ? await launch("tel:" + numero)
      : throw 'Could not launch';
}
