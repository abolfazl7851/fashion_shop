
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../common/utils/kcolors.dart';
import '../../../common/widgets/app_style.dart';
import '../../../common/widgets/back_button.dart';
import '../../../common/widgets/reusable_text.dart';


class VerifyPaymentScreen extends StatefulWidget {
  const VerifyPaymentScreen({super.key});

  @override
  State<VerifyPaymentScreen> createState() => _VerifyPaymentScreenState();
}

class _VerifyPaymentScreenState extends State<VerifyPaymentScreen> {


  // Map<String, dynamic> data = {} ;
  @override
  void initState() {
    // TODO: implement initState
     super.initState();


    // final applinks = AppLinks();
    // applinks.uriLinkStream.listen((uri){
    //   // data = jsonDecode(uri.toString()) as Map<String , dynamic> ;
    //   print('print uri: ${uri.toString()}');
    // });
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(appBar: AppBar(
      centerTitle: true,
      title: ReusableText(
          text: "Verify Payment",
          style: appStyle(16, Kolors.kPrimary, FontWeight.bold)),
      leading: AppBackButton(
        onTap: () {
          //clear the address
          context.go('/home');
        },
      ),
    ),body: const Center());
  }
}
