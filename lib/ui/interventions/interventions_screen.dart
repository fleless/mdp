import 'package:flutter/material.dart';
import 'package:mdp/constants/app_colors.dart';
import 'package:mdp/constants/routes.dart';
import 'package:mdp/constants/styles/app_styles.dart';
import 'package:mdp/ui/interventions/commande/nouvelle_commande/proposition_comande.dart';
import 'package:mdp/widgets/bottom_navbar_widget.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class InterventionsScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _InterventionsScreenState();
}

class _InterventionsScreenState extends State<InterventionsScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Future<void> initState() {
    super.initState();
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
      backgroundColor: AppColors.appBackground,
      //drawer: DrawerWidget(),
      body: SafeArea(
        child: Container(
          height: double.infinity,
          child: Container(
            width: double.infinity,
            height: double.infinity,
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
                    textStyle:
                        TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
              ),
            ),
          ),
        ),
      ),
      //LoadingIndicator(loading: _bloc.loading),
      //NetworkErrorMessages(error: _bloc.error),
      bottomNavigationBar: const BottomNavbar(route: Routes.mesInterventions),
    );
  }
}
