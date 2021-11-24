import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mdp/constants/app_colors.dart';
import 'package:mdp/constants/app_images.dart';
import 'package:mdp/constants/styles/app_styles.dart';
import 'package:mdp/ui/login/login_screen.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:splashscreen/splashscreen.dart';

class SplashScreenWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SplashScreenWidgetState();
}

class _SplashScreenWidgetState extends State<SplashScreenWidget> {
  Future<PackageInfo> packageInfo;

  @override
  void initState() {
    _getPackageInfo();
    super.initState();
  }

  _getPackageInfo() async {
    return await PackageInfo.fromPlatform();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Container(
        color: AppColors.white,
        child: Column(
          children: [
            Expanded(
              child: SplashScreen(
                  seconds: 2,
                  navigateAfterSeconds: LoginScreenWidget(),
                  //title: ,
                  image: Image.asset(AppImages.appLogo),
                  backgroundColor: AppColors.white,
                  styleTextUnderTheLoader: new TextStyle(),
                  photoSize: 100.0,
                  onClick: () => print("MDP"),
                  loaderColor: AppColors.md_dark_blue),
            ),
            Container(
              color: AppColors.white,
              margin: EdgeInsets.all(50),
              child: FutureBuilder(
                  future: _getPackageInfo(),
                  builder: (context, AsyncSnapshot snapshot) {
                    if (snapshot.hasData) {
                      return Center(
                        child: Text(
                          "Version " + snapshot.data.version,
                          style: AppStyles.bodyHint,
                        ),
                      );
                    } else {
                      return Center(
                        child: Text(""),
                      );
                    }
                  }),
            )
          ],
        ),
      ),
    );
  }
}
