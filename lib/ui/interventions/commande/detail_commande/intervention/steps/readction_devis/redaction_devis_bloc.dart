import 'dart:async';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mdp/models/requests/ajout_designation_request.dart';
import 'package:mdp/models/responses/add_appointment_response.dart';
import 'package:mdp/models/responses/add_designation_response.dart';
import 'package:mdp/models/responses/add_new_material_response.dart';
import 'package:mdp/models/responses/get_designations_name.dart';
import 'package:mdp/models/responses/get_devis_response.dart';
import 'package:mdp/models/responses/send_mail_devis_response.dart';
import 'package:mdp/models/responses/updateQuoteResponse.dart';
import 'package:mdp/models/responses/upload_document_response.dart';
import 'package:mdp/models/responses/user_appointments_response.dart';
import 'package:mdp/models/workload_model.dart';
import 'package:mdp/network/repository/document_uploader_repository.dart';
import 'package:mdp/network/repository/rdv_repository.dart';
import 'package:mdp/network/repository/redaction_devis_repository.dart';
import 'package:rxdart/rxdart.dart';

class RedactionDevisBloc extends Disposable {
  final controller = StreamController();
  RedactionDevisRepository _repository = RedactionDevisRepository();
  DocumentUploaderRepository _documentUploaderRepository =
      DocumentUploaderRepository();
  List<WorkLoadModel> liste_materiel = <WorkLoadModel>[];

  //liste des mains d'oeuvre et déplacement
  List<WorkLoadModel> liste_mainsDeplacement = <WorkLoadModel>[];

  PublishSubject<int> notifyChanges = PublishSubject();

  Future<AddNewMaterialResponse> addNewMaterial(String name, String comment,
      int unit, int quantity, double unit_price) async {
    return _repository.addNewMaterial(
        name, comment, unit, quantity, unit_price);
  }

  Future<bool> addDesignation(AddDesignationRequest request) async {
    AddDesignationResponse resp = await _repository.addDesignation(request);
    if (resp.quoteDetailsData == null) {
      return false;
    } else {
      return true;
    }
  }

  Future<bool> updateDesignation(AddDesignationRequest request) async {
    AddDesignationResponse resp = await _repository.updateDesignation(request);
    if (resp.quoteDetailsData == null) {
      return false;
    } else {
      return true;
    }
  }

  Future<UpdateQuoteResponse> updateQuote(
      num quoteId, num tva, num remise, num franchise, num accompte) async {
    UpdateQuoteResponse resp = await _repository.updateQuote(
        quoteId, tva, remise, franchise, accompte);
    return resp;
  }

  Future<UploadDocumentResponse> uploadPhotos(
      String quoteId, String documentContent) async {
    return await _documentUploaderRepository.uploadDocumentQuote(
        quoteId, 3, documentContent);
  }

  Future<UploadDocumentResponse> uploadArtisanSignature(
      String quoteId, String documentContent) async {
    return await _documentUploaderRepository.uploadDocumentQuote(
        quoteId, 2, documentContent);
  }

  Future<UploadDocumentResponse> uploadClientSignature(
      String quoteId, String documentContent) async {
    return await _documentUploaderRepository.uploadDocumentQuote(
        quoteId, 1, documentContent);
  }

  Future<bool> sendMailDevis(num quoteId, String email) async {
    SendMailDevisResponse resp =
        await _repository.sendMailDevis(quoteId, email);
    if (resp.sendEmailData == null) return false;
    if (resp.sendEmailData.mailSent == null) return false;
    if (resp.sendEmailData.mailSent) {
      return true;
    } else {
      return false;
    }
  }

  dispose() {
    controller.close();
  }
}
