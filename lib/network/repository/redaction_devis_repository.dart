import 'package:mdp/models/responses/add_new_material_response.dart';
import 'package:mdp/models/responses/get_designations_name.dart';
import 'package:mdp/models/responses/get_materials_response.dart';
import 'package:mdp/models/responses/units_response.dart';
import 'package:mdp/network/api/redaction_Devis_api_provider.dart';

class RedactionDevisRepository {
  RedactionDevisApiProvider _apiProvider = new RedactionDevisApiProvider();

  Future<GetDesignationsNameResponse> getDesignationsName() {
    return _apiProvider.getDesignationsName();
  }

  Future<GetMaterialResponse> getMaterials() {
    return _apiProvider.getMaterials();
  }

  Future<GetUnitsResponse> getUnits() async {
    return _apiProvider.getUnits();
  }

  Future<AddNewMaterialResponse> addNewMaterial(String name, String comment,
      int unit, int quantity, double unit_price) async {
    return _apiProvider.addNewMaterial(
        name, comment, unit, quantity, unit_price);
  }
}
