import 'package:mdp/models/requests/ajout_designation_request.dart';
import 'package:mdp/models/responses/add_designation_response.dart';
import 'package:mdp/models/responses/add_new_material_response.dart';
import 'package:mdp/models/responses/get_designations_name.dart';
import 'package:mdp/models/responses/get_devis_response.dart';
import 'package:mdp/models/responses/get_materials_response.dart';
import 'package:mdp/models/responses/get_notif_refus_response.dart';
import 'package:mdp/models/responses/send_mail_devis_response.dart';
import 'package:mdp/models/responses/units_response.dart';
import 'package:mdp/models/responses/updateQuoteResponse.dart';
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

  Future<GetMaterialResponse> getMainDeplacement() {
    return _apiProvider.getMainDeplacement();
  }

  Future<AddDesignationResponse> addDesignation(AddDesignationRequest request) {
    return _apiProvider.addDesignation(request);
  }

  Future<AddDesignationResponse> updateDesignation(
      AddDesignationRequest request) {
    return _apiProvider.updateDesignation(request);
  }

  Future<GetDevisResponse> getDevis(String orderId) {
    return _apiProvider.getDevis(orderId);
  }

  Future<UpdateQuoteResponse> updateQuote(
      num quoteId, num tva, num remise, num franchise, num accompte) async {
    return _apiProvider.updateQuote(quoteId, tva, remise, franchise, accompte);
  }

  Future<SendMailDevisResponse> sendMailDevis(num quoteId, String email) async {
    return _apiProvider.sendMailDevis(quoteId, email);
  }

  Future<GetNotifRefusResponse> notifierRefus(num quoteId) async {
    return _apiProvider.notifierRefus(quoteId);
  }
}
