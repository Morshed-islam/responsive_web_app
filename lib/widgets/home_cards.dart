import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

class HomeCard extends StatelessWidget {
  final double? height;
  final double? width;
  final EdgeInsets? margin;
  final Color? color;
  final String? value;
  final String? title;
  final String? icon;
  final bool? isActionButton;
  final VoidCallback? onPressed;

  const HomeCard({super.key, this.height, this.width, this.margin, this.color, this.value, this.title, this.icon, this.isActionButton=false, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: SizedBox(
        // margin: margin ?? const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
        height: height ?? 200,
        width: width ?? 200,
        // decoration: BoxDecoration(
        //   // color: color ?? Colors.amber,
        //   color: Colors.white,
        //   borderRadius: BorderRadius.circular(6),
        // ),
        child: Card(
          elevation: 1,
          color: Colors.white,
          surfaceTintColor: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Lottie.network(
              //     'https://raw.githubusercontent.com/xvrh/lottie-flutter/master/example/assets/Mobilo/A.json',width: 40,height: 50),
              const SizedBox(height: 10,),

              // Lottie.asset("$icon",height: 90),
             SvgPicture.asset(icon ?? "",width: 90,height: 90,),
              const SizedBox(height: 10,),
              Text("$title ",style: GoogleFonts.lato(
                textStyle: const TextStyle(color: Colors.black, letterSpacing: .5,fontSize: 18),
              ),),
              isActionButton == false ? Text(value ?? '00',style: GoogleFonts.poppins(
                textStyle: const TextStyle(color: Colors.black, letterSpacing: .5,fontSize: 16),
              ),): const SizedBox.shrink(),
            ],
          ),
        ),
      ),
    );
  }
}
