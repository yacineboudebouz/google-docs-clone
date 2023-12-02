import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DocumentPage extends ConsumerStatefulWidget {
  const DocumentPage(this.id, {super.key});
  final String id;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _DocumentPageState();
}

class _DocumentPageState extends ConsumerState<DocumentPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(widget.id),
      ),
    );
  }
}
