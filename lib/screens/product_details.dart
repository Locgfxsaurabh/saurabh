import 'dart:async';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shimmer/shimmer.dart';

import '../apis/send_data_api.dart';
import '../globals/widgets.dart';

class ProductDetails extends StatefulWidget {
  final String image;
  final String id;
  const ProductDetails({
    Key? key,
    required this.image,
    required this.id,
  }) : super(key: key);

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();

  bool show = false;

  @override
  void initState() {
    super.initState();
    downloadAndSaveImage();
  }

  late String localImagePath;

  Future<void> downloadAndSaveImage() async {
    final documentDirectory = await getApplicationDocumentsDirectory();
    final filePath = '${documentDirectory.path}/image.png';
    File file = File(filePath);
    await file.writeAsString(widget.image);
    if (mounted) {
      setState(() {
        localImagePath = filePath;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextFieldUnFocusOnTap(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          automaticallyImplyLeading: false,
          title: Text(
            "Product details",
            style: TextStyle(color: Colors.black),
          ),
          leadingWidth: 40,
          leading: Padding(
            padding: const EdgeInsets.only(left: 20),
            child: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: SvgPicture.asset(
                "assets/icons/arrowback.svg",
              ),
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding:
                const EdgeInsets.only(left: 10, right: 10, top: 16, bottom: 16),
            child: Column(
              children: [
                Container(
                  clipBehavior: Clip.hardEdge,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        width: 1,
                      )),
                  height: 180.h,
                  width: 1.sw,
                  child: CachedNetworkImage(
                    imageUrl: widget.image.toString(),
                    fit: BoxFit.cover,
                    errorWidget: (context, url, error) => Icon(Icons.error),
                    progressIndicatorBuilder: (a, b, c) => Opacity(
                      opacity: 0.3,
                      child: Shimmer.fromColors(
                        baseColor: Colors.black12,
                        highlightColor: Colors.white,
                        child: Container(
                          width: 1.sw,
                          height: 180.h,
                          //margin: EdgeInsets.symmetric(horizontal: 24),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(40),
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                // GestureDetector(
                //   onTap: () async {
                //     XFile? v =
                //         await _imgPicker.pickImage(source: ImageSource.gallery);
                //     if (v != null) {
                //       setState(
                //         () {
                //           pickedImage = File(v.path);
                //         },
                //       );
                //     }
                //     print(pickedImage);
                //   },
                //   child: Stack(
                //     children: [
                //       CircleAvatar(
                //         radius: 50,
                //         backgroundColor: Colors.grey,
                //         child: ClipOval(
                //           child: pickedImage.path.isEmpty
                //               ? Image.asset(
                //                   'assets/icons/Frame1000002321.png',
                //                   fit: BoxFit.cover,
                //                 )
                //               : Image.file(
                //                   pickedImage,
                //                   width: 1.sw,
                //                   height: 420,
                //                   fit: BoxFit.cover,
                //                 ),
                //         ),
                //       ),
                //       Positioned(
                //         top: 60,
                //         right: 0.0,
                //         child: Image.asset(
                //           'assets/icons/Frame1000003015.png',
                //           // color: k8267AC,
                //         ),
                //       ),
                //     ],
                //   ),
                // ),
                SizedBox(
                  height: 20,
                ),
                DataField(
                  name: 'First Name',
                  child: TextFormField(
                    onChanged: (v) {
                      setState(() {});
                    },
                    controller: firstNameController,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Enter your first name",
                    ),
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                DataField(
                  name: 'Last Name',
                  child: TextFormField(
                    onChanged: (v) {
                      setState(() {});
                    },
                    controller: lastNameController,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Enter your Last name",
                    ),
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                DataField(
                  name: 'Email',
                  child: TextFormField(
                    onChanged: (v) {
                      setState(() {});
                    },
                    controller: emailController,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Enter your Email",
                    ),
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                DataField(
                  name: 'Phone',
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    onChanged: (val) {
                      setState(() {
                        if (phoneController.text.trim().length == 10) {
                          FocusScope.of(context).unfocus();
                        }
                      });
                    },
                    controller: phoneController,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Enter your Phone no",
                    ),
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: GestureDetector(
                    onTap: () {
                      // if (emailController.text.contains("@")) {
                      if (firstNameController.text.isNotEmpty &&
                          lastNameController.text.isNotEmpty &&
                          emailController.text.isNotEmpty &&
                          phoneController.text.isNotEmpty) {
                        if (emailController.text.contains("@")) {
                          setState(() {
                            show = !show;
                          });
                          Timer timer = Timer(Duration(seconds: 2), () {
                            setState(() {
                              show = false;
                            });
                          });
                          setState(() {});
                          submitData(
                            photo: localImagePath,
                            firstName: firstNameController.text,
                            lastName: lastNameController.text,
                            email: emailController.text,
                            phone: phoneController.text,
                          ).then((value) async {
                            if (value['status'] == 'success') {
                              Fluttertoast.showToast(msg: value['message']);
                            } else {
                              Fluttertoast.showToast(msg: value['message']);
                            }
                          });
                        } else {
                          Fluttertoast.showToast(
                              msg: 'Please Enter a valid email');
                        }
                      } else {
                        Fluttertoast.showToast(msg: 'Please Add All Details');
                      }
                    },
                    child: show
                        ? Container(
                            height: 50,
                            width: 1.sw,
                            decoration: BoxDecoration(
                              color: Colors.black87,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Center(
                              child: LoadingAnimationWidget.waveDots(
                                size: 40,
                                // color: ColorSelect.colorF7E641,
                                color: Colors.white,
                              ),
                            ),
                          )
                        : Container(
                            height: 50,
                            width: 1.sw,
                            decoration: BoxDecoration(
                              color: Colors.black87,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Center(
                              child: Text(
                                "Submit",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class DataField extends StatefulWidget {
  final String name;
  final Widget child;
  const DataField({Key? key, required this.name, required this.child})
      : super(key: key);

  @override
  State<DataField> createState() => _DataFieldState();
}

class _DataFieldState extends State<DataField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Expanded(child: Text(widget.name)),
          Expanded(
            flex: 3,
            child: Container(
              height: 50,
              width: 328.w,
              decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.40),
                  borderRadius: BorderRadius.all(Radius.circular(8))),
              child: Padding(
                padding: const EdgeInsets.only(left: 20),
                child: widget.child,
              ),
            ),
          )
        ],
      ),
    );
  }
}
