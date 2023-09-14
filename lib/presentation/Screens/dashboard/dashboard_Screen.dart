import 'package:animations/animations.dart';
import 'package:auto_animated/auto_animated.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:delayed_display/delayed_display.dart';
import 'package:everbrain/Controller/dashboard_controller.dart';
import 'package:everbrain/presentation/Widget/pageTitle.dart';
import 'package:everbrain/presentation/Widget/category_button.dart';
import 'package:everbrain/presentation/Widget/passwords_item.dart';
import 'package:everbrain/presentation/Widget/space.dart';
import 'package:flutter/material.dart';
import 'package:everbrain/utils/colors.dart' as colors;
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../Controller/login_controller.dart';
import '../../Widget/custom_appbar.dart';
import '../accountOpt/addAccount/add_new_account.dart';
import 'package:flutter_scrolling_fab_animated/flutter_scrolling_fab_animated.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final dashboardController = Get.put(DashboardController());
  final loginController = Get.find<LoginController>();
  bool isScroll = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Container(
                color: colors.AppColor.secondaryColor,
                child: NotificationListener<UserScrollNotification>(
                    onNotification: (notification) {
                      return dashboardController
                          .scrollingCheck(notification.direction);
                    },
                    child: CustomScrollView(
                        physics: const BouncingScrollPhysics(),
                        controller: dashboardController.scrollController,
                        slivers: [
                          CustomAppBar(),
                          buildTitle("Categories"),
                          buildCategoriesButtons(),
                          buildTitle('Passwords'),
                          buildPasswordList(context),
                        ])))),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: ScrollingFabAnimated(
        icon: const Icon(Icons.add, color: Colors.white,),
        text: const Text('Add Vault', style: TextStyle(color: Colors.white, fontSize: 14.0),),
        onPress: (){
          Get.to(AddNewAccount());
        },
        scrollController: dashboardController.scrollController,
        animateIcon: true,
        inverted: false,
        width: Get.width*0.4,
        radius: 150,
        color: colors.AppColor.tertiaryColor,
      ));
  }

  // Widget simpleFloatActionBar(BuildContext context) {
  //   return AnimatedContainer(
  //       duration: const Duration(milliseconds: 200),
  //       curve: Curves.linear,
  //       width: 50,
  //       height: 50,
  //       child: OpenContainer(
  //         transitionDuration: const Duration(milliseconds: 500),
  //         closedShape: const CircleBorder(),
  //         closedColor: const Color.fromARGB(255, 36, 56, 70),
  //         closedBuilder: (context, openContainer) => Container(
  //           decoration: const BoxDecoration(
  //             shape: BoxShape.circle,
  //             color: Color.fromARGB(255, 36, 56, 70),
  //           ),
  //           height: 56,
  //           width: 56,
  //           child: Icon(
  //             Icons.add,
  //             color: colors.AppColor.secondaryColor,
  //           ),
  //         ),
  //         openBuilder: (context, _) => AddNewAccount(),
  //       ));
  // }

  // Widget fabFloatActionBar(BuildContext context) {
  //   return OpenContainer(
  //         transitionDuration: const Duration(milliseconds: 500),
  //         closedShape: const RoundedRectangleBorder(
  //             borderRadius: BorderRadius.all(Radius.circular(50.0))),
  //         closedColor: const Color.fromARGB(255, 36, 56, 70),
  //         closedBuilder: (context, openContainer) => Container(
  //           decoration: const BoxDecoration(
  //             shape: BoxShape.circle,
  //             color: Color.fromARGB(255, 36, 56, 70),
  //           ),
  //           height: 150,
  //           width: 50,
  //           child: ListView(
  //               scrollDirection: Axis.horizontal,
  //               padding:
  //                   const EdgeInsets.symmetric(vertical: 10, horizontal: 22),
  //               children: [
  //                 Icon(
  //                   Icons.add,
  //                   color: colors.AppColor.secondaryColor,
  //                   size: 20,
  //                 ),
  //                 Padding(
  //                     padding: const EdgeInsets.only(left: 5, top: 7),
  //                     child: AutoSizeText('Add Account',
  //                         minFontSize: 11,
  //                         maxFontSize: 11,
  //                         style: GoogleFonts.poppins(
  //                             fontWeight: FontWeight.bold, color: Colors.white),
  //                         overflow: TextOverflow.fade)),
  //               ]),
  //         ),
  //         openBuilder: (context, _) => AddNewAccount(),
  //       );
  // }

  // Widget fabFloatActionBar2() {
  //   return SizedBox(
  //           child: FloatingActionButton.extended(
  //         icon: const Icon(Icons.add),
  //         backgroundColor: const Color.fromARGB(255, 36, 56, 70),
  //         onPressed: () {
  //           Get.to(AddNewAccount());
  //         },
  //         isExtended: dashboardController.isScroll.value,
  //         label: Text(
  //           'Add Account',
  //           style: GoogleFonts.poppins(
  //               fontSize: 11, fontWeight: FontWeight.bold, color: Colors.white),
  //         ),
  //         tooltip: 'Add Account',
  //       ));
  // }

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
    return GetBuilder<DashboardController>(
        id: 'list_of_vault',
        builder: (_) {
          return dashboardController.vaultList.isEmpty
              ? SliverToBoxAdapter(
                  child: Center(
                    heightFactor:20,
                  child: Text("No vault yet",
                      style: GoogleFonts.poppins(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: colors.AppColor.accentColor,
                          letterSpacing: 1)),
                ))
              : LiveSliverList(
                  controller: dashboardController.scrollController,
                  showItemDuration: dashboardController.listShowItemDuration,
                  itemBuilder: buildAnimatedPasswordList,
                  // Other properties correspond to the `ListView.builder` / `ListView.separated` widget
                  itemCount: dashboardController.vaultList.length,
                );
        });
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
            child:
                PasswordItem(vaultInfo: dashboardController.vaultList[index])));
  }
}
