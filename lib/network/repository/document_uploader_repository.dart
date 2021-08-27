import 'package:mdp/models/responses/upload_document_response.dart';
import 'package:mdp/network/api/document_uploader_api_provider.dart';

class DocumentUploaderRepository {
  DocumentUploaderApiProvider _apiProvider = new DocumentUploaderApiProvider();

  Future<UploadDocumentResponse> uploadDocumentQuote(
      String quoteId, int documentTypeId, String documentContent) {
    return _apiProvider.uploadQuoteDocument(
        quoteId, documentTypeId, documentContent);
  }
}
