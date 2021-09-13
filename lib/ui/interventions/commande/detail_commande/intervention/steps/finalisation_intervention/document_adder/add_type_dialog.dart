import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mdp/constants/app_colors.dart';
import 'package:mdp/constants/app_constants.dart';
import 'package:mdp/constants/app_images.dart';
import 'package:mdp/constants/styles/app_styles.dart';
import 'package:mdp/models/message.dart';
import 'package:mdp/models/responses/add_message_response.dart';
import 'package:mdp/ui/interventions/commande/detail_commande/intervention/steps/finalisation_intervention/finalisation_intervention_bloc.dart';
import 'package:mdp/ui/interventions/commande/detail_commande/messagerie/messagerie_bloc.dart';
import 'package:mdp/ui/interventions/interventions_bloc.dart';

class AddTypeDialog extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _AddTypeDialogState();
}

class _AddTypeDialogState extends State<AddTypeDialog> {
  final bloc = Modular.get<InterventionsBloc>();
  final _finalisationInterventionBloc =
      Modular.get<FinalisationInterventionBloc>();
  final TextEditingController _messageController = TextEditingController();
  GlobalKey<FormState> formKey = new GlobalKey();
  bool _loading = false;

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
                  "Saisir un nouveau type",
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
              child: Align(
                alignment: Alignment.topLeft,
                child: Form(
                  key: formKey,
                  child: TextFormField(
                    controller: _messageController,
                    obscureText: false,
                    cursorColor: AppColors.default_black,
                    keyboardType: TextInputType.text,
                    maxLines: 1,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      errorBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: AppColors.mdAlert, width: 1),
                      ),
                      contentPadding: EdgeInsets.only(
                          bottom: 10.0, left: 10.0, right: 10.0, top: 10.0),
                      errorStyle: TextStyle(height: 0),
                      hintText: "Écrire votre nouveau type ...",
                      hintStyle: AppStyles.textNormalPlaceholder,
                    ),
                    style: AppStyles.textNormal,
                    onChanged: (value) => formKey.currentState.validate(),
                    validator: (String value) => (value.trim().isEmpty)
                        ? 'Le nom de type ne peut pas être vide'
                        : null,
                  ),
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
                child: _loading
                    ? Center(
                        child: CircularProgressIndicator(
                          color: AppColors.white,
                        ),
                      )
                    : Text(
                        "AJOUTER",
                        style: AppStyles.smallTitleWhite,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
              ),
            ),
            onPressed: () async {
              if (!_loading) {
                setState(() {
                  _loading = true;
                });
                if (formKey.currentState.validate()) {
                  bool valid = await _finalisationInterventionBloc
                      .addTypeDocument(_messageController.text);
                  if (valid) await bloc.getTypesDocuments();
                  _finalisationInterventionBloc.docChangesNotifier.add(true);
                  setState(() {
                    _loading = false;
                  });
                  Modular.to.pop();
                }
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
}
