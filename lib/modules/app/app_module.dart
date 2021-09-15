import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mdp/constants/routes.dart';
import 'package:mdp/ui/calendar/calendar_bloc.dart';
import 'package:mdp/ui/calendar/calendar_screen.dart';
import 'package:mdp/ui/home/home_bloc.dart';
import 'package:mdp/ui/home/home_screen.dart';
import 'package:mdp/ui/interventions/commande/detail_commande/detail_commande_screen.dart';
import 'package:mdp/ui/interventions/commande/detail_commande/intervention/intervention_bloc.dart';
import 'package:mdp/ui/interventions/commande/detail_commande/intervention/steps/finalisation_intervention/document_adder/document_type_selector.dart';
import 'package:mdp/ui/interventions/commande/detail_commande/intervention/steps/finalisation_intervention/finalisation_intervention_bloc.dart';
import 'package:mdp/ui/interventions/commande/detail_commande/intervention/steps/finalisation_intervention/payment/payment_email_screen.dart';
import 'package:mdp/ui/interventions/commande/detail_commande/intervention/steps/finalisation_intervention/payment/payment_message_screen.dart';
import 'package:mdp/ui/interventions/commande/detail_commande/intervention/steps/finalisation_intervention/payment/payment_principal_options_screen.dart';
import 'package:mdp/ui/interventions/commande/detail_commande/intervention/steps/prise_rdv/prise_rdv_bloc.dart';
import 'package:mdp/ui/interventions/commande/detail_commande/intervention/steps/prise_rdv/screens/ajouter_rdv.dart';
import 'package:mdp/ui/interventions/commande/detail_commande/intervention/steps/prise_rdv/screens/calendrier_prise_rdv_screen.dart';
import 'package:mdp/ui/interventions/commande/detail_commande/intervention/steps/prise_rdv/screens/modifier_rdv.dart';
import 'package:mdp/ui/interventions/commande/detail_commande/intervention/steps/readction_devis/redaction_devis_bloc.dart';
import 'package:mdp/ui/interventions/commande/detail_commande/intervention/steps/readction_devis/screens/creation_designation_screen.dart';
import 'package:mdp/ui/interventions/commande/detail_commande/intervention/steps/readction_devis/screens/redaction_devis_screen.dart';
import 'package:mdp/ui/interventions/commande/detail_commande/intervention/steps/readction_devis/signature_devis/envoyer_devis_mail.dart';
import 'package:mdp/ui/interventions/commande/detail_commande/intervention/steps/readction_devis/signature_devis/presentation_devis.dart';
import 'package:mdp/ui/interventions/commande/detail_commande/intervention/steps/readction_devis/signature_devis/signature_artisan.dart';
import 'package:mdp/ui/interventions/commande/detail_commande/intervention/steps/readction_devis/signature_devis/signature_client.dart';
import 'package:mdp/ui/interventions/commande/detail_commande/intervention/steps/realisation_travaux/screens/ajouter_realisation_rdv.dart';
import 'package:mdp/ui/interventions/commande/detail_commande/intervention/steps/realisation_travaux/screens/calendrier_realisation_rdv_screen.dart';
import 'package:mdp/ui/interventions/commande/detail_commande/messagerie/messagerie_bloc.dart';
import 'package:mdp/ui/interventions/interventions_bloc.dart';
import 'package:mdp/ui/interventions/interventions_screen.dart';
import 'package:mdp/ui/login/login_bloc.dart';
import 'package:mdp/ui/login/login_screen.dart';
import 'package:mdp/ui/notifications/notifications_bloc.dart';
import 'package:mdp/ui/notifications/notifications_screen.dart';
import 'package:mdp/ui/profil/profil_screen.dart';
import 'package:mdp/ui/profil/profile_bloc.dart';
import 'package:mdp/ui/splash/splash_screen.dart';
import 'package:mdp/utils/image_compresser.dart';
import 'package:mdp/utils/user_location.dart';
import 'package:mdp/widgets/photo_view_screen.dart';
import 'app_widget.dart';

class AppModule extends MainModule {
  // Provide a list of dependencies to inject into your project
  @override
  List<Bind> get binds => [
        Bind((_) => LoginBloc()),
        Bind((_) => ProfileBloc()),
        Bind((_) => HomeBloc()),
        Bind((_) => CalendarBloc()),
        Bind((_) => NotificationsBloc()),
        Bind((_) => MessagerieBloc()),
        Bind((_) => InterventionBloc()),
        Bind((_) => UserLocation()),
        Bind((_) => InterventionsBloc()),
        Bind((_) => PriseRdvBloc()),
        Bind((_) => RedactionDevisBloc()),
        Bind((_) => ImageCompressor()),
        Bind((_) => FinalisationInterventionBloc()),
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
            ModularRouter(Routes.modifierRdv,
                child: (_, args) => ModifierRdvScreen(args.data['rdv'])),
          ],
        ),
        ...ModularRouter.group(
          transition: TransitionType.fadeIn,
          routes: [
            ModularRouter(Routes.login,
                child: (_, args) => LoginScreenWidget()),
            ModularRouter(Routes.home, child: (_, args) => HomeScreen()),
            ModularRouter(Routes.calendar,
                child: (_, args) => CalendarScreen()),
            ModularRouter(Routes.splash,
                child: (_, args) => SplashScreenWidget()),
            ModularRouter(Routes.mesInterventions,
                child: (_, args) => InterventionsScreen()),
            ModularRouter(Routes.photoView,
                child: (_, args) => PhotoViewScreenWidget(
                    args.data['image'], args.data['path'])),
            ModularRouter(Routes.detailCommande,
                child: (_, args) => DetailCommandeScreen(args.data['uuid'])),
            ModularRouter(Routes.calendrierPriseRDV,
                child: (_, args) => CalendrierPriseRdvWidget(args.data['rdv'])),
            ModularRouter(Routes.redactionDevis,
                child: (_, args) => RedactionDevisScreen()),
            ModularRouter(Routes.profil, child: (_, args) => ProfilScreen()),
            ModularRouter(Routes.notifications,
                child: (_, args) => NotificationsScreen()),
            ModularRouter(Routes.creationDesignation,
                child: (_, args) => CreationDesignationScreen(
                    args.data['designationToUpdate'], args.data['isAdd'])),
            ModularRouter(Routes.signatureArtisan,
                child: (_, args) => SignatureArtisanScreen()),
            ModularRouter(Routes.presentationDevis,
                child: (_, args) => PresentationDevisScreen()),
            ModularRouter(Routes.envoyerDevisMail,
                child: (_, args) => EnvoyerDevisMailScreen()),
            ModularRouter(Routes.signatureClient,
                child: (_, args) => SignatureClientScreen()),
            ModularRouter(Routes.calendrierRealisationRDV,
                child: (_, args) => CalendrierRealisationRdvWidget()),
            ModularRouter(Routes.ajouterRealisationRDV,
                child: (_, args) => AjouterRealisationRDVScreen()),
            ModularRouter(Routes.documentTypeSelector,
                child: (_, args) => DocumentTypeSelectorScreen()),
            ModularRouter(Routes.paymentMessage,
                child: (_, args) => PaymentMessageScreen(
                    args.data['status'], args.data['message'])),
            ModularRouter(Routes.paymentPrincipalOptionsScreen,
                child: (_, args) => PaymentPrincipalOptionsScreen()),
            ModularRouter(Routes.paymentEmailScreen,
                child: (_, args) => PaymentEmailScreen()),
          ],
        ),
      ];

  // Provide the root widget associated with your module
  @override
  Widget get bootstrap => AppWidget();
}
