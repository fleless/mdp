import 'package:mdp/models/requests/delete_notifications_request.dart';
import 'package:mdp/models/responses/get_notifications_Response.dart';
import 'package:mdp/network/api/notification_api_provider.dart';
import 'package:mdp/models/responses/delete_notifications_response.dart';

class NotificationsRepository {
  NotificationsApiProvider _apiProvider = new NotificationsApiProvider();

  Future<GetNotificationsResponse> getNotifications() {
    return _apiProvider.getNotifications();
  }

  Future<DeleteNotificationsResponse> deleteNotifications(
      List<DeleteNotificationsRequest> ids) async {
    return _apiProvider.deleteNotifications(ids);
  }
}
