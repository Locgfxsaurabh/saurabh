import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class Loading extends StatelessWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        width: 1.sw,
        height: 1.sh,
        color: Colors.white.withOpacity(0.2),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
                child: Text(
              "Please wait\n while loading",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 25, color: Colors.grey[600]),
              // style: AppTextStyle().textColor29292924w700.copyWith(fontSize: 25,color: Colors.grey[600]
            )),
            SizedBox(height: 30),
            Center(
              child: LoadingAnimationWidget.inkDrop(
                size: 40,
                color: Colors.yellow,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DotsLoader extends StatelessWidget {
  const DotsLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0),
      child: Center(
        child: LoadingAnimationWidget.waveDots(
          size: 70,
          color: Colors.yellow,
        ),
      ),
    );
  }
}
