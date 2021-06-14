import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mdp/constants/app_colors.dart';
import 'package:mdp/constants/styles/app_styles.dart';
import 'package:mdp/widgets/gradients/md_gradient.dart';

class MotifRefusWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MotifRefusWidgetState();
}

class _MotifRefusWidgetState extends State<MotifRefusWidget> {

  @override
  Widget build(BuildContext context) {
    return  Container(
      height: 380,
      padding:
      EdgeInsets.symmetric(horizontal: 15, vertical: 20),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  "Souhaitez-vous ajouter un motif de refus ?",
                  style: AppStyles.header1,
                  textAlign: TextAlign.left,
                  overflow: TextOverflow.clip,
                  maxLines: 3,
                ),
              ),
              SizedBox(width: 20),
              InkWell(
                onTap: () {
                  Modular.to.pop();
                },
                child: Align(
                  alignment: Alignment.topRight,
                  child: Icon(
                    Icons.close_outlined,
                    size: 25,
                    color: AppColors.closeDialogColor,
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 15),
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.white,
                border: Border.all(
                  color: AppColors.md_gray,
                  width: 1,
                ),
              ),
              width: double.infinity,
              height: 200,
              child: Align(
                alignment: Alignment.topLeft,
                child: TextFormField(
                  //controller: ,
                  obscureText: false,
                  cursorColor: AppColors.default_black,
                  keyboardType: TextInputType.multiline,
                  expands: true,
                  maxLines: null,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.only(
                        bottom: 10.0,
                        left: 10.0,
                        right: 10.0,
                        top: 10.0),
                    errorStyle: TextStyle(height: 0),
                    hintText: "Commentaires facultatifs ...",
                    hintStyle: AppStyles.textNormalPlaceholder,
                  ),
                  style: AppStyles.textNormal,
                  validator: (String value) {},
                ),
              ),
            ),
          ),
          ElevatedButton(
            child: Ink(
              decoration: BoxDecoration(
                color: AppColors.md_dark_blue,
                borderRadius: BorderRadius.all(
                  Radius.circular(12),
                ),
              ),
              child: Container(
                alignment: Alignment.center,
                width: double.infinity,
                height: 55,
                child: Text(
                  "J'ENVOIE LE REFUS",
                  style: AppStyles.smallTitleWhite,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
            onPressed: () {},
            style: ElevatedButton.styleFrom(
                elevation: 5,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                onPrimary: AppColors.white,
                primary: Colors.transparent,
                padding: EdgeInsets.zero,
                textStyle: TextStyle(
                    fontSize: 30, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }

}