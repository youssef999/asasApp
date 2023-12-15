import 'package:asas/app/modules/user/category/views/complete.dart';
import 'package:asas/app/theme/lightColors.dart';
import 'package:asas/app/widgets/booster.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../../translations/strings_enum.dart';
import '../controllers/user_category_controller.dart';

class UserCategoryView extends GetView<UserCategoryController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(controller.typeName),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          children: [
            TextField(
              maxLines: 1,
              controller: controller.searchController,
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.search,
              style: Theme.of(context)
                  .textTheme
                  .bodyText1
                  ?.copyWith(fontWeight: FontWeight.normal),
              decoration: InputDecoration(
                  suffixIcon: Container(
                    height: 35,
                    width: 35,
                    padding: const EdgeInsets.all(8.0),
                    margin: const EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                        color: LightColors.ACCENT_COLOR,
                        borderRadius: BorderRadius.circular(5)),
                    child: SvgPicture.asset(
                      'assets/svg/search_icon.svg',
                    ),
                  ),
                  errorStyle: Theme.of(context)
                      .textTheme
                      .bodyText1!
                      .copyWith(color: Colors.redAccent),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  hintText: Strings.Search_by_keyword.tr,
                  hintStyle: TextStyle(
                      color: LightColors.TEXT_HINT_COLOR, fontSize: 14.0),
                  filled: true,
                  fillColor: LightColors.EDIT_BACKGROUND_COLOR,
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(
                        color: LightColors.EDIT_BORDER_FOCUSED_COLOR),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                      vertical: 10.0, horizontal: 10.0),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    //borderSide: BorderSide(color: Colors.white),
                    borderSide: BorderSide(color: Colors.grey[300]!),
                  )),
            ),
            Booster.verticalSpace(10),
            getClassEx(controller)
          ],
        ),
      ),
    );
  }
}
