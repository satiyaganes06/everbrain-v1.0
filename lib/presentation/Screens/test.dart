import 'package:flutter/material.dart';

class Test extends StatefulWidget {
  const Test({Key? key}) : super(key: key);

  @override
  State<Test> createState() => _TestState();
}

class _TestState extends State<Test> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // body: DelayedDisplay(
      //                 delay: const Duration(milliseconds: 200),
      //                 child: Stack(
      //                   children: [
      //                     Container(
      //                       margin: const EdgeInsets.symmetric(vertical: 30, horizontal: 30),
      //                       child: GetBuilder<AddNewAccountController>(builder: (addNewAccountController){
      //                           return CircleAvatar(
      //                           radius: 61,
      //                           backgroundColor: colors.AppColor.light_grey,
      //                           child: CircleAvatar(
      //                             radius: 55,
      //                             backgroundColor: colors.AppColor.splashColor,
      //                             backgroundImage: _buildImage(),
      //                           ),
      //                         );
      //                       }),
      //                       decoration: BoxDecoration(
      //                         shape: BoxShape.circle,
      //                         boxShadow: [
      //                           BoxShadow(
      //                             color: colors.AppColor.shadowColor,
      //                             offset: const Offset(1, 2),
      //                             blurRadius: 5,
      //                             spreadRadius: 0.6,
      //                           ), //BoxShadow
      //                         ],
      //                       ),
      //                     ),
      //                     Positioned(
      //                         top: 105,
      //                         left: 100,
      //                         child: RawMaterialButton(
      //                           elevation: 10,
      //                           fillColor: colors.AppColor.accentColor,
      //                           padding: const EdgeInsets.all(15.0),
      //                           shape: const CircleBorder(),
      //                           onPressed: () {
      //                             showDialog(
      //                                 context: context,
      //                                 builder: (BuildContext context) {
      //                                   return AlertDialog(
      //                                     title: Text(
      //                                       'Choose option',
      //                                       style: TextStyle(
      //                                           fontWeight: FontWeight.w600,
      //                                           color: colors.AppColor.accentColor
      //                                       ),
      //                                     ),
      //                                     content: SingleChildScrollView(
      //                                       child: ListBody(
      //                                         children: [
                                                
      //                                           InkWell(
      //                                             onTap: (){
      //                                               addNewAccountController.pickImageGallery();
      //                                             },
      //                                             splashColor: colors.AppColor.splashColor,
      //                                             child: Row(
      //                                               children: [
      //                                                 Padding(
      //                                                   padding:
      //                                                       const EdgeInsets.all(8.0),
      //                                                   child: Icon(
      //                                                     Icons.image,
      //                                                     color: colors.AppColor.secondaryColor,
      //                                                   ),
      //                                                 ),
      //                                                 const Text(
      //                                                   'Gallery',
      //                                                   style: TextStyle(
      //                                                       fontSize: 18,
      //                                                       fontWeight:
      //                                                           FontWeight.w500,
      //                                                       color:
      //                                                           Colors.black),
      //                                                 )
      //                                               ],
      //                                             ),
      //                                           ),
      //                                             InkWell(
      //                                             onTap: (){
      //                                               Get.back();
      //                                               showDialog(
      //                                                 context: context,
      //                                                 builder: (context) {
      //                                                   return AlertDialog(
      //                                                     title: Text('Enter website name'),
      //                                                     content: TextField(
      //                                                       controller: addNewAccountController.searchCompanyName,
      //                                                       decoration: InputDecoration(hintText: "instagram"),
      //                                                     ),
      //                                                     actions: <Widget>[
      //                                                       FlatButton(
      //                                                         child: Text('Discard'),
      //                                                         onPressed: () {
      //                                                           Get.back();
      //                                                         },
      //                                                       ),
      //                                                       FlatButton(
      //                                                         child: Text('Search'),
      //                                                         onPressed: () {
      //                                                           addNewAccountController.pickImageOnline();
                                                                
      //                                                         },
      //                                                       ),
      //                                                     ],
      //                                                   );
      //                                                 },
      //                                               );
      //                                             },
      //                                             splashColor: colors.AppColor.splashColor,
      //                                             child: Row(
      //                                               children: [
      //                                                 Padding(
      //                                                   padding:
      //                                                       const EdgeInsets.all(8.0),
      //                                                   child: Icon(
      //                                                     Icons.cloud_download_rounded,
      //                                                     color: colors.AppColor.secondaryColor,
      //                                                   ),
      //                                                 ),
      //                                                 const Text(
      //                                                   'Online',
      //                                                   style: TextStyle(
      //                                                       fontSize: 18,
      //                                                       fontWeight:
      //                                                           FontWeight.w500,
      //                                                       color:
      //                                                           Colors.black),
      //                                                 )
      //                                               ],
      //                                             ),
      //                                           ),
      //                                             InkWell(
      //                                             onTap: (){
      //                                               addNewAccountController.remove();
      //                                             },
      //                                             splashColor: colors.AppColor.splashColor,
      //                                             child: Row(
      //                                               children: [
      //                                                 Padding(
      //                                                   padding:
      //                                                       const EdgeInsets.all(8.0),
      //                                                   child: Icon(
      //                                                     Icons.remove_circle,
      //                                                     color: colors.AppColor.fail,
      //                                                   ),
      //                                                 ),
      //                                                 Text(
      //                                                   'Remove',
      //                                                   style: TextStyle(
      //                                                       fontSize: 18,
      //                                                       fontWeight:
      //                                                           FontWeight.w500,
      //                                                       color: colors.AppColor.fail),
      //                                                 )
      //                                               ],
      //                                             ),
      //                                           ),
      //                                         ],
      //                                       ),
      //                                     ),
      //                                   );
      //                                 });
      //                           },
      //                           child: Icon(
      //                             Icons.add,
      //                             color: colors.AppColor.primaryColor,
      //                           ),
      //                         ))
      //                       ],
      //                     ),
      //               )
    );
  }
}