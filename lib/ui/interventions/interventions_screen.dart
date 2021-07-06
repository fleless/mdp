import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mdp/constants/app_colors.dart';
import 'package:mdp/constants/app_constants.dart';
import 'package:mdp/constants/routes.dart';
import 'package:mdp/constants/styles/app_styles.dart';
import 'package:mdp/models/interventions.dart';
import 'package:mdp/models/responses/show_intervention_response.dart';
import 'package:mdp/ui/interventions/commande/nouvelle_commande/proposition_comande.dart';
import 'package:mdp/widgets/bottom_navbar_widget.dart';
import 'package:mdp/widgets/gradients/md_gradient_light.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class InterventionsScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _InterventionsScreenState();
}

class _InterventionsScreenState extends State<InterventionsScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final _searchController = TextEditingController();
  List<InterventionsClass> _interventions = <InterventionsClass>[];

  @override
  Future<void> initState() {
    _fillIntervention();
    super.initState();
  }

  _fillIntervention() {
    _interventions.add(InterventionsClass(
        "FR-6DH3",
        "Urgence",
        true,
        "SERR37",
        "Fourniture et pose serrure 3 points standard",
        "Marc DUPUIS",
        "78000 Versailles"));
    _interventions.add(InterventionsClass(
        "FR-6DH3",
        "Dépannage",
        false,
        "SERR37",
        "Fourniture et pose serrure 3 points standard",
        "Marc DUPUIS",
        "78000 Versailles"));
    _interventions.add(InterventionsClass(
        "FR-6DH3",
        "Travaux",
        false,
        "SERR37",
        "Fourniture et pose serrure 3 points standard",
        "Marc DUPUIS",
        "78000 Versailles"));
    _interventions.add(InterventionsClass(
        "FR-6DH3",
        "Confort",
        false,
        "SERR37",
        "Fourniture et pose serrure 3 points standard",
        "Marc DUPUIS",
        "78000 Versailles"));
    _interventions.add(InterventionsClass(
        "FR-6DH3",
        "Dépannage",
        false,
        "SERR37",
        "Fourniture et pose serrure 3 points standard",
        "Marc DUPUIS",
        "78000 Versailles"));
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
      backgroundColor: AppColors.white,
      //drawer: DrawerWidget(),
      body: SafeArea(
        child: Container(
          height: double.infinity,
          child: _buildContent(),
        ),
      ),
      //LoadingIndicator(loading: _bloc.loading),
      //NetworkErrorMessages(error: _bloc.error),
      bottomNavigationBar: const BottomNavbar(route: Routes.mesInterventions),
    );
  }

  Widget _fakeButton() {
    return Container(
      width: double.infinity,
      height: 60,
      child: Center(
        child: ElevatedButton(
          child: Text("OUPS!",
              style: AppStyles.textNormal,
              overflow: TextOverflow.ellipsis,
              maxLines: 1),
          onPressed: () {
            showCupertinoModalBottomSheet(
              context: context,
              expand: false,
              enableDrag: true,
              builder: (context) => PropositionCommandeWidget(),
            );
          },
          style: ElevatedButton.styleFrom(
              elevation: 3,
              onPrimary: AppColors.defaultColor,
              primary: AppColors.white,
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
              textStyle: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
        ),
      ),
    );
  }

  Widget _buildContent() {
    return Column(
      children: [
        _buildTitle(),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(AppConstants.default_padding),
            child: _buildBody(),
          ),
        ),
      ],
    );
  }

  Widget _buildBody() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildFilters(),
        SizedBox(height: 40),
        _fakeButton(),
        Text(_interventions.length.toString() + " résultats",
            style: AppStyles.bodyBoldMdDarkBlue),
        Expanded(
          child: _buildList(),
        ),
      ],
    );
  }

  Widget _buildTitle() {
    return Container(
      decoration: BoxDecoration(
        gradient: MdGradientLightt(),
      ),
      child: Padding(
        padding: EdgeInsets.only(
            left: AppConstants.default_padding,
            right: AppConstants.default_padding,
            bottom: AppConstants.default_padding * 2,
            top: AppConstants.default_padding * 2),
        child: Container(
            alignment: Alignment.centerLeft,
            child: Text(
              "Mes interventions",
              style: AppStyles.headerWhite,
            )),
      ),
    );
  }

  Widget _buildFilters() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 10),
        _buildSearchBy(),
        SizedBox(height: 10),
        _buildSearchByStatus(),
        SizedBox(height: 10),
        _buildSearchByActivity(),
      ],
    );
  }

  Widget _buildSearchBy() {
    return Padding(
      padding: EdgeInsets.only(right: 0),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.md_dark_blue, width: 1.5),
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          // If you want align text to left
          mainAxisSize: MainAxisSize.max,
          children: [
            Flexible(
              child: GestureDetector(
                onTap: () => {},
                child: Container(
                  height: 45,
                  decoration: new BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(5),
                        bottomLeft: Radius.circular(5)),
                    border: Border.all(color: AppColors.white),
                  ),
                  child: Center(
                    child: TextField(
                      controller: _searchController,
                      enabled: true,
                      style: AppStyles.bodyDefaultBlack,
                      textAlign: TextAlign.left,
                      textAlignVertical: TextAlignVertical.center,
                      cursorColor: AppColors.md_dark_blue,
                      decoration: InputDecoration(
                        hintText: "Rechercher par nom, numéro ...",
                        hintStyle: AppStyles.bodyHint,
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.only(left: 8.0, top: -35.0),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            InkWell(
              onTap: () async {},
              child: Container(
                decoration: new BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(5),
                      bottomRight: Radius.circular(5)),
                  border: Border.all(color: AppColors.white),
                ),
                width: 45,
                height: 45,
                child: Center(
                  child: FaIcon(
                    FontAwesomeIcons.search,
                    color: AppColors.md_dark_blue,
                    size: 20,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchByStatus() {
    return Container(
      height: 45,
      child: Theme(
        // Create a unique theme with "ThemeData"
        data: ThemeData(
          primarySwatch: AppColors.defaultColorMaterial,
        ),
        child: DropdownSearch<String>(
            searchBoxDecoration: null,
            dropdownSearchDecoration: null,
            mode: Mode.MENU,
            showSelectedItem: true,
            popupSafeArea: PopupSafeArea(top: false),
            items: ["Toutes", "Terminée", "En cours", "À réaliser", "Annulée"],
            label: "",
            hint: "Statut des interventions",
            onChanged: (value) {},
            selectedItem: "Toutes"),
      ),
    );
  }

  Widget _buildSearchByActivity() {
    return Container(
      height: 45,
      child: Theme(
        // Create a unique theme with "ThemeData"
        data: ThemeData(
          primarySwatch: AppColors.defaultColorMaterial,
        ),
        child: DropdownSearch<String>(
            searchBoxDecoration: null,
            dropdownSearchDecoration: null,
            mode: Mode.MENU,
            showSelectedItem: true,
            popupSafeArea: PopupSafeArea(top: false),
            items: [
              "Tous les types d'activités",
              "Urgence",
              "Dépannage",
              "Travaux",
              "Confort"
            ],
            label: "",
            hint: "Statut des interventions",
            onChanged: (value) {},
            selectedItem: "Tous les types d'activités"),
      ),
    );
  }

  Widget _buildList() {
    return Container(
      child: ListView.builder(
          itemCount: _interventions.length,
          itemBuilder: (context, index) {
            return Card(
              clipBehavior: Clip.antiAlias,
              elevation: 3,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: Container(
                color: AppColors.md_light_gray,
                padding: EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Expanded(
                            child: Text(
                          _interventions[index].reference,
                          style: AppStyles.bodyBoldMdDarkBlue,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        )),
                        Container(
                          padding: EdgeInsets.all(6),
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              color:
                                  _interventions[index].statut.contains("gence")
                                      ? AppColors.mdAlert
                                      : _interventions[index]
                                              .statut
                                              .contains("nage")
                                          ? AppColors.travaux
                                          : _interventions[index]
                                                  .statut
                                                  .contains("vaux")
                                              ? AppColors.amenagement
                                              : AppColors.plomberie),
                          child: Text(
                            _interventions[index].statut,
                            style: AppStyles.buttonTextWhite,
                          ),
                        ),
                        IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.close,
                              color: AppColors.default_black,
                            ))
                      ],
                    ),
                    _interventions[index].action
                        ? Container(
                            padding: EdgeInsets.all(3),
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                                color: AppColors.mdAlert),
                            child: Text(
                              "Action requise",
                              style: AppStyles.buttonTextWhite,
                            ),
                          )
                        : SizedBox.shrink(),
                    SizedBox(height: 20),
                    Text(
                      _interventions[index].order,
                      style: AppStyles.bodyDefaultBlack,
                    ),
                    Text(
                      _interventions[index].orderMessage,
                      style: AppStyles.bodyDefaultBlack,
                    ),
                    SizedBox(height: 10),
                    Text(
                      _interventions[index].name,
                      style: AppStyles.bodyDefaultBlack,
                    ),
                    Text(
                      _interventions[index].adresse,
                      style: AppStyles.bodyDefaultBlack,
                    )
                  ],
                ),
              ),
            );
          }),
    );
  }
}
