import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../utils/app_localization.dart';
import '../../../store/home_store.dart';
import '../../../store/tag_form_store.dart';
import '../../../data/db_repository.dart';
import '../../../routes/router.gr.dart';
import '../../../data/dto.dart';
import '../../../utils/validator.dart';
import 'widgets/widgets.dart';

class TagFormScreen extends StatelessWidget {
  final TagWithPomodorosCount tag;

  TagFormScreen({this.tag});

  Future _createTagHandler(TagFormStore tagFormStore) async {
    final bool shouldReturn = await tagFormStore.doneEditing();
    if (shouldReturn) AppRouter.navigator.pop();
  }

  void _focusReset(BuildContext context) {
    FocusScopeNode currentFocus = FocusScope.of(context);

    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    final _titleKey = tag != null ? 'editTag' : 'createTag';
    final title =
        AppLocalizations.of(context).translate(_titleKey).toUpperCase();

    final HomeStore homeStore = Provider.of<HomeStore>(context, listen: false);
    final tagFormStore = TagFormStore(
      homeStore: homeStore,
      tag: tag?.tag,
      validator: Validator.instance(
        db: DbDataRepository.db(),
        locale: AppLocalizations.of(context),
      ),
    );

    return GestureDetector(
      onTap: () => _focusReset(context),
      child: Scaffold(
        appBar: AppBar(
          title: _AppBarTitle(title),
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
      ),
    );
  }
}

class _AppBarTitle extends StatelessWidget {
  final String title;

  _AppBarTitle(this.title);

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: Theme.of(context).textTheme.subtitle2.copyWith(
            letterSpacing: 10.0,
          ),
    );
  }
}
