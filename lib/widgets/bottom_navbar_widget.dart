import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mdp/constants/app_colors.dart';
import 'package:mdp/constants/routes.dart';

class BottomNavbar extends StatefulWidget {
  final String route;

  const BottomNavbar({this.route});

  @override
  _BottomNavbarState createState() => _BottomNavbarState();
}

class _BottomNavbarState extends State<BottomNavbar> {
  void _navigateTo(String route, [Object args]) {
    if (ModalRoute.of(context).settings.name != route) {
      Modular.to.pushReplacementNamed(route, arguments: args);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: Colors.transparent,
      child: Container(
        height: 60,
        padding: const EdgeInsets.only(bottom: 10),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25), topRight: Radius.circular(25)),
          boxShadow: [
            BoxShadow(
              blurRadius: 15.0,
              offset: Offset(0, 10),
            )
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            _buildHomeIcon(widget.route == Routes.home),
            _buildStartedIcon(widget.route == Routes.mesInterventions),
            _buildMyAuctionsIcon(widget.route == Routes.home),
            _buildWinnersIcon(widget.route == Routes.home),
          ],
        ),
      ),
    );
  }

  Widget _buildHomeIcon(bool selected) => IconButton(
        iconSize: 20,
        icon: ConstrainedBox(
          constraints: const BoxConstraints(minWidth: 50.0),
          child: FaIcon(
            FontAwesomeIcons.home,
            color: selected? AppColors.default_black : AppColors.default_black,
          ), //AppIcons.home(color: selected ? AppColors.green : AppColors.iconDefault),
        ),
        onPressed: () => _navigateTo(Routes.home),
      );

  Widget _buildStartedIcon(bool selected) => IconButton(
    iconSize: 20,
    icon: ConstrainedBox(
      constraints: const BoxConstraints(minWidth: 50.0),
      child: FaIcon(
        FontAwesomeIcons.broadcastTower,
        color: selected? AppColors.default_black : AppColors.default_black,
      ), //AppIcons.home(color: selected ? AppColors.green : AppColors.iconDefault),
    ),
    onPressed: () => _navigateTo(Routes.mesInterventions),
  );

  Widget _buildMyAuctionsIcon(bool selected) => IconButton(
    iconSize: 20,
    icon: ConstrainedBox(
      constraints: const BoxConstraints(minWidth: 50.0),
      child: FaIcon(
        FontAwesomeIcons.gavel,
        color: selected? AppColors.default_black : AppColors.default_black,
      ), //AppIcons.home(color: selected ? AppColors.green : AppColors.iconDefault),
    ),
    onPressed: () => _navigateTo(Routes.home),
  );

  Widget _buildWinnersIcon(bool selected) => IconButton(
    iconSize: 20,
    icon: ConstrainedBox(
      constraints: const BoxConstraints(minWidth: 50.0),
      child: FaIcon(
        FontAwesomeIcons.trophy,
        color: selected? AppColors.default_black : AppColors.default_black,
      ), //AppIcons.home(color: selected ? AppColors.green : AppColors.iconDefault),
    ),
    onPressed: () => _navigateTo(Routes.home),
  );

}
