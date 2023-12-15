import 'package:asas/app/data/model/company.dart';
import 'package:asas/app/helpers/constance.dart';
import 'package:asas/app/routes/app_pages.dart';
import 'package:asas/app/theme/lightColors.dart';
import 'package:asas/app/widgets/booster.dart';
import 'package:asas/app/widgets/loading_widget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import 'package:get/get.dart';

import '../../../../translations/strings_enum.dart';
import '../controllers/user_favorite_controller.dart';

class UserFavoriteView extends GetView<UserFavoriteController> {
  const UserFavoriteView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Strings.Favorite.tr),
        centerTitle: true,
      ),
      body: GetBuilder<UserFavoriteController>(
        builder: (ctrl) {
          if(ctrl.companyStatus == ApiCallStatus.success){
            return RefreshIndicator(
              onRefresh: ()=> ctrl.getFav(1),
              child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  controller: controller.companyScrollController,
                  itemCount: ctrl.companyList.length,
                  shrinkWrap: true,
                  primary: false,
                  padding: EdgeInsets.zero,
                  itemBuilder: (context, index) => InYourCityListItem(company: ctrl.companyList[index],)
              ),
            );
          }else if(ctrl.companyStatus == ApiCallStatus.loading){
            return LoadingList(
              height: 75,
            );
          }else if(ctrl.companyStatus == ApiCallStatus.failed){
            return Center(child: Text(Strings.The_data_was_not_fetched.tr));
          }else{
            // ctrl.sectionsStatus == ApiCallStatus.empty
            return Center(child: Text(Strings.Favorite_no_items.tr));
          }
        },
      ),
    );
  }
}

class InYourCityListItem extends StatelessWidget {
  final Company company;
  const InYourCityListItem({Key? key, required this.company}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ()=> Get.toNamed(Routes.USER_CATEGORY_DETAILS, arguments: [company.id]),
      child: Container(
        padding: EdgeInsets.all(8.0),
        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        height: 110.0,
        decoration: BoxDecoration(
            border: Border.all(color: LightColors.EDIT_BORDER_COLOR),
            color: Colors.white,
            borderRadius: BorderRadius.circular(15.0)
        ),
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: CachedNetworkImage(
                  imageUrl: Constance.imageCompanyBaseUrl + company.logo!,
                  progressIndicatorBuilder: (context, url, downloadProgress) =>
                  const Center(child: CupertinoActivityIndicator()),
                  errorWidget: (context, url, error) => Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: LightColors.EDIT_BORDER_COLOR,
                      ),
                      child: Icon(
                        Icons.error,
                        color: LightColors.PRIMARY_COLOR,
                      )),
                  // width: 80,
                  height: double.infinity,
                  fit: BoxFit.fill,
                ),
              ),),
            Expanded(
              flex: 5,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Booster.textSecondaryTitle(context, company.nameCorporation ?? "-",),
                    RatingBar.builder(
                      initialRating: (company.rateTotal ?? 0).toDouble() / 2,
                      minRating: 1,
                      direction: Axis.horizontal,
                      allowHalfRating: false,
                      ignoreGestures: true,
                      itemSize: 20,
                      itemCount: 5,
                      itemPadding: EdgeInsets.symmetric(horizontal: 0),
                      unratedColor: Colors.black.withOpacity(0.5),
                      itemBuilder: (context, _) => Icon(
                        Icons.star_rounded,
                        color: LightColors.ACCENT_COLOR,
                      ),
                      onRatingUpdate: (rating) {
                        print(rating);
                      },
                    ),
                    SizedBox(
                      height: 40,
                      child: Booster.textBody(context, company.desceptionAr! , withHeight: false, textSize: 10),
                    ),
                    // Booster.textBody(context, "تبعد 5كم عن وسط المدينة", )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
