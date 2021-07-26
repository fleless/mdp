import 'package:mdp/models/responses/get_designations_name.dart';
import 'package:mdp/models/responses/get_materials_response.dart';
import 'package:mdp/network/api/redaction_Devis_api_provider.dart';

class RedactionDevisRepository {
  RedactionDevisApiProvider _apiProvider = new RedactionDevisApiProvider();

  Future<GetDesignationsNameResponse> getDesignationsName() {
    return _apiProvider.getDesignationsName();
  }

  Future<GetMaterialResponse> getMaterials() {
    return _apiProvider.getMaterials();
  }
}
