import 'package:docs_clone/core/utils.dart';
import 'package:docs_clone/features/home/domain/document.dart';
import 'package:docs_clone/features/home/presentation/document_controller.dart';
import 'package:docs_clone/features/home/presentation/home_controller.dart';
import 'package:docs_clone/theme/colors.dart';
import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_quill/flutter_quill.dart' as quill;

import '../../auth/presentation/login_controller.dart';

class DocumentPage extends ConsumerStatefulWidget {
  const DocumentPage(this.id, {super.key});
  final String id;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _DocumentPageState();
}

class _DocumentPageState extends ConsumerState<DocumentPage> {
  TextEditingController titleController =
      TextEditingController(text: "Untitled");
  quill.QuillController quillController = quill.QuillController.basic();

  @override
  void dispose() {
    super.dispose();
    titleController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<AsyncValue>(documentControllerProvider.select((state) => state),
        (_, state) {
      if (state.hasError) {
        showMyDialog(context, state.error.toString());
      }
    });
    return Scaffold(
        appBar: ref.watch(documentProvider(widget.id)).when(
            data: (document) {
              titleController.text = document.title;
              return AppBar(
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
                      width: 100,
                      child: TextField(
                        controller: titleController,
                        onChanged: (value) {},
                        onSubmitted: (value) {
                          ref
                              .read(homeControllerProvider.notifier)
                              .updateDocument(widget.id, titleController.text);
                          ref.refresh(allDocsProvider);
                        },
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
              );
            },
            error: (e, tr) => AppBar(),
            loading: () => AppBar()),
        body: ref.watch(documentProvider(widget.id)).when(
            data: (document) => quill.QuillProvider(
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
                            configurations:
                                const quill.QuillEditorConfigurations(
                              readOnly: false,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
            error: (err, tr) => Center(child: Text(err.toString())),
            loading: () => const Center(child: CircularProgressIndicator())));
  }
}
