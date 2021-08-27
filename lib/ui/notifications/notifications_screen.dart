import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mdp/constants/app_colors.dart';
import 'package:mdp/constants/app_constants.dart';
import 'package:mdp/constants/routes.dart';
import 'package:mdp/constants/styles/app_styles.dart';
import 'package:mdp/models/notifications.dart';
import 'package:mdp/widgets/bottom_navbar_widget.dart';
import 'package:mdp/widgets/gradients/md_gradient_light.dart';

class NotificationsScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  List<Notifications> _notifications = <Notifications>[];

  @override
  void initState() {
    _fakeList();
    _fakeList();
    _fakeList();
    _fakeList();
    _fakeList();
    super.initState();
  }

  _fakeList() {
    _notifications.add(Notifications(
        AppColors.mdAlert, "FR-Nouveau", "Vous avez une nouvelle demande"));
    _notifications.add(Notifications(
        AppColors.md_secondary, "FR-DE6HR", "Dans 1h intervention"));
    _notifications.add(Notifications(AppColors.md_secondary, "FR-DE6HR",
        "Vous avez une action à effectuer: Réaliser le devis"));
    _notifications.add(
        Notifications(AppColors.md_secondary, "FR-DE6HR", "Nouveau message"));
    _notifications.add(Notifications(
        AppColors.md_dark_blue, "Alerte", "Merci de bien vouloir XXX"));
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
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                gradient: MdGradientLightt(),
              ),
              child: _buildTitle(),
            ),
            Expanded(
              child: _buildList(),
            ),
          ],
        ),
      )),
      //LoadingIndicator(loading: _bloc.loading),
      //NetworkErrorMessages(error: _bloc.error),
      bottomNavigationBar: const BottomNavbar(route: Routes.notifications),
    );
  }

  Widget _buildTitle() {
    return Padding(
      padding: EdgeInsets.only(
          left: AppConstants.default_padding,
          right: AppConstants.default_padding,
          bottom: AppConstants.default_padding * 1.3,
          top: AppConstants.default_padding * 1.3),
      child: Container(
          alignment: Alignment.centerLeft,
          child: Text(
            "Notifications",
            style: AppStyles.headerWhite,
          )),
    );
  }

  Widget _buildList() {
    return Container(
      padding: EdgeInsets.all(AppConstants.default_padding),
      child: ListView.builder(
        itemCount: _notifications.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.only(bottom: 10),
            child: Card(
              clipBehavior: Clip.antiAlias,
              elevation: 3,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: Container(
                color: AppColors.md_light_gray,
                padding: EdgeInsets.all(20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: Icon(
                        Icons.circle,
                        color: _notifications[index].color,
                      ),
                    ),
                    SizedBox(width: 20),
                    Expanded(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(_notifications[index].message,
                              style: AppStyles.bodyDefaultBlack),
                          SizedBox(height: 5),
                          Text(_notifications[index].description,
                              style: _notifications[index].color ==
                                      AppColors.mdAlert
                                  ? AppStyles.alertNotification
                                  : AppStyles.bodyBoldMdDarkBlue),
                        ],
                      ),
                    ),
                    SizedBox(width: 20),
                    Align(
                      alignment: Alignment.topRight,
                      child: Icon(
                        Icons.close,
                        size: 20,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
