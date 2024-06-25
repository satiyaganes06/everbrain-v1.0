import 'package:auto_animated/auto_animated.dart';
import 'package:delayed_display/delayed_display.dart';
import 'package:everbrain/controller/dashboard_controller.getx.dart';
import 'package:everbrain/presentation/Screens/searchBrand/search_brand_screen.dart';
import 'package:everbrain/presentation/widget/pageTitle.dart';
import 'package:everbrain/presentation/widget/category_button.dart';
import 'package:everbrain/presentation/widget/passwords_item.dart';
import 'package:flutter/material.dart';
import 'package:everbrain/utils/colors.dart' as colors;
import 'package:everbrain/utils/dimensions.dart' as dimens;
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import '../../../controller/hive_controller.getx.dart';
import '../../../controller/login_controller.getx.dart';
import '../../../test/test.dart';
import '../../Widget/global_widget.dart';
import '../../widget/custom_appbar.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final dashboardController = Get.put(DashboardController());
  final hiveCtrl = Get.find<HiveController>();
  final loginController = Get.find<LoginController>();
  bool isScroll = false;

  final searchCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Container(
                color: colors.AppColor.secondaryColor,
                child: CustomScrollView(
                    physics: const BouncingScrollPhysics(),
                    controller: dashboardController.scrollController,
                    slivers: [
                      CustomAppBar(),

                      buildSearchBar(context),
                      // buildTitle("Categories"),
                      SliverToBoxAdapter(child: SizedBox(height: Get.height*0.01,),),

                      buildCategoriesButtons(),
                     // buildTitle('Passwords'),
                      SliverToBoxAdapter(child: SizedBox(height: Get.height*0.02,),),

                      buildPasswordList(context),

                      SliverToBoxAdapter(child: SizedBox(height: Get.height*0.06)),
                      
                    ]))),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            // Get.to(() => AddNewAccount());
            Get.to(() => SearchBrandScreen());
          },
          backgroundColor: colors.AppColor.secondaryColor,
          elevation: 0.0,
          shape: RoundedRectangleBorder(side: BorderSide(width: 2,color: colors.AppColor.accentColor),borderRadius: BorderRadius.circular(100)),
          child: Lottie.asset('assets/lottie/add_vault_animation_2.json', height: Get.height*0.07, width: Get.height*0.07),
        ));
  }

  Widget buildTitle(String title) {
    return SliverToBoxAdapter(
        child: DelayedDisplay(
      delay: const Duration(milliseconds: 200),
      child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: PageTitle(title.toString(), 21)),
    ));
  }

  Widget buildCategoriesButtons() {
    return SliverToBoxAdapter(
        child: Padding(
          padding: const EdgeInsets.only(left: 20),
          child: SizedBox(
            height: Get.height * 0.06,
            child: DelayedDisplay(
              delay: Duration(milliseconds: dimens.Dimens.delayAnimationLogInPage),
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  itemCount: dashboardController.category_Button_Image_Path.length,
                  itemBuilder: (context, index) {
                    return Obx(() {
                      return Padding(
                        padding: const EdgeInsets.only(right: 5),
                        child: Material(
                            color: dashboardController
                                        .category_Selector_List.value[index] ==
                                    false
                                ? Colors.white
                                : Colors.grey[200],
                            // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10), side: BorderSide(color: dashboardController
                            //             .category_Selector_List.value[index] == false ?
                            //         Colors.transparent : colors.AppColor.accentColor, width: 2)),
                            borderRadius: BorderRadius.circular(10),
                            child: InkWell(
                                borderRadius: BorderRadius.circular(10),
                                splashColor: Colors.grey[200],
                                onTap: () {
                                  dashboardController.colorChange(index);
                                },
                                child: CategoryButton(
                                    dashboardController
                                        .category_Button_Image_Path[index],
                                    dashboardController
                                        .category_Button_Image_title[index]))),
                      );
                    });
                  }),
            ),
          ),
        ));
  }

  Widget buildPasswordList(BuildContext context) {
    return Obx(() => hiveCtrl.isLoading.value ? SliverToBoxAdapter(
      child: loading()
    ) : hiveCtrl.vaultList.isEmpty
        ? SliverToBoxAdapter(
            child: Center(
            heightFactor: 2,
            child: Column(children: [
              Image.asset('assets/images/empty_list.png', height: 200),
              Text("No vault yet",
                  style: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: colors.AppColor.accentColor,
                      letterSpacing: 1))
            ]),
          ))
        : LiveSliverList(
            controller: dashboardController.scrollController,
            showItemDuration: dashboardController.listShowItemDuration,
            itemBuilder: buildAnimatedPasswordList,
            // Other properties correspond to the `ListView.builder` / `ListView.separated` widget
            itemCount: dashboardController.hiveController.vaultList.length,
          ));
  }


  Widget buildAnimatedPasswordList(
      BuildContext context, int index, Animation<double> animation) {
    return FadeTransition(
        opacity: Tween<double>(
          begin: 0,
          end: 1,
        ).animate(animation),
        // And slide transition
        child: SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(0, -0.1),
              end: Offset.zero,
            ).animate(animation),
            child: PasswordItem(
                vaultInfo:
                    dashboardController.hiveController.vaultList[index])));
  }

  buildSearchBar(BuildContext context) {
    return SliverToBoxAdapter(
        child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: DelayedDisplay(
        delay: Duration(milliseconds: dimens.Dimens.delayAnimationLogInPage),
        child: TextField(
          controller: searchCtrl,
          onChanged: (value) async {
            dashboardController.hiveController.searchListVault(value);
          },
          decoration: InputDecoration(
              hintText: "Search",
              prefixIcon: const Icon(Icons.search),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide:  BorderSide(color: colors.AppColor.accentColor)),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: Colors.transparent)),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: colors.AppColor.accentColor, width: 2)),
              filled: true,
              fillColor: Colors.grey[200],
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 10)),
        ),
      ),
    ));
  }

  loading(){
    return Column(
      children: List.generate(3, (index) => shimmerEffectBrandSearch())
    );
  }
}
