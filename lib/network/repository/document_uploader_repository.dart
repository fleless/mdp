import 'package:mdp/models/responses/add_type_document_response.dart';
import 'package:mdp/models/responses/upload_document_response.dart';
import 'package:mdp/network/api/document_uploader_api_provider.dart';

class DocumentUploaderRepository {
  DocumentUploaderApiProvider _apiProvider = new DocumentUploaderApiProvider();

  Future<UploadDocumentResponse> uploadDocumentQuote(
      String quoteId, int documentTypeId, String documentContent) {
    return _apiProvider.uploadQuoteDocument(
        quoteId, documentTypeId, documentContent);
  }

  Future<UploadDocumentResponse> uploadInterventionDocument(
      num orderId, int documentTypeId, String documentContent) async {
    return _apiProvider.uploadInterventionDocument(
        orderId, documentTypeId, documentContent);
  }

  Future<AddTypeDocumentResponse> addTypeDocument(String name) async {
    return _apiProvider.addTypeDocument(name);
  }

  Future<bool> generatePVDocument(num orderIdentifier) async {
    return _apiProvider.generatePVDocument(orderIdentifier);
  }
}
