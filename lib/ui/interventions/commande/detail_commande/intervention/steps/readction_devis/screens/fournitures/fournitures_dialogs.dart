import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mdp/constants/app_colors.dart';
import 'package:mdp/constants/styles/app_styles.dart';
import 'package:mdp/models/responses/add_new_material_response.dart';
import 'package:mdp/models/responses/get_materials_response.dart';
import 'package:mdp/models/responses/show_intervention_response.dart';
import 'package:mdp/models/workload_model.dart';
import 'package:mdp/ui/interventions/commande/detail_commande/intervention/steps/readction_devis/screens/fournitures/add_update_fourniture.dart';
import 'package:mdp/ui/interventions/commande/detail_commande/intervention/steps/readction_devis/screens/fournitures/add_new_fourniture_dialog.dart';
import "dart:ui" as ui;
import '../../../../../../../interventions_bloc.dart';
import '../../redaction_devis_bloc.dart';

class FournituresDialogWidget extends StatefulWidget {
  FournituresDialogWidget();

  @override
  State<StatefulWidget> createState() => _FournituresDialogWidgetState();
}

class _FournituresDialogWidgetState extends State<FournituresDialogWidget> {
  final bloc = Modular.get<InterventionsBloc>();
  final _redactionBloc = Modular.get<RedactionDevisBloc>();
  GlobalKey<FormState> formKey = new GlobalKey();
  TextEditingController _FournitureController = TextEditingController();
  ListWorkload selectedFourniture;

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
                  child: Text("Saisir un élément",
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
            Form(
              key: formKey,
              child: TypeAheadField(
                textFieldConfiguration: TextFieldConfiguration(
                    controller: _FournitureController,
                    cursorColor: AppColors.md_dark_blue,
                    autofocus: false,
                    style: AppStyles.textNormal,
                    decoration: InputDecoration(
                        fillColor: AppColors.white,
                        filled: true,
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: AppColors.md_dark_blue),
                        ),
                        border: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: AppColors.md_dark_blue)),
                        focusColor: AppColors.md_dark_blue,
                        labelText: 'Rechercher',
                        labelStyle: AppStyles.bodyHint)),
                keepSuggestionsOnLoading: true,
                suggestionsCallback: (pattern) => _listToShow(pattern),
                noItemsFoundBuilder: (value) {
                  return _buildAjouterElementButton();
                },
                itemBuilder: (context, suggestion) {
                  return Container(
                    padding: EdgeInsets.all(10),
                    child: Text(suggestion.name,
                        style: AppStyles.textNormal,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 3),
                  );
                },
                errorBuilder: (context, value) {},
                onSuggestionSelected: (suggestion) {
                  this._FournitureController.text = suggestion.name;
                  selectedFourniture = suggestion;
                  Modular.to.pop();
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
                            child: AddUpdateFournituresDialog(
                                selectedFourniture,
                                true,
                                WorkLoadModel(0, "", "", "", "")),
                          );
                        });
                      });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  //remove redunding : the designation can contains only one material from each id
  _listToShow(String pattern) {
    List<ListWorkload> resp = bloc.liste_materials
        .where((element) =>
            element.name.toUpperCase().contains(pattern.toUpperCase()))
        .toList();
    resp.removeWhere((element) => _redactionBloc.liste_materiel
        .where((el) => el.workchange_id == element.id)
        .isNotEmpty);
    return resp;
  }

  _buildAjouterElementButton() {
    return Container(
      padding: EdgeInsets.all(15),
      child: ElevatedButton(
        child: Ink(
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.all(
              Radius.circular(12),
            ),
          ),
          child: Container(
            alignment: Alignment.center,
            width: double.infinity,
            height: 55,
            child: DottedBorder(
              borderType: BorderType.RRect,
              radius: Radius.circular(12),
              padding: EdgeInsets.symmetric(vertical: 6, horizontal: 20),
              color: AppColors.md_tertiary,
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Icon(
                      Icons.add_circle_outline_outlined,
                      color: AppColors.md_tertiary,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 30),
                    child: Center(
                      child: Text(
                        "AJOUTER UN AUTRE ÉLÉMENT",
                        style: AppStyles.buttonTextTertiary,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        onPressed: () {
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
                    child: AddNewFournituresDialog(),
                  );
                });
              });
        },
        style: ElevatedButton.styleFrom(
            elevation: 5,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            onPrimary: AppColors.md_tertiary,
            primary: Colors.transparent,
            padding: EdgeInsets.zero,
            textStyle: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
      ),
    );
  }
}
