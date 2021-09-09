import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mdp/constants/app_colors.dart';
import 'package:mdp/constants/app_constants.dart';
import 'package:mdp/constants/routes.dart';
import 'package:mdp/constants/styles/app_styles.dart';
import 'package:mdp/models/requests/delete_notifications_request.dart';
import 'package:mdp/models/responses/get_notifications_Response.dart';
import 'package:mdp/ui/notifications/notifications_bloc.dart';
import 'package:mdp/widgets/bottom_navbar_widget.dart';
import 'package:mdp/widgets/gradients/md_gradient_light.dart';

class NotificationsScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  List<NotificationData> _notifications = <NotificationData>[];
  final bloc = Modular.get<NotificationsBloc>();
  bool _loading = true;

  @override
  void initState() {
    _loadNotifications();
    super.initState();
  }

  _loadNotifications() async {
    setState(() {
      _loading = true;
    });
    _notifications = await bloc.getNotifications();
    setState(() {
      _loading = false;
    });
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
              child: _loading
                  ? Center(
                      child: CircularProgressIndicator(
                          color: AppColors.md_dark_blue))
                  : _notifications.length > 0
                      ? _buildList()
                      : Center(
                          child: Text(
                          "Vous n'avez aucune notification",
                          style: AppStyles.bodyMdTextLight,
                        )),
            ),
            if (_notifications.length > 0)
              Center(
                child: TextButton(
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.all(10.0),
                    primary: AppColors.md_dark_blue,
                    textStyle: const TextStyle(fontSize: 20),
                  ),
                  child: const Text('Tout effacer',
                      style: AppStyles.underlinedTertiaryButtonText,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2),
                  onPressed: () {
                    _supprimerToutesLesNotifs();
                  },
                ),
              ),
            SizedBox(height: 7),
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
                        color: _notifications[index].type == "NEW_MESSAGE"
                            ? AppColors.md_secondary
                            : _notifications[index].type == "NEW_COMMENT"
                                ? AppColors.md_dark_blue
                                : AppColors.mdAlert,
                      ),
                    ),
                    SizedBox(width: 20),
                    Expanded(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(_notifications[index].title,
                              style: AppStyles.bodyDefaultBlack),
                          SizedBox(height: 5),
                          Text(_notifications[index].content,
                              style: AppStyles.bodyBoldMdDarkBlue),
                        ],
                      ),
                    ),
                    SizedBox(width: 20),
                    InkWell(
                      onTap: () {
                        _supprimerUneNotif(index);
                      },
                      splashColor: AppColors.md_dark_blue.withOpacity(0.2),
                      child: Align(
                        alignment: Alignment.topRight,
                        child: Icon(
                          Icons.close,
                          size: 27,
                        ),
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

  _supprimerUneNotif(num index) async {
    List<DeleteNotificationsRequest> lista = <DeleteNotificationsRequest>[];
    lista.add(
        DeleteNotificationsRequest(id: num.parse(_notifications[index].id)));
    await bloc.deleteNotifications(lista);
    _loadNotifications();
  }

  _supprimerToutesLesNotifs() async {
    List<DeleteNotificationsRequest> lista = <DeleteNotificationsRequest>[];
    _notifications.forEach((element) {
      lista.add(DeleteNotificationsRequest(id: num.parse(element.id)));
    });
    await bloc.deleteNotifications(lista);
    _loadNotifications();
  }
}
