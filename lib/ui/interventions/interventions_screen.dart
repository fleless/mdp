import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mdp/constants/app_colors.dart';
import 'package:mdp/constants/app_constants.dart';
import 'package:mdp/constants/endpoints.dart';
import 'package:mdp/constants/routes.dart';
import 'package:mdp/constants/styles/app_styles.dart';
import 'package:mdp/models/responses/get_interventions.dart' as interventions;
import 'package:mdp/ui/interventions/commande/nouvelle_commande/proposition_comande.dart';
import 'package:mdp/widgets/bottom_navbar_widget.dart';
import 'package:mdp/widgets/gradients/md_gradient_light.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import 'interventions_bloc.dart';

class InterventionsScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _InterventionsScreenState();
}

class _InterventionsScreenState extends State<InterventionsScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final _searchController = TextEditingController();
  bool _loading = false;
  final bloc = Modular.get<InterventionsBloc>();
  List<interventions.Interventions> _listeInterventions =
      <interventions.Interventions>[];

  @override
  Future<void> initState() {
    super.initState();
    _loadInterventions();
  }

  _loadInterventions() async {
    setState(() {
      _loading = true;
    });
    interventions.GetInterventionsResponse resp = await bloc.getInterventions(
        Endpoints.subcontractor_uuid,
        _searchController.text == null ? "" : _searchController.text);
    if (resp.interventions == null) {
      setState(() {
        _listeInterventions.clear();
      });
    } else {
      setState(() {
        _listeInterventions.clear();
        _listeInterventions.addAll(resp.interventions);
      });
    }
    setState(() {
      _loading = false;
    });
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
        Text(_listeInterventions.length.toString() + " résultats",
            style: AppStyles.bodyBoldMdDarkBlue),
        Expanded(
          child: _loading
              ? Container(
                  height: double.infinity,
                  width: double.infinity,
                  child: Center(
                    child: CircularProgressIndicator(
                        color: AppColors.md_dark_blue),
                  ),
                )
              : _buildList(),
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
            bottom: AppConstants.default_padding * 1.3,
            top: AppConstants.default_padding * 1.3),
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
              onTap: () async {
                _loadInterventions();
              },
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
          itemCount: _listeInterventions.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                Modular.to.pushNamed(Routes.detailCommande,
                    arguments: {"uuid": _listeInterventions[index].uuid});
              },
              child: Card(
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
                            _listeInterventions[index].code ?? "",
                            style: AppStyles.bodyBoldMdDarkBlue,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          )),
                          //TODo: wait api change for stats
                          /*Container(
                            padding: EdgeInsets.all(6),
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                                color: _listeInterventions[index]
                                        .statut
                                        .contains("gence")
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
                          ),*/
                        ],
                      ),
                      if (_listeInterventions[index].requiredAction != null)
                        _listeInterventions[index].requiredAction.isRequired
                            ? Container(
                                padding: EdgeInsets.all(7),
                                margin: EdgeInsets.only(top: 5, left: 1),
                                decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(12)),
                                    color: AppColors.mdAlert),
                                child: Text(
                                  "Action requise",
                                  style: AppStyles.buttonTextWhite,
                                ),
                              )
                            : SizedBox.shrink(),
                      SizedBox(height: 20),
                      Text(
                        _listeInterventions[index].details.length > 0
                            ? _listeInterventions[index]
                                .details
                                .first
                                .ordercase
                                .code
                            : "",
                        style: AppStyles.bodyDefaultBlack,
                      ),
                      Text(
                        _listeInterventions[index].details == null
                            ? ""
                            : _listeInterventions[index]
                                .details[0]
                                .ordercase
                                .name,
                        style: AppStyles.bodyDefaultBlack,
                      ),
                      SizedBox(height: 10),
                      Text(
                        (_listeInterventions[index].clients.firstname ?? "") +
                            " " +
                            (_listeInterventions[index].clients.lastname ?? ""),
                        style: AppStyles.bodyDefaultBlack,
                      ),
                      Text(
                        _listeInterventions[index].clients.addresses == null
                            ? ""
                            : ((_listeInterventions[index]
                                            .clients
                                            .addresses[0]
                                            .city ==
                                        null
                                    ? " "
                                    : _listeInterventions[index]
                                        .clients
                                        .addresses[0]
                                        .city
                                        .postcode) +
                                " " +
                                (_listeInterventions[index]
                                            .clients
                                            .addresses[0]
                                            .city ==
                                        null
                                    ? ""
                                    : _listeInterventions[index]
                                            .clients
                                            .addresses[0]
                                            .city
                                            .name ??
                                        "")),
                        style: AppStyles.bodyDefaultBlack,
                      )
                    ],
                  ),
                ),
              ),
            );
          }),
    );
  }
}
