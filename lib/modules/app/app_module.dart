import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mdp/constants/routes.dart';
import 'package:mdp/ui/home/home_bloc.dart';
import 'package:mdp/ui/home/home_screen.dart';
import 'package:mdp/ui/interventions/commande/detail_commande/detail_commande_screen.dart';
import 'package:mdp/ui/interventions/commande/detail_commande/intervention/intervention_bloc.dart';
import 'package:mdp/ui/interventions/commande/detail_commande/intervention/steps/prise_rdv/screens/ajouter_rdv.dart';
import 'package:mdp/ui/interventions/commande/detail_commande/intervention/steps/prise_rdv/screens/calendrier_prise_rdv_screen.dart';
import 'package:mdp/ui/interventions/commande/detail_commande/messagerie/messagerie_bloc.dart';
import 'package:mdp/ui/interventions/interventions_bloc.dart';
import 'package:mdp/ui/interventions/interventions_screen.dart';
import 'package:mdp/ui/login/login_bloc.dart';
import 'package:mdp/ui/login/login_screen.dart';
import 'package:mdp/ui/profil/profil_screen.dart';
import 'package:mdp/ui/splash/splash_screen.dart';
import 'package:mdp/utils/user_location.dart';
import 'package:mdp/widgets/photo_view_screen.dart';
import 'app_widget.dart';

class AppModule extends MainModule {
  // Provide a list of dependencies to inject into your project
  @override
  List<Bind> get binds => [
        Bind((_) => LoginBloc()),
        Bind((_) => HomeBloc()),
        Bind((_) => MessagerieBloc()),
        Bind((_) => InterventionBloc()),
        Bind((_) => UserLocation()),
        Bind((_) => InterventionsBloc()),
      ];

  // Provide all the routes for your module
  @override
  List<ModularRouter> get routers => [
        ...ModularRouter.group(
          transition: TransitionType.defaultTransition,
          routes: [],
        ),
        ...ModularRouter.group(
          transition: TransitionType.downToUp,
          routes: [
            ModularRouter(Routes.ajouterRDV,
                child: (_, args) => AjouterRDVScreen()),
          ],
        ),
        ...ModularRouter.group(
          transition: TransitionType.fadeIn,
          routes: [
            ModularRouter(Routes.login,
                child: (_, args) => LoginScreenWidget()),
            ModularRouter(Routes.home, child: (_, args) => HomeScreen()),
            ModularRouter(Routes.splash,
                child: (_, args) => SplashScreenWidget()),
            ModularRouter(Routes.mesInterventions,
                child: (_, args) => InterventionsScreen()),
            ModularRouter(Routes.photoView,
                child: (_, args) => PhotoViewScreenWidget(args.data['image'])),
            ModularRouter(Routes.detailCommande,
                child: (_, args) => DetailCommandeScreen()),
            ModularRouter(Routes.calendrierPriseRDV,
                child: (_, args) => CalendrierPriseRdvWidget()),
            ModularRouter(Routes.profil,
                child: (_, args) => ProfilScreen()),
          ],
        ),
      ];

  // Provide the root widget associated with your module
  @override
  Widget get bootstrap => AppWidget();
}
