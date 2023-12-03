import 'package:docs_clone/theme/colors.dart';
import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_quill/flutter_quill.dart' as quill;

class DocumentPage extends ConsumerStatefulWidget {
  const DocumentPage(this.id, {super.key});
  final String id;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _DocumentPageState();
}

class _DocumentPageState extends ConsumerState<DocumentPage> {
  TextEditingController titleController =
      TextEditingController(text: 'Untitled Document');
  quill.QuillController quillController = quill.QuillController.basic();

  @override
  void dispose() {
    super.dispose();
    titleController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: kWhiteColor,
          elevation: 0,
          actions: [
            ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(
                Icons.lock,
                color: kWhiteColor,
              ),
              label: const Text(
                'Share',
                style: TextStyle(color: kWhiteColor),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: kBlueColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(0),
                ),
              ),
            ),
          ],
          title: Row(
            children: [
              Image.asset(
                'assets/g-logo-2.png',
                height: 40,
              ),
              const SizedBox(width: 10),
              SizedBox(
                width: 200,
                child: TextField(
                  controller: titleController,
                  onChanged: (value) {},
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: kBlueColor)),
                    contentPadding: EdgeInsets.only(left: 10),
                  ),
                ),
              )
            ],
          ),
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(1),
            child: Container(
              decoration: BoxDecoration(
                  border: Border.all(width: 0.1, color: kGreyColor)),
            ),
          ),
        ),
        body: quill.QuillProvider(
          configurations: quill.QuillConfigurations(
            controller: quillController,
            sharedConfigurations: const quill.QuillSharedConfigurations(
              locale: Locale('de'),
            ),
          ),
          child: Column(
            children: [
              const quill.QuillToolbar(),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: quill.QuillEditor.basic(
                    configurations: const quill.QuillEditorConfigurations(
                      readOnly: false,
                    ),
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
