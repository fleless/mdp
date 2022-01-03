import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mdp/constants/app_colors.dart';
import 'package:mdp/constants/routes.dart';
import 'package:mdp/constants/styles/app_styles.dart';

class BottomNavbar extends StatefulWidget {
  final String route;

  const BottomNavbar({this.route});

  @override
  _BottomNavbarState createState() => _BottomNavbarState();
}

class _BottomNavbarState extends State<BottomNavbar> {
  final double iconSize = 20;
  final double minWidthIcon = 65;

  void _navigateTo(String route, [Object args]) {
    if (ModalRoute.of(context).settings.name != route) {
      Modular.to.pushNamed(route,
          arguments: {"uuidIntervention": null, "uuidCompetition": null});
    }
  }

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: Colors.white,
      child: Container(
        height: 75,
        padding: const EdgeInsets.only(bottom: 10),
        decoration: const BoxDecoration(
          color: AppColors.md_dark_blue,
          boxShadow: [
            BoxShadow(
              color: AppColors.md_dark_blue,
              blurRadius: 15.0,
              offset: Offset(0, 10),
            )
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _buildDashboardIcon(widget.route == Routes.home),
                Text(
                  'Dashboard',
                  style: widget.route == Routes.home
                      ? AppStyles.navBarTitle
                      : AppStyles.navBarTitle,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _buildCommandeIcon(widget.route == Routes.mesInterventions),
                Text(
                  'Interventions',
                  style: widget.route == Routes.mesInterventions
                      ? AppStyles.navBarTitle
                      : AppStyles.navBarTitle,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _buildCalendarIcon(widget.route == Routes.calendar),
                Text(
                  'Calendrier',
                  style: widget.route == Routes.calendar
                      ? AppStyles.navBarTitle
                      : AppStyles.navBarTitle,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _buildNotificationsIcon(widget.route == Routes.notifications),
                Text(
                  'Notifications',
                  style: widget.route == Routes.notifications
                      ? AppStyles.navBarTitle
                      : AppStyles.navBarTitle,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDashboardIcon(bool selected) => IconButton(
        icon: ConstrainedBox(
          constraints: BoxConstraints(minWidth: minWidthIcon),
          child: Icon(
            Icons.dashboard,
            color: AppColors.md_text_white,
            size: iconSize,
          ),
        ),
        onPressed: () => _navigateTo(Routes.home),
      );

  Widget _buildCommandeIcon(bool selected) => IconButton(
        icon: ConstrainedBox(
          constraints: BoxConstraints(minWidth: minWidthIcon),
          child: FaIcon(
            FontAwesomeIcons.hammer,
            color: AppColors.md_text_white,
            size: iconSize,
          ),
        ),
        onPressed: () => _navigateTo(Routes.mesInterventions),
      );

  Widget _buildCalendarIcon(bool selected) => IconButton(
        icon: ConstrainedBox(
          constraints: BoxConstraints(minWidth: minWidthIcon),
          child: Icon(
            Icons.today,
            color: AppColors.md_text_white,
            size: iconSize,
          ),
        ),
        onPressed: () => _navigateTo(Routes.calendar),
      );

  Widget _buildNotificationsIcon(bool selected) => IconButton(
        icon: ConstrainedBox(
          constraints: BoxConstraints(minWidth: minWidthIcon),
          child: Icon(
            Icons.notifications,
            color: AppColors.md_text_white,
            size: iconSize,
          ), //AppIcons.home(color: selected ? AppColors.green : AppColors.iconDefault),
        ),
        onPressed: () => _navigateTo(Routes.notifications),
      );
}
