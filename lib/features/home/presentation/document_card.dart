import 'package:docs_clone/features/home/domain/document.dart';
import 'package:docs_clone/features/home/presentation/document_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:routemaster/routemaster.dart';

class DocumentCard extends ConsumerWidget {
  const DocumentCard({super.key, required this.document});
  final DocumentModel document;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return InkWell(
      onTap: () {
        ref.refresh(documentProvider(document.id));
        Routemaster.of(context).push('/document/${document.id}');
      },
      child: SizedBox(
        height: 50,
        width: 50,
        child: Card(
          child: Center(
            child: Text(document.title),
          ),
        ),
      ),
    );
  }
}
