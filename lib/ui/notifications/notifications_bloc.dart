import 'dart:async';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mdp/models/requests/delete_notifications_request.dart';
import 'package:mdp/models/responses/delete_notifications_response.dart'
    as deleteResponseModel;
import 'package:mdp/models/responses/get_notifications_Response.dart';
import 'package:mdp/network/repository/notifications_repository.dart';

class NotificationsBloc extends Disposable {
  final controller = StreamController();
  final NotificationsRepository _notifRepository = NotificationsRepository();

  Future<List<NotificationData>> getNotifications() async {
    GetNotificationsResponse response =
        await _notifRepository.getNotifications();
    return response.notificationData;
  }

  Future<deleteResponseModel.DeleteNotificationsResponse> deleteNotifications(
      List<DeleteNotificationsRequest> ids) async {
    return _notifRepository.deleteNotifications(ids);
  }

  dispose() {
    controller.close();
  }
}
