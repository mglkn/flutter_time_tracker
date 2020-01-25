import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../utils/app_localization.dart';
import '../widgets/forms/forms.dart';
import '../../store/home_store.dart';
import '../../store/tag_form_store.dart';
import '../../data/db_repository.dart';
import '../../routes/router.gr.dart';
import '../../data/dto.dart';
import '../../utils/validator.dart';

class TagFormScreen extends StatelessWidget {
  final TagWithPomodorosCount tag;

  TagFormScreen({this.tag});

  Future _createTagHandler(TagFormStore tagFormStore) async {
    final bool shouldReturn = await tagFormStore.doneEditing();
    if (shouldReturn) AppRouter.navigator.pop();
  }

  @override
  Widget build(BuildContext context) {
    final title =
        AppLocalizations.of(context).translate("createTag").toUpperCase();

    final HomeStore homeStore = Provider.of<HomeStore>(context, listen: false);
    final tagFormStore = TagFormStore(
      homeStore: homeStore,
      repo: DbDataRepository.db(),
      tag: tag?.tag,
      validator: Validator.instance(
        db: DbDataRepository.db(),
        locale: AppLocalizations.of(context),
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        centerTitle: true,
      ),
      body: Provider(
        create: (_) => tagFormStore,
        child: TagForm(),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.done),
        onPressed: () => _createTagHandler(tagFormStore),
      ),
    );
  }
}
