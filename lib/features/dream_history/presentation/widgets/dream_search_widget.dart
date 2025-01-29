import 'package:dream/i18n/strings.g.dart';
import 'package:dream/shared/widgets/app_text_field.dart';
import 'package:flutter/material.dart';
import 'dart:async';

/// Widget that provides search functionality for dreams
class DreamSearchWidget extends StatefulWidget {
  final Function(String) onSearch;

  const DreamSearchWidget({
    super.key,
    required this.onSearch,
  });

  @override
  State<DreamSearchWidget> createState() => _DreamSearchWidgetState();
}

class _DreamSearchWidgetState extends State<DreamSearchWidget> {
  final _searchController = TextEditingController();
  Timer? _debounce;

  @override
  void dispose() {
    _searchController.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  void _onSearchChanged(String query) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      widget.onSearch(query);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: AppTextField(
        controller: _searchController,
        hint: t.searchDreams.searchDreams,
        prefix: Icon(Icons.search),
        onChanged: _onSearchChanged,
      ),
    );
  }
}
