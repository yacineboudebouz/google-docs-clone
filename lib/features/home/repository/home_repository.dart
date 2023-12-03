import 'dart:convert';

import 'package:docs_clone/core/providers/uri_provider.dart';
import 'package:docs_clone/features/auth/domain/user.dart';
import 'package:docs_clone/features/home/domain/document.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

final homeRepositoryProvider = Provider<HomeRepository>((ref) {
  return HomeRepository(ref: ref);
});

class HomeRepository {
  HomeRepository({required Ref ref}) : _ref = ref;
  final Ref _ref;

  Future<DocumentModel?> createDocument() async {
    final token = _ref.read(userStateProvider)!.token;

    try {
      http.Response res = await http.post(
        Uri.parse('$uri/document/create'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': token
        },
        body: jsonEncode({'createdAt': DateTime.now().microsecondsSinceEpoch}),
      );
      if (res.statusCode == 201) {
        return DocumentModel.fromJson(res.body);
      } else {
        throw 'Cannot create a document';
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<List<DocumentModel>> getAllDocuments() async {
    final token = _ref.read(userStateProvider)!.token;

    try {
      http.Response res = await http.get(
        Uri.parse('$uri/document/all/me'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': token
        },
      );
      if (res.statusCode == 200) {
        List<DocumentModel> documents = [];
        for (int i = 0; i < jsonDecode(res.body).length; i++) {
          documents
              .add(DocumentModel.fromJson(jsonEncode(jsonDecode(res.body)[i])));
        }
        return documents;
      } else {
        throw Exception('Error occured, cannot import docs !');
      }
    } catch (e) {
      throw Exception(e);
    }
  }
}
