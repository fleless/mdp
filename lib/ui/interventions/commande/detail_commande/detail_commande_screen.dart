import 'package:contained_tab_bar_view/contained_tab_bar_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mdp/constants/app_colors.dart';
import 'package:mdp/constants/app_constants.dart';
import 'package:mdp/constants/styles/app_styles.dart';
import 'package:mdp/ui/interventions/commande/detail_commande/client/client_widget.dart';
import 'package:mdp/ui/interventions/commande/detail_commande/messagerie/messagerie_widget.dart';

class DetailCommandeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _DetailCommandeScreenState();
}

class _DetailCommandeScreenState extends State<DetailCommandeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  int indexTab = 0;

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
    return Column(
      children: [
        _buildTitle(),
        Expanded(
          child: _buildTab(),
        ),
      ],
    );
  }

  Widget _buildTitle() {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: AppConstants.default_padding,
          vertical: AppConstants.default_padding),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Intervention n° FR-6DH3",
            style: AppStyles.header1,
            textAlign: TextAlign.left,
            overflow: TextOverflow.clip,
            maxLines: 2,
          ),
          InkWell(
            onTap: () {
              Modular.to.pop();
            },
            child: Icon(
              Icons.close_outlined,
              size: 25,
              color: AppColors.closeDialogColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTab() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      color: AppColors.md_light_gray,
      width: double.infinity,
      height: double.infinity,
      child: ContainedTabBarView(
          tabBarProperties: TabBarProperties(
              padding: EdgeInsets.only(left: 10, right: 10, bottom: 0.5),
              indicatorWeight: 2.0,
              indicatorColor: AppColors.md_primary,
              background: Container(
                decoration: BoxDecoration(
                  border:
                      Border(bottom: BorderSide(color: AppColors.placeHolder)),
                ),
              )),
          tabs: [
            Text('Client',
                style: indexTab == 0
                    ? AppStyles.subTitleBlack
                    : AppStyles.subheadingBlack),
            Text('Intervention',
                style: indexTab == 1
                    ? AppStyles.subTitleBlack
                    : AppStyles.subheadingBlack),
            Text('Messagerie',
                style: indexTab == 2
                    ? AppStyles.subTitleBlack
                    : AppStyles.subheadingBlack),
          ],
          views: [
            ClientWidget(),
            Container(color: Colors.green),
            MessagerieWidget(),
          ],
          callOnChangeWhileIndexIsChanging: true,
          onChange: (index) => setState(() {
                indexTab = index;
              })),
    );
  }
}
