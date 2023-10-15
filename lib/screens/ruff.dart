// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';
// import 'package:saurabh_xicom_test/screens/product_details.dart';
// import 'package:shimmer/shimmer.dart';
//
// import '../apis/get_images_api.dart';
// import '../globals/loader.dart';
// import '../models/get_images_model.dart';
//
// class Home extends StatefulWidget {
//   const Home({Key? key}) : super(key: key);
//
//   @override
//   State<Home> createState() => _HomeState();
// }
//
// class _HomeState extends State<Home> {
//   @override
//   void initState() {
//     getFriends();
//     super.initState();
//   }
//
//   bool isLoading = false;
//
//   List<GetImagesModel> getImages = [];
//
//   int scroll = 1;
//   int scrollLength = 10;
//
//   getFriends() {
//     // isLoading = true;
//     var resp = getImagesApi(load: '1');
//     getImages.clear();
//
//     resp.then((value) {
//       if (mounted) {
//         // getImages.clear();
//
//         if (value['status'] == 'success') {
//           setState(() {
//             // friendList.add(NewModelFriend.fromJson(value));
//             for (var v in value['images']) {
//               getImages.add(GetImagesModel.fromJson(v));
//             }
//             scrollLength = value["images"].length;
//             isLoading = false;
//           });
//         }
//         // else {
//         //   setState(() {
//         //     isLoading = false;
//         //   });
//         //
//         //   // isLoading = false;
//         // }
//       }
//     });
//   }
//
//   loadmore() {
//     scroll++;
//     // getImages.clear();
//     // isLoading = true;
//     var resp = getImagesApi(load: scroll.toString());
//
//     resp.then((value) {
//       if (mounted) {
//         // getImages.clear();
//         // scrollLength = value["images"].length;
//         if (value['status'] == 'success') {
//           setState(() {
//             // friendList.add(NewModelFriend.fromJson(value));
//             for (var v in value['images']) {
//               getImages.add(GetImagesModel.fromJson(v));
//               // getFriends();
//             }
//             scrollLength = value["images"].length;
//             isLoading = false;
//           });
//         }
//         // else {
//         //   setState(() {
//         //     isLoading = false;
//         //   });
//         //
//         //   // isLoading = false;
//         // }
//       }
//     });
//   }
//
//   bool loading = false;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         elevation: 0,
//         automaticallyImplyLeading: false,
//         title: Text(
//           "All Products",
//           style: TextStyle(color: Colors.black),
//         ),
//         leadingWidth: 40,
//         // leading: Padding(
//         //   padding: const EdgeInsets.only(left: 20),
//         //   child: InkWell(
//         //     onTap: () {
//         //       Navigator.pop(context);
//         //     },
//         //     child: SvgPicture.asset(
//         //       "assets/icons/arrowback.svg",
//         //     ),
//         //   ),
//         // ),
//       ),
//       body: isLoading
//           ? Loading()
//           : Padding(
//         padding: const EdgeInsets.only(
//             left: 10, right: 10, top: 16, bottom: 16),
//         child: LazyLoadScrollView(
//           isLoading: isLoading,
//           scrollDirection: Axis.vertical,
//           onEndOfPage: () {
//             if (scrollLength >= 10) {
//               loadmore();
//             }
//           },
//           child: ListView.separated(
//             itemCount: getImages.length + 1,
//             shrinkWrap: true,
//             // physics: NeverScrollableScrollPhysics(),
//             itemBuilder: (context, i) {
//               if (i < getImages.length) {
//                 return GestureDetector(
//                   onTap: () {
//                     Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                             builder: (context) => ProductDetails(
//                               image: getImages[i].xtImage.toString(),
//                               id: getImages[i].id.toString(),
//                             )));
//                   },
//                   child: Container(
//                     clipBehavior: Clip.hardEdge,
//                     decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(20),
//                         border: Border.all(
//                           width: 1,
//                         )),
//                     height: 180.h,
//                     width: 1.sw,
//                     child: CachedNetworkImage(
//                       imageUrl: getImages[i].xtImage.toString(),
//                       fit: BoxFit.cover,
//                       errorWidget: (context, url, error) =>
//                           Icon(Icons.error),
//                       progressIndicatorBuilder: (a, b, c) => Opacity(
//                         opacity: 0.3,
//                         child: Shimmer.fromColors(
//                           baseColor: Colors.black12,
//                           highlightColor: Colors.white,
//                           child: Container(
//                             width: 1.sw,
//                             height: 180.h,
//                             //margin: EdgeInsets.symmetric(horizontal: 24),
//                             decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(40),
//                               color: Colors.white,
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                 );
//                 ;
//               } else if (scrollLength >= 10 && isLoading) {
//                 return Center(child: CircularProgressIndicator());
//               } else if (scrollLength < 10) {
//                 return SizedBox.shrink();
//               } else {
//                 return Center(child: CircularProgressIndicator());
//               }
//               // return GestureDetector(
//               //   onTap: () {
//               //     Navigator.push(
//               //         context,
//               //         MaterialPageRoute(
//               //             builder: (context) => ProductDetails(
//               //                   image:
//               //                       getImages[i].xtImage.toString(),
//               //                   id: getImages[i].id.toString(),
//               //                 )));
//               //   },
//               //   child: Container(
//               //     clipBehavior: Clip.hardEdge,
//               //     decoration: BoxDecoration(
//               //         borderRadius: BorderRadius.circular(20),
//               //         border: Border.all(
//               //           width: 1,
//               //         )),
//               //     height: 180.h,
//               //     width: 1.sw,
//               //     child: CachedNetworkImage(
//               //       imageUrl: getImages[i].xtImage.toString(),
//               //       fit: BoxFit.cover,
//               //       errorWidget: (context, url, error) =>
//               //           Icon(Icons.error),
//               //       progressIndicatorBuilder: (a, b, c) => Opacity(
//               //         opacity: 0.3,
//               //         child: Shimmer.fromColors(
//               //           baseColor: Colors.black12,
//               //           highlightColor: Colors.white,
//               //           child: Container(
//               //             width: 1.sw,
//               //             height: 180.h,
//               //             //margin: EdgeInsets.symmetric(horizontal: 24),
//               //             decoration: BoxDecoration(
//               //               borderRadius: BorderRadius.circular(40),
//               //               color: Colors.white,
//               //             ),
//               //           ),
//               //         ),
//               //       ),
//               //     ),
//               //   ),
//               // );
//             },
//             separatorBuilder: (BuildContext context, int index) =>
//                 SizedBox(
//                   height: 16,
//                 ),
//           ),
//         ),
//       ),
//     );
//   }
// }
