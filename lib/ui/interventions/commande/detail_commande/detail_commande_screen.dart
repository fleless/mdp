import 'package:contained_tab_bar_view/contained_tab_bar_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mdp/constants/app_colors.dart';
import 'package:mdp/constants/app_constants.dart';
import 'package:mdp/constants/styles/app_styles.dart';
import 'package:mdp/ui/interventions/commande/detail_commande/client/client_widget.dart';
import 'package:mdp/ui/interventions/commande/detail_commande/intervention/intervention_widget.dart';
import 'package:mdp/ui/interventions/commande/detail_commande/intervention/steps/readction_devis/redaction_devis_bloc.dart';
import 'package:mdp/ui/interventions/commande/detail_commande/messagerie/messagerie_widget.dart';
import 'package:mdp/ui/interventions/interventions_bloc.dart';
import 'package:mdp/ui/interventions/interventions_screen.dart';
import 'package:mdp/widgets/gradients/md_gradient_light.dart';

class DetailCommandeScreen extends StatefulWidget {
  String uuid;

  DetailCommandeScreen(this.uuid);

  @override
  State<StatefulWidget> createState() => _DetailCommandeScreenState();
}

class _DetailCommandeScreenState extends State<DetailCommandeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  GlobalKey<ContainedTabBarViewState> _key = GlobalKey();
  int indexTab = 0;
  final bloc = Modular.get<InterventionsBloc>();
  final _redactionBloc = Modular.get<RedactionDevisBloc>();
  bool _loading = false;

  @override
  Future<void> initState() {
    _getDetails();
    setState(() {
      indexTab = 1;
    });
    super.initState();
  }

  _getDetails() async {
    setState(() {
      _loading = true;
    });
    await bloc.getInterventionDetail(widget.uuid);
    //load all datas to use specially in designation
    await bloc.getDesignationsName();
    await bloc.getMaterials();
    await bloc.getUnits();
    await bloc.getMainDeplacement();
    await bloc.getTypesDocuments();
    await setState(() {
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(gradient: MdGradientLightt()),
          height: double.infinity,
          child: _buildContent(),
        ),
      ),
    );
  }

  Widget _buildContent() {
    return Column(
      children: [
        _buildTitle(),
        Expanded(
          child: _loading
              ? Center(
                  child: CircularProgressIndicator(
                    color: AppColors.md_dark_blue,
                  ),
                )
              : _buildTab(),
        ),
      ],
    );
  }

  Widget _buildTitle() {
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
                    text: "Intervention n° ", style: AppStyles.header1White),
                TextSpan(
                    text: _loading
                        ? ""
                        : bloc.interventionDetail.interventionDetail.code,
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

  Widget _buildTab() {
    return Container(
      padding: const EdgeInsets.only(top: 8.0),
      color: Colors.transparent,
      width: double.infinity,
      height: double.infinity,
      child: ContainedTabBarView(
          key: _key,
          initialIndex: 1,
          tabBarProperties: TabBarProperties(
              padding: EdgeInsets.only(left: 10, right: 10, bottom: 0.5),
              indicatorWeight: 3.0,
              indicatorColor: AppColors.white,
              background: Container(
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  border:
                      Border(bottom: BorderSide(color: AppColors.placeHolder)),
                ),
              )),
          tabs: [
            Text('Client',
                style: indexTab == 0
                    ? AppStyles.subheadingWhiteBold
                    : AppStyles.subheadingWhite),
            Text('Intervention',
                style: indexTab == 1
                    ? AppStyles.subheadingWhiteBold
                    : AppStyles.subheadingWhite),
            Text('Messagerie',
                style: indexTab == 2
                    ? AppStyles.subheadingWhiteBold
                    : AppStyles.subheadingWhite),
          ],
          views: [
            ClientWidget(),
            InterventionWidget(),
            MessagerieWidget(),
          ],
          callOnChangeWhileIndexIsChanging: true,
          onChange: (index) => setState(() {
                indexTab = index;
              })),
    );
  }
}
