import 'dart:async';
import 'package:flutter/material.dart';
import 'package:program_visit/common/styles/font.dart';

class CustomSearch extends StatelessWidget {
  const CustomSearch({
    super.key,
    this.controller,
    this.suggestionsBuilder,
    required this.hintText,
    this.onChanged,
  });

  final String hintText;
  final TextEditingController? controller;
  final FutureOr<Iterable<Widget>> Function(BuildContext, SearchController)?
  suggestionsBuilder;
  final void Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    final searchController = SearchController();

    return suggestionsBuilder == null
        ? _buildSearchBar(searchController)
        : SearchAnchor(
          searchController: searchController,
          builder: (context, controller) => _buildSearchBar(controller),
          suggestionsBuilder: suggestionsBuilder!,
        );
  }

  SearchBar _buildSearchBar(SearchController controller) {
    return SearchBar(
      controller: controller,
      onChanged: onChanged,
      leading: const Icon(Icons.search, color: Color(0xff7F909F)),
      hintText: hintText,
      elevation: WidgetStateProperty.all(0),
      surfaceTintColor: WidgetStateProperty.all(Colors.transparent),
      backgroundColor: WidgetStateProperty.all(Color(0XFFFAFAFA)),
      padding: WidgetStateProperty.all(
        const EdgeInsets.symmetric(horizontal: 16),
      ),
      shape: WidgetStateProperty.all(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50),
          side: const BorderSide(color: Color(0xffdedede)),
        ),
      ),
      constraints: const BoxConstraints(minHeight: 47, maxHeight: 47),
      hintStyle: const WidgetStatePropertyAll(
        TextStyle(
          fontFamily: "Poppins",
          fontSize: 15,
          fontWeight: AppFontWeight.medium,
          color: Color(0xff7F909F),
        ),
      ),
    );
  }
}
