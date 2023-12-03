import 'package:docs_clone/features/home/domain/document.dart';
import 'package:flutter/material.dart';
import 'package:routemaster/routemaster.dart';

class DocumentCard extends StatelessWidget {
  const DocumentCard({super.key, required this.document});
  final DocumentModel document;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
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
