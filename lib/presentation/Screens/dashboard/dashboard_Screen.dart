import 'package:auto_animated/auto_animated.dart';
import 'package:delayed_display/delayed_display.dart';
import 'package:everbrain/controller/dashboard_controller.getx.dart';
import 'package:everbrain/presentation/Screens/searchBrand/search_brand_screen.dart';
import 'package:everbrain/presentation/Widget/pageTitle.dart';
import 'package:everbrain/presentation/Widget/category_button.dart';
import 'package:everbrain/presentation/Widget/passwords_item.dart';
import 'package:flutter/material.dart';
import 'package:everbrain/utils/colors.dart' as colors;
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../controller/hive_controller.getx.dart';
import '../../../controller/login_controller.getx.dart';
import '../../../core/localServices/secure_storage_repository.dart';
import '../../../core/networkService/brand_api_service.dart';
import '../../Widget/custom_appbar.dart';
import '../accountOpt/addAccount/add_new_account.dart';
import 'package:flutter_scrolling_fab_animated/flutter_scrolling_fab_animated.dart';

import '../passwordGenerator/password_generator_screen.dart';

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

                      //    buildTitle("Categories"),
                      buildCategoriesButtons(),
                      buildTitle('Passwords'),
                      buildPasswordList(context),
                    ]))),
        floatingActionButtonLocation: FloatingActionButtonLocation.miniEndFloat,
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            // Get.to(() => AddNewAccount());
            Get.to(() => SearchBrandScreen());
          },
          child: const Icon(Icons.add),
          backgroundColor: colors.AppColor.tertiaryColor,
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
        child: SizedBox(
            height: Get.height * 0.15,
            child: LiveGrid.options(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              options: dashboardController.options,
              itemBuilder: buildAnimatedCategoryButton,
              itemCount: 7,
              scrollDirection: Axis.horizontal,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 1,
                mainAxisSpacing: 1,
              ),
              physics: const BouncingScrollPhysics(),
            )));
  }

  Widget buildPasswordList(BuildContext context) {
    return Obx(() => hiveCtrl.vaultList.isEmpty
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

  Widget buildAnimatedCategoryButton(
    BuildContext context,
    int index,
    Animation<double> animation,
  ) =>
      FadeTransition(
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
              child: Obx(() {
                return Material(
                    color: dashboardController
                                .category_Selector_List.value[index] ==
                            false
                        ? Colors.white
                        : Colors.grey[200],
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
                                .category_Button_Image_title[index])));
              })));

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
                borderSide: const BorderSide(color: Colors.transparent)),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: Colors.transparent)),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: Colors.transparent)),
            filled: true,
            fillColor: Colors.grey[200],
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 20, vertical: 10)),
      ),
    ));
  }
}
