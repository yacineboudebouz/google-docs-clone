import 'package:docs_clone/core/common/async_value_widget.dart';
import 'package:docs_clone/core/utils.dart';

import 'package:docs_clone/features/auth/presentation/login_controller.dart';
import 'package:docs_clone/features/home/presentation/document_card.dart';
import 'package:docs_clone/features/home/presentation/home_controller.dart';
import 'package:docs_clone/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:routemaster/routemaster.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  void createDoc(BuildContext context) async {
    final state = ref.watch(homeControllerProvider);
    await ref.read(homeControllerProvider.notifier).createDoc();

    await ref.read(homeControllerProvider.notifier).getAllDocuments();
    if (state.value != null) {
      if (context.mounted) {
        Routemaster.of(context).push('/document/${state.value!.id}');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final homeState = ref.watch(homeControllerProvider);
    ref.listen<AsyncValue>(loginControllerProvider.select((state) => state),
        (_, state) {
      if (state.hasError) {
        showMyDialog(context, state.error.toString());
      }
    });

    ref.listen<AsyncValue>(homeControllerProvider.select((state) => state),
        (_, state) {
      if (state.hasError) {
        showMyDialog(context, state.error.toString());
      }
    });

    final authState = ref.watch(loginControllerProvider);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: kWhiteColor,
        elevation: 0,
        actions: [
          IconButton(
              onPressed: () {
                ref.refresh(allDocsProvider);
              },
              icon: const Icon(Icons.refresh)),
          IconButton(
              onPressed: () {
                createDoc(context);
              },
              icon: homeState.isLoading
                  ? const CircularProgressIndicator()
                  : const Icon(Icons.add)),
          IconButton(
              onPressed: () {
                ref.read(loginControllerProvider.notifier).logOut();
              },
              icon: authState.isLoading
                  ? const CircularProgressIndicator()
                  : const Icon(
                      Icons.logout,
                      color: kRedColor,
                    )),
        ],
      ),
      body: AsyncValueWidget(
        value: ref.watch(allDocsProvider),
        data: (docs) {
          return Center(
            child: Container(
              margin: const EdgeInsets.only(top: 10),
              width: 600,
              child: ListView.builder(
                physics: const RangeMaintainingScrollPhysics(),
                itemBuilder: (ctx, i) {
                  return DocumentCard(document: docs[i]);
                },
                itemCount: docs.length,
              ),
            ),
          );
        },
      ),
    );
  }
}
