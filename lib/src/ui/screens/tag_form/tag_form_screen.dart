import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../utils/app_localization.dart';
import '../../../store/tag_form_store.dart';
import '../../../data/dto.dart';
import 'widgets/widgets.dart';
import '../../../store/store.dart';

class TagFormScreen extends StatefulWidget {
  final TagWithPomodorosCount tag;

  TagFormScreen({this.tag});

  @override
  _TagFormScreenState createState() => _TagFormScreenState();
}

class _TagFormScreenState extends State<TagFormScreen> {
  Future _createTagHandler(TagFormStore tagFormStore) async {
    final bool shouldReturn = await tagFormStore.doneEditing();
    if (shouldReturn) Modular.to.pop();
  }

  void _focusReset(BuildContext context) {
    FocusScopeNode currentFocus = FocusScope.of(context);

    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    Modular.get<TagFormStore>().init(
      locale: AppLocalizations.of(context),
      tag: widget.tag?.tag,
    );
  }

  @override
  Widget build(BuildContext context) {
    final _titleKey = widget.tag != null ? 'editTag' : 'createTag';
    final title =
        AppLocalizations.of(context).translate(_titleKey).toUpperCase();

    final TagFormStore tagFormStore = Modular.get<TagFormStore>();

    return GestureDetector(
      onTap: () => _focusReset(context),
      child: Scaffold(
        appBar: AppBar(
          title: _AppBarTitle(title),
          centerTitle: true,
        ),
        body: TagForm(),
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
      style: Theme.of(context).textTheme.headline6.copyWith(
            letterSpacing: 10.0,
          ),
    );
  }
}
