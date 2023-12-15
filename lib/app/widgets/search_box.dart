import 'package:asas/app/theme/lightColors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SearchBox extends StatelessWidget {
  final Function onSearch;
  final Function onFilterClicked;
  final TextEditingController controller;
  final String hint;
  const SearchBox({Key? key, required this.controller, required this.onFilterClicked, required this.onSearch, required this.hint}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: controller,
            onSubmitted: (_)=> onSearch(),
            keyboardType: TextInputType.text,
            textInputAction: TextInputAction.search,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.normal),
            decoration: InputDecoration(
                errorStyle: Theme.of(context).textTheme.bodyLarge!.copyWith(color: Colors.redAccent),
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                hintText: hint,
                hintStyle: TextStyle(color: LightColors.TEXT_HINT_COLOR, fontSize: 12.0),
                filled: true,
                fillColor: LightColors.EDIT_BACKGROUND_COLOR,
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                   borderSide: BorderSide(color: LightColors.EDIT_BORDER_FOCUSED_COLOR ),
                ),
                contentPadding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  //borderSide: BorderSide(color: Colors.white),
                  borderSide: BorderSide(color: Colors.grey[300]!),
                )),
          ),
        ),
        const SizedBox(width: 11,),
        InkWell(
          onTap: ()=> onFilterClicked(),
          borderRadius: BorderRadius.circular(10),
          child: Ink(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: LightColors.PRIMARY_COLOR
            ),
            padding: EdgeInsets.all(12.0),
            child: SvgPicture.asset('assets/svg/filter.svg'),
          ),
        )
      ],
    );
  }
}
