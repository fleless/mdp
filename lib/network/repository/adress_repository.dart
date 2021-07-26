import 'package:mdp/models/responses/adressResponse.dart';
import 'package:mdp/models/responses/login_response.dart';
import 'package:mdp/models/responses/profile_response.dart';
import 'package:mdp/network/api/adress_api_provider.dart';
import 'package:mdp/network/api/login_api_provider.dart';

class AdressRepository {
  AdressApiProvider _apiProvider = new AdressApiProvider();

  Future<List<AdressResponse>> getCommunity(String zip) {
    return _apiProvider.getCommunityNameFromZipCode(zip);
  }
}
