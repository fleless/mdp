import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:mdp/constants/app_colors.dart';
import 'package:mdp/constants/styles/app_styles.dart';
import 'package:mdp/models/responses/add_new_material_response.dart';
import 'package:mdp/models/responses/get_materials_response.dart';
import 'package:mdp/models/responses/show_intervention_response.dart';
import 'package:mdp/models/workload_model.dart';
import 'package:mdp/ui/interventions/commande/detail_commande/intervention/steps/readction_devis/screens/fournitures/add_update_fourniture.dart';
import 'package:mdp/ui/interventions/commande/detail_commande/intervention/steps/readction_devis/screens/fournitures/add_new_fourniture_dialog.dart';
import 'package:mdp/ui/interventions/commande/detail_commande/intervention/steps/readction_devis/screens/mainDepacement/add_update_mainDeplacement.dart';
import "dart:ui" as ui;
import '../../../../../../../interventions_bloc.dart';
import '../../redaction_devis_bloc.dart';

class ShowMainDeplacementDialogWidget extends StatefulWidget {
  ShowMainDeplacementDialogWidget();

  @override
  State<StatefulWidget> createState() =>
      _ShowMainDeplacementDialogWidgetState();
}

class _ShowMainDeplacementDialogWidgetState
    extends State<ShowMainDeplacementDialogWidget> {
  final bloc = Modular.get<InterventionsBloc>();
  final _redactionBloc = Modular.get<RedactionDevisBloc>();
  GlobalKey<FormState> formKey = new GlobalKey();
  ListWorkload selectedMainDeplacement;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text("Choisir un élément",
                      style: AppStyles.uniformRoundedHeader),
                ),
                IconButton(
                  onPressed: () {
                    Modular.to.pop();
                  },
                  icon: Icon(
                    Icons.close,
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            _redactionBloc.liste_mainsDeplacement
                        .where((element) =>
                            element.workchange_id ==
                            bloc.liste_mainDeplacement[0].id)
                        .toList()
                        .length >
                    0
                ? SizedBox.shrink()
                : _buildMain(),
            SizedBox(height: 5),
            _redactionBloc.liste_mainsDeplacement
                        .where((element) =>
                            element.workchange_id ==
                            bloc.liste_mainDeplacement[1].id)
                        .toList()
                        .length >
                    0
                ? SizedBox.shrink()
                : _buildDeplacement(),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildMain() {
    return Card(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      elevation: 3,
      child: InkWell(
        splashColor: AppColors.md_dark_blue,
        onTap: () {
          selectedMainDeplacement = bloc.liste_mainDeplacement[0];
          Modular.to.pop();
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
                    child: AddUpdateMainDeplacementDialog(
                        selectedMainDeplacement,
                        true,
                        WorkLoadModel( 0, "", "", "", "")),
                  );
                });
              });
        },
        child: Container(
          padding: EdgeInsets.all(20),
          color: AppColors.white,
          alignment: Alignment.centerLeft,
          child: Text(
            bloc.liste_mainDeplacement[0].type,
            style: AppStyles.bodyDefaultBlack,
          ),
        ),
      ),
    );
  }

  Widget _buildDeplacement() {
    return Card(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      elevation: 3,
      child: InkWell(
        splashColor: AppColors.md_dark_blue,
        onTap: () {
          selectedMainDeplacement = bloc.liste_mainDeplacement[1];
          Modular.to.pop();
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
                    child: AddUpdateMainDeplacementDialog(
                        selectedMainDeplacement,
                        true,
                        WorkLoadModel( 0, "", "", "", "")),
                  );
                });
              });
        },
        child: Container(
          padding: EdgeInsets.all(20),
          color: AppColors.white,
          alignment: Alignment.centerLeft,
          child: Text(
            bloc.liste_mainDeplacement[1].type,
            style: AppStyles.bodyDefaultBlack,
          ),
        ),
      ),
    );
  }
}
