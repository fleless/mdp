import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mdp/constants/app_colors.dart';
import 'package:mdp/constants/app_constants.dart';
import 'package:mdp/constants/app_images.dart';
import 'package:mdp/constants/styles/app_styles.dart';
import 'package:mdp/models/message.dart';
import 'package:mdp/ui/interventions/commande/detail_commande/messagerie/messagerie_bloc.dart';

class SendMessageDialog extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SendMessageDialogState();
}

class _SendMessageDialogState extends State<SendMessageDialog> {
  final bloc = Modular.get<MessagerieBloc>();
  final TextEditingController _messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  "Envoyer un message",
                  style: AppStyles.header1,
                  textAlign: TextAlign.left,
                  overflow: TextOverflow.clip,
                  maxLines: 3,
                ),
              ),
              SizedBox(width: 20),
              InkWell(
                onTap: () {
                  Modular.to.pop();
                },
                child: Align(
                  alignment: Alignment.topRight,
                  child: Icon(
                    Icons.close_outlined,
                    size: 25,
                    color: AppColors.closeDialogColor,
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 15),
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.white,
                border: Border.all(
                  color: AppColors.md_gray,
                  width: 1,
                ),
              ),
              width: double.infinity,
              height: 200,
              child: Align(
                alignment: Alignment.topLeft,
                child: TextFormField(
                  controller: _messageController,
                  obscureText: false,
                  cursorColor: AppColors.default_black,
                  keyboardType: TextInputType.multiline,
                  expands: true,
                  maxLines: null,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.only(
                        bottom: 10.0, left: 10.0, right: 10.0, top: 10.0),
                    errorStyle: TextStyle(height: 0),
                    hintText: "Écrire votre message ...",
                    hintStyle: AppStyles.textNormalPlaceholder,
                  ),
                  style: AppStyles.textNormal,
                  validator: (String value) {},
                ),
              ),
            ),
          ),
          ElevatedButton(
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
                child: Text(
                  "ENVOYER",
                  style: AppStyles.smallTitleWhite,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
            onPressed: () async {
              if (_messageController.text.trim().isNotEmpty) {
                Modular.to.pop();
                Timer timer = Timer(
                    Duration(milliseconds: AppConstants.TIMER_DIALOG), () {
                  Modular.to.pop();
                });
                showDialog(
                    context: context,
                    builder: (context) {
                      return StatefulBuilder(builder:
                          (BuildContext context, StateSetter setState) {
                        return Dialog(
                          backgroundColor: AppColors.md_light_gray,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          child: _popUpMerci(),
                        );
                      });
                    }).then((value) {
                  // dispose the timer in case something else has triggered the dismiss.
                  timer?.cancel();
                  timer = null;
                });
                bloc.addingMessage.add(1);
                await Future.delayed(Duration(seconds: 1));
                bloc.listMessages.add(Message(DateTime.now().toString(),
                    "Isabelle R.", _messageController.text));
                bloc.addingMessage.add(0);
              }
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
    );
  }

  Widget _popUpMerci() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
              "Merci d'avoir contacté Mes Dépanneurs, nous avons bien pris en compte votre message.",
              style: AppStyles.header3,
              textAlign: TextAlign.center,
              maxLines: 10,
              overflow: TextOverflow.ellipsis),
          SvgPicture.asset(AppImages.message),
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
                  "FERMER",
                  style: AppStyles.buttonTextDarkBlue,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
            onPressed: () {
              Modular.to.pop();
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
}
